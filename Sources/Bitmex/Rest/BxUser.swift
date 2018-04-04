//
//  BxUser.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-03-09.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation

public enum BxTransactionType: String, Codable {
    case deposit = "Deposit"
    case realisedPNL = "RealisedPNL"
    case withdrawal = "Withdrawal"
    case total = "Total"
}

// MARK - Request

public extension BxRestAPI {
    /** User : Account Operations */
    public var user: User {
        return User(api: self)
    }

    public struct User {
        private let api: BxRestAPI

        public init(api: BxRestAPI) {
            self.api = api
        }

        /** Get your user model */
        public var get: BxRequest<BxResponse.User, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "user", security: .signature)
        }

        /** Update your password, name, and other attributes */
        public func update(firstname: String? = nil, lastname: String? = nil, password: BxPassword? = nil, username: String? = nil, country: String? = nil, pgpPubKey: String? = nil) -> BxRequest<BxResponse.User, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            let miscParams = ["firstname" : firstname, "lastname": lastname, "username" : username, "country" : country, "pgpPubKey" : pgpPubKey]
            let passwordParams = ["password" : password?.old, "passwordNew" : password?.new, "passwordNewConfirm" : password?.confirmNew]
            return BxRequest(api: api, endpoint: "user", method: .put, security: .signature, params: miscParams.merging(passwordParams) { $1 })
        }

        /** Get your current affiliate/referral status */
        public var affiliateStatus: BxRequest<BxResponse.User.AffiliateStatus, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "user/affiliateStatus", security: .signature)
        }

        /** Cancel a withdrawal */
        public func cancelWithdrawal(token: String) -> BxRequest<BxResponse.User.CancelWithdrawal, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "user/cancelWithdrawals", method: .post, security: .signature, params: ["token" : token])
        }

        /** Check if a referral code is valid */
        public func checkReferralCode(_ referralCode: String) -> BxRequest<BxResponse.User.CheckReferralCode, BxParameters.None, BxNo, BxNo, BxColumns.Default> {
            return BxRequest(api: api, endpoint: "user/checkReferralCode", params: ["referralCode" : referralCode])
        }

        /** Get your account's commission status */
        public var commission: BxRequest<[BxResponse.User.Commission], BxParameters.None, BxNo, BxNo, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "user/commission", security: .signature)
        }

        /** Confirm your email address with a token */
        public func confirmEmail(token: String) -> BxRequest<BxResponse.User.ConfirmEmail, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "user/confirmEmail", method: .post, security: .signature, params: ["token" : token])
        }

        /** Confirm two-factor auth for this account. If using a Yubikey, simply send a token to this endpoint */
        public func confirmEnableTFA(type: BxTFAType, token: String) -> BxRequest<BxResponse.User.ConfirmEnableTFA, BxParameters.None, BxNo, BxNo, BxColumns.Default> {
            return BxRequest(api: api, endpoint: "user/confirmEnableTFA", method: .post, security: .signature, params: ["type" : type, "token" : token])
        }

        /** Confirm a withdrawal */
        public func confirmWithdrawal(token: String) -> BxRequest<BxResponse.User.ConfirmWithdrawal, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "user/confirmWithdrawal", method: .post, params: ["token" : token])
        }

        // FIXME: what happens without currency?
        /** Get a deposit address */
        public func depositAddress(currency: BxCurrency) -> BxRequest<BxResponse.User.DepositAddress, BxParameters.None, BxNo, BxNo, BxColumns.Default> {
            return BxRequest(api: api, endpoint: "user/depositAddress", method: .post, security: .signature, params: ["currency" : currency])
        }

        /** Disable two-factor auth for this account */
        public func disableTFA(type: BxTFAType, token: String) -> BxRequest<BxResponse.User.DisableTFA, BxParameters.None, BxNo, BxNo, BxColumns.Default> {
            return BxRequest(api: api, endpoint: "user/disableTFA", method: .post, security: .signature, params: ["type" : type, "token" : token])
        }

        /** Log out of BitMEX */
        public var logout: BxRequest<BxResponse.User.Logout, BxParameters.None, BxNo, BxNo, BxColumns.Default> {
            return BxRequest(api: api, endpoint: "user/logout", method: .post)
        }

        /** Log all systems out of BitMEX. This will revoke all of your account's access tokens, logging you out on all devices */
        public var logoutAll: BxRequest<BxResponse.User.LogoutAll, BxParameters.None, BxNo, BxNo, BxColumns.Default> {
            return BxRequest(api: api, endpoint: "user/logoutAll", method: .post, security: .signature)
        }

        /** Get your account's margin status. Sends an array of all supported currencies */
        public var margin: BxRequest<[BxResponse.User.Margin], BxParameters.None, BxNo, BxNo, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "user/margin", security: .signature, params: ["currency" : "all"])
        }

        /** Get your account's margin status for a specific currency */
        public func margin(currency: BxCurrency) -> BxRequest<BxResponse.User.Margin, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "user/margin", security: .signature, params: ["currency" : currency])
        }

        /** Get the minimum withdrawal fee for a currency */
        public func minWithdrawalFee(currency: BxCurrency) -> BxRequest<BxResponse.User.WithdrawalFee, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "user/minWithdrawalFee", params: ["currency" : currency])
        }

        // FIXME: How to send prefs?
        /** Save user preferences */
        public func savePreferences(_ prefs: BxPreferences) -> BxRequest<BxResponse.User, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "user/preferences", method: .post, security: .signature, params: ["prefs" : prefs])
        }

        /** Get secret key for setting up two-factor auth */
        public func requestEnableTFA(_ type: BxTFAType) -> BxRequest<BxResponse.User.RequestEnableTFA, BxParameters.None, BxNo, BxNo, BxColumns.Default> {
            return BxRequest(api: api, endpoint: "user/requestEnableTFA", method: .post, security: .signature, params: ["type" : type])
        }

        /** Request a withdrawal to an external wallet */
        public func requestWithdrawal(otpToken: String? = nil, currency: BxCurrency, amount: Int, address: String, fee: Double? = nil) -> BxRequest<BxResponse.User.RequestWithdrawal, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            let params: BxParams = ["otpToken" : otpToken, "currency" : currency, "amount" : amount, "address" : address, "fee" : fee]
            return BxRequest(api: api, endpoint: "user/requestWithdrawal", method: .post, security: .signature, params: params)
        }

        /** Get your current wallet information */
        public var wallet: BxRequest<BxResponse.User.Wallet, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "user/wallet", security: .signature)
        }

        /** Get your current wallet information for a spcific currency */
        public func wallet(currency: BxCurrency) -> BxRequest<BxResponse.User.Wallet, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "user/wallet", security: .signature, params: ["currency" : currency])
        }

        /** Get a history of all of your wallet transactions (deposits, withdrawals, PNL) */
        public var walletHistory: BxRequest<[BxResponse.User.WalletHistory], BxParameters.None, BxNo, BxNo, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "user/walletHistory", security: .signature)
        }

        /** Get a history of all of your wallet transactions for a specific currency (deposits, withdrawals, PNL) */
        public func walletHistory(currency: BxCurrency) -> BxRequest<[BxResponse.User.WalletHistory], BxParameters.None, BxNo, BxNo, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "user/walletHistory", security: .signature, params: ["currency" : currency])
        }

        /** Get a summary of all of your wallet transactions (deposits, withdrawals, PNL) */
        public var walletSummary: BxRequest<[BxResponse.User.WalletSummary], BxParameters.None, BxNo, BxNo, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "user/walletSummary", security: .signature)
        }

        /** Get a summary of all of your wallet transactions for a specific currency (deposits, withdrawals, PNL) */
        public func walletSummary(currency: BxCurrency) -> BxRequest<[BxResponse.User.WalletSummary], BxParameters.None, BxNo, BxNo, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "user/walletSummary", security: .signature, params: ["currency" : currency])
        }
    }
}

