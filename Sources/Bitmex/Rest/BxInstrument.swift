//
//  BxInstrument.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-02-24.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation

// MARK - Request

public extension BxRestAPI {
    /** Instrument : Tradeable Contracts, Indices, and History */
    public var instrument: Instrument {
        return Instrument(api: self)
    }

    public struct Instrument {
        private let api: BxRestAPI

        public init(api: BxRestAPI) {
            self.api = api
        }

        // FIXME: check snr etc
        /** Get instruments */
        public var get: BxRequest<[BxResponse.Instrument], BxParameters.Main, BxNo, BxYes, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "instrument")
        }

        /** Get all active instruments and instruments that have expired in <24hrs */
        public var active: BxRequest<[BxResponse.Instrument.Active], BxParameters.None, BxNo, BxYes, BxColumns.Default> {
            return BxRequest(api: api, endpoint: "instrument/active")
        }

        /** Helper method. Gets all active instruments and all indices. This is a join of the result of /indices and /active */
        public var activeAndIndices: BxRequest<[BxResponse.Instrument], BxParameters.None, BxNo, BxYes, BxColumns.Default> {
            return BxRequest(api: api, endpoint: "instrument/activeAndIndices")
        }

        /** Return all active contract series and interval pairs */
        public var activeIntervals: BxRequest<BxResponse.Instrument.Intervals, BxParameters.None, BxNo, BxNo, BxColumns.Default> {
            return BxRequest(api: api, endpoint: "instrument/activeIntervals")
        }

        /** Show constituent parts of an index */
        public var compositeIndex: BxRequest<[BxResponse.Instrument.Constituent], BxParameters.None, BxNo, BxYes, BxColumns.Default> {
            return BxRequest(api: api, endpoint: "instrument/compositeIndex")
        }

        /** Get all price indices */
        public var indices: BxRequest<[BxResponse.Instrument], BxParameters.None, BxNo, BxYes, BxColumns.Default> {
            return BxRequest(api: api, endpoint: "instrument/indices")
        }
    }
}

// MARK - Response

public extension BxResponse {
    public struct Instrument: Decodable {
        let symbol: BxSymbol
        let rootSymbol: BxRootSymbol
        let state: BxState
        let typ: String?
        let listing: Date?
        let front: Date?
        let expiry: Date?
        let settle: Date?
        let relistInterval: Date?
        let inverseLeg: String?
        let sellLeg: String?
        let buyLeg: String?
        let positionCurrency: String?
        let underlying: String?
        let quoteCurrency: String?
        let underlyingSymbol: String?
        let reference: String?
        let referenceSymbol: String?
        let calcInterval: Date?
        let publishInterval: Date?
        let publishTime: Date?
        let maxOrderQty: Double?
        let maxPrice: Double?
        let lotSize: Double?
        let tickSize: Double?
        let multiplier: Double?
        let settlCurrency: String?
        let underlyingToPositionMultiplier: Double?
        let underlyingToSettleMultiplier: Double?
        let quoteToSettleMultiplier: Double?
        let isQuanto: Bool?
        let isInverse: Bool?
        let initMargin: Double?
        let maintMargin: Double?
        let riskLimit: Double?
        let riskStep: Double?
        let limit: Double?
        let capped: Bool?
        let taxed: Bool?
        let deleverage: Bool?
        let makerFee: Double?
        let takerFee: Double?
        let settlementFee: Double?
        let insuranceFee: Double?
        let fundingBaseSymbol: String? // fixme
        let fundingQuoteSymbol: String?
        let fundingPremiumSymbol: String?
        let fundingTimestamp: Date?
        let fundingInterval: Date?
        let fundingRate: Double?
        let indicativeFundingRate: Double?
        let rebalanceTimestamp: Date?
        let rebalanceInterval: Date?
        let openingTimestamp: Date?
        let closingTimestamp: Date?
        let sessionInterval: Date?
        let prevClosePrice: Double?
        let limitDownPrice: Double?
        let limitUpPrice: Double?
        let bankruptLimitDownPrice: Double?
        let bankruptLimitUpPrice: Double?
        let prevTotalVolume: Double?
        let totalVolume: Double?
        let volume: Double?
        let volume24h: Double?
        let prevTotalTurnover: Double?
        let totalTurnover: Double?
        let turnover: Double?
        let turnover24h: Double?
        let prevPrice24h: Double?
        let vwap: Double?
        let highPrice: Double?
        let lowPrice: Double?
        let lastPrice: Double?
        let lastPriceProtected: Double?
        let lastTickDirection: BxTickDirection
        let lastChangePcnt: Double?
        let bidPrice: Double?
        let midPrice: Double?
        let askPrice: Double?
        let impactBidPrice: Double?
        let impactMidPrice: Double?
        let impactAskPrice: Double?
        let hasLiquidity: Bool?
        let openInterest: Double?
        let openValue: Double?
        let fairMethod: String?
        let fairBasisRate: Double?
        let fairBasis: Double?
        let fairPrice: Double?
        let markMethod: String // fixme: enum
        let markPrice: Double?
        let indicativeTaxRate: Double?
        let indicativeSettlePrice: Double?
        let settledPrice: Double?
        let timestamp: Date?

