//
//  BxPosition.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-02-24.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation

public typealias Satoshi = Double

public enum BxMarginType {
    case isolated
    case cross
}

public enum BxLeverage {
    case fixed(Double)
    case crossMargin

    public var value: Double {
        switch self {
        case let .fixed(val): return val
        case .crossMargin: return 0
        }
    }
}

// MARK - Request

public extension BxRestAPI {
    /** Position : Summary of Open and Closed Positions */
    public var position: Position {
        return Position(api: self)
    }

    public struct Position {
        private let api: BxRestAPI

        public init(api: BxRestAPI) {
            self.api = api
        }

        /** Get your positions */
        public var get: BxRequest<[BxResponse.Position], BxParameters.None, BxYes, BxNo, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "position", security: .signature)
        }

        /** Enable isolated margin or cross margin per-position */
        public func isolate(_ symbol: BxSymbol, margin: BxMarginType = .isolated) -> BxRequest<BxResponse.Position, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            let params: BxParams =  ["symbol" : symbol, "enabled" : margin == .isolated]
            return BxRequest(api: api, endpoint: "position/isolate", method: .post, security: .signature, params: params)
        }

        /** Choose leverage for a position */
        public func leverage(_ symbol: BxSymbol, leverage: BxLeverage) -> BxRequest<BxResponse.Position, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "position/leverage", method: .post, security: .signature, params: ["symbol" : symbol, "leverage" : leverage.value])
        }

        /** Update your risk limit */
        public func riskLimit(_ symbol: BxSymbol, riskLimit: Satoshi) -> BxRequest<BxResponse.Position, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "position/riskLimit", method: .post, security: .signature, params: ["symbol" : symbol, "riskLimit" : riskLimit])
        }

        /** Transfer equity in or out of a position */
        public func transferMargin(_ symbol: BxSymbol, amount: Satoshi) -> BxRequest<BxResponse.Position, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "position/transferMargin", method: .post, security: .signature, params: ["symbol" : symbol, "amount" : amount])
        }
    }
}

// MARK - Response

public extension BxResponse {
    public struct Position: Decodable { // FIXME: go through types
        let account: Float
        let symbol: BxSymbol
        let currency: String
        let underlying: String
        let quoteCurrency: String
        let commission: Float
        let initMarginReq: Float
        let maintMarginReq: Float
        let riskLimit: Float
        let leverage: Float
        let crossMargin: Bool
        let deleveragePercentile: Float
        let rebalancedPnl: Float
        let prevRealisedPnl: Float
        let prevUnrealisedPnl: Float
        let prevClosePrice: Float
        let openingTimestamp: Date
        let openingQty: Int
        let openingCost: Float
        let openingComm: Float
        let openOrderBuyQty: Int
        let openOrderBuyCost: Float
        let openOrderBuyPremium: Float
        let openOrderSellQty: Float
        let openOrderSellCost: Float
        let openOrderSellPremium: Float
        let execBuyQty: Int
        let execBuyCost: Float
        let execSellQty: Int
        let execSellCost: Float
        let execQty: Int
        let execCost: Float
        let execComm: Float
        let currentTimestamp: Date
        let currentQty: Int
        let currentCost: Float
        let currentComm: Float
        let realisedCost: Float
        let unrealisedCost: Float
        let grossOpenCost: Float
        let grossOpenPremium: Float
        let grossExecCost: Float
        let isOpen: Bool
        let markPrice: Float
        let markValue: Float
        let riskValue: Float
        let homeNotional: Float
        let foreignNotional: Float
        let posState: String
        let posCost: Float
        let posCost2: Float
        let posCross: Float
        let posInit: Float
        let posComm: Float
        let posLoss: Float
        let posMargin: Float
        let posMaint: Float
        let posAllowance: Float
        let taxableMargin: Float
        let initMargin: Float
        let maintMargin: Float
        let sessionMargin: Float
        let targetExcessMargin: Float
        let varMargin: Float
        let realisedGrossPnl: Float
        let realisedTax: Float
        let realisedPnl: Float
        let unrealisedGrossPnl: Float
        let longBankrupt: Float
        let shortBankrupt: Float
        let taxBase: Float
        let indicativeTaxRate: Float
        let indicativeTax: Float
        let unrealisedTax: Float
        let unrealisedPnl: Float
        let unrealisedPnlPcnt: Float
        let unrealisedRoePcnt: Float
        let simpleQty: Float
        let simpleCost: Float
        let simpleValue: Float
        let simplePnl: Float
        let simplePnlPcnt: Float
        let avgCostPrice: Float
        let avgEntryPrice: Float
        let breakEvenPrice: Float
        let marginCallPrice: Float
        let liquidationPrice: Float
        let bankruptPrice: Float
        let timestamp: Date
        let lastPrice: Float
        let lastValue: Float
    }
}