// MARK - Response

public extension BxResponse {
    public struct User: Decodable {
        let id: Double
        let ownerId: Double?
        let firstname: String
        let lastname: String
        let username: String
        let email: String
        let phone: String?
        let created: Date
        let lastUpdated: Date
        let preferences: BxPreferences
        let TFAEnabled: String
        let affiliateID: String
        let pgpPubKey: String?
        let country: String

        public struct AffiliateStatus: Decodable {
            let account: Double
            let currency: String
            let prevPayout: Double
            let prevTurnover: Double
            let prevComm: Double
            let prevTimestamp: Date
            let execTurnover: Double
            let execComm: Double
            let totalReferrals: Double
            let totalTurnover: Double
            let totalComm: Double
            let payoutPcnt: Double
            let pendingPayout: Double
            let timestamp: Date
            let referrerAccount: Int
        }

        public struct CancelWithdrawal: Decodable {
            let transactID: String
            let account: Double
            let currency: String
            let transactType: String
            let amount: Double
            let fee: Double
            let transactStatus: String
            let address: String
            let tx: String
            let text: String
            let transactTime: Date
            let timestamp: Date
        }

        public typealias CheckReferralCode = Double

        public struct Commission: Decodable {
            let makerFee: Double
            let takerFee: Double
            let settlementFee: Double
            let maxFee: Int
        }