        public struct Active: Decodable {
            let symbol: BxSymbol
            let rootSymbol: BxRootSymbol
            let state: BxState
            let typ: String
            let listing: Date
            let front: Date
            let expiry: Date?
            let settle: Date?
            let relistInterval: Date?
            let inverseLeg: String
            let sellLeg: String
            let buyLeg: String
            let positionCurrency: String
            let underlying: String
            let quoteCurrency: String
            let underlyingSymbol: String
            let reference: String
            let referenceSymbol: String
            let calcInterval: Date?
            let publishInterval: Date?
            let publishTime: Date?
            let maxOrderQty: Double
            let maxPrice: Double
            let lotSize: Double
            let tickSize: Double
            let multiplier: Double
            let settlCurrency: String
            let underlyingToPositionMultiplier: Double?
            let underlyingToSettleMultiplier: Double?
            let quoteToSettleMultiplier: Double?
            let isQuanto: Bool
            let isInverse: Bool
            let initMargin: Double?
            let maintMargin: Double?
            let riskLimit: Double?
            let riskStep: Double
            let limit: Double?
            let capped: Bool
            let taxed: Bool
            let deleverage: Bool
            let makerFee: Double
            let takerFee: Double
            let settlementFee: Double
            let insuranceFee: Double
            let fundingBaseSymbol: String
            let fundingQuoteSymbol: String
            let fundingPremiumSymbol: String
            let fundingTimestamp: Date?
            let fundingInterval: Date?
            let fundingRate: Double?
            let indicativeFundingRate: Double?
            let rebalanceTimestamp: Date?
            let rebalanceInterval: Date?
            let openingTimestamp: Date
            let closingTimestamp: Date
            let sessionInterval: Date
            let prevClosePrice: Double?
            let limitDownPrice: Double?
            let limitUpPrice: Double?
            let bankruptLimitDownPrice: Double?
            let bankruptLimitUpPrice: Double?
            let prevTotalVolume: Double
            let totalVolume: Double
            let volume: Double
            let volume24h: Double
            let prevTotalTurnover: Double
            let totalTurnover: Double
            let turnover: Double
            let turnover24h: Double
            let prevPrice24h: Double?
            let vwap: Double?
            let highPrice: Double?
            let lowPrice: Double?
            let lastPrice: Double?
            let lastPriceProtected: Double?
            let lastTickDirection: BxTickDirection
            let lastChangePcnt: Double?
            let bidPrice: Double
            let midPrice: Double
            let askPrice: Double
            let impactBidPrice: Double?
            let impactMidPrice: Double?
            let impactAskPrice: Double?
            let hasLiquidity: Bool
            let openInterest: Double
            let openValue: Double
            let fairMethod: String
            let fairBasisRate: Double?
            let fairBasis: Double?
            let fairPrice: Double
            let markMethod: String // fixme: enum
            let markPrice: Double
            let indicativeTaxRate: Double?
            let indicativeSettlePrice: Double?
            let settledPrice: Double?
            let timestamp: Date
        }

        public struct Constituent: Decodable {
            let timestamp: Date
            let symbol: String
            let indexSymbol: String
            let reference: String
            let lastPrice: Double
            let weight: Double
            let logged: Date
        }

        public struct Intervals: Decodable {
            let intervals: [BxInterval]
            let symbols: [BxSymbol]
        }
    }
}