        public struct ConfirmEmail: Decodable {
            let id: String
            let ttl: Int
            let created: Date
            let userId: Int
        }

        public typealias ConfirmEnableTFA = Bool

        public struct ConfirmWithdrawal: Decodable {
            let transactID: String
            let account: Double
            let currency: String
            let transactType: String
            let amount: Double
            let fee: Double
            let transactStatus: String
            let address: String
            let tx: String
            let text: String
            let transactTime: Date
            let timestamp: Date
        }

        public typealias DepositAddress = String

        public typealias DisableTFA = Bool

        public struct Logout: Decodable { }

        public typealias LogoutAll = Double

        public struct Margin: Decodable {
            let account: Double
            let currency: String
            let riskLimit: Double
            let prevState: String
            let state: String
            let action: String
            let amount: Double
            let pendingCredit: Double
            let pendingDebit: Double
            let confirmedDebit: Double
            let prevRealisedPnl: Double
            let prevUnrealisedPnl: Double
            let grossComm: Double
            let grossOpenCost: Double
            let grossOpenPremium: Double
            let grossExecCost: Double
            let grossMarkValue: Double
            let riskValue: Double
            let taxableMargin: Double
            let initMargin: Double
            let maintMargin: Double
            let sessionMargin: Double
            let targetExcessMargin: Double
            let varMargin: Double
            let realisedPnl: Double
            let unrealisedPnl: Double
            let indicativeTax: Double
            let unrealisedProfit: Double
            let syntheticMargin: Double
            let walletBalance: Double
            let marginBalance: Double
            let marginBalancePcnt: Double
            let marginLeverage: Double
            let marginUsedPcnt: Double
            let excessMargin: Double
            let excessMarginPcnt: Double
            let availableMargin: Double
            let withdrawableMargin: Double
            let timestamp: Date
            let grossLastValue: Double
            let commission: Double
        }

        public struct WithdrawalFee: Decodable {
            let currency: BxCurrency
            let fee: Int
            let minFee: Int
        }

        public typealias RequestEnableTFA = Bool

        public struct RequestWithdrawal: Decodable {
            let transactID: String
            let account: Double
            let currency: String
            let transactType: String
            let amount: Double
            let fee: Double
            let transactStatus: String
            let address: String
            let tx: String
            let text: String
            let transactTime: Date
            let timestamp: Date
        }

        public struct Wallet: Decodable {
            let account: Double
            let currency: String
            let prevDeposited: Double
            let prevWithdrawn: Double
            let prevTransferIn: Double
            let prevTransferOut: Double
            let prevAmount: Double
            let prevTimestamp: Date
            let deltaDeposited: Double
            let deltaWithdrawn: Double
            let deltaTransferIn: Double
            let deltaTransferOut: Double
            let deltaAmount: Double
            let deposited: Double
            let withdrawn: Double
            let transferIn: Double
            let transferOut: Double
            let amount: Double
            let pendingCredit: Double
            let pendingDebit: Double
            let confirmedDebit: Double
            let timestamp: Date
            let addr: String
            let script: String
            let withdrawalLock: [String]
        }

        public struct WalletHistory: Decodable {
            let transactID: String
            let account: Double
            let currency: String
            let transactType: String
            let amount: Double
            let fee: Double?
            let transactStatus: String
            let address: String
            let tx: String?
            let text: String?
            let transactTime: Date?
            let timestamp: Date?
        }

        public struct WalletSummary: Decodable {
            let account: Int
            let currency: BxCurrency
            let transactType: BxTransactionType
            let symbol: BxSymbol
            let amount: Int
            let pendingDebit: Int
            let realisedPnl: Int
            let walletBalance: Int
            let unrealisedPnl: Int
            let marginBalance: Int
        }
    }
}

public typealias BxLocale = String

