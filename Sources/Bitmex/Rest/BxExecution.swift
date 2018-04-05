//
//  BxExecution.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-03-08.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation

// MARK - Request

public extension BxRestAPI {
    /** Execution : Raw Order and Balance Data */
    public var execution: Execution {
        return Execution(api: self)
    }

    public struct Execution {
        private let api: BxRestAPI

        public init(api: BxRestAPI) {
            self.api = api
        }

        /** Get all raw executions for your account */
        public var get: BxRequest<[BxResponse.Execution], BxParameters.Main, BxNo, BxYes, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "execution", security: .signature)
        }

        /** Get all balance-affecting executions. This includes each trade, insurance charge, and settlement */
        public var tradeHistory: BxRequest<[BxResponse.Execution], BxParameters.Main, BxNo, BxYes, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "execution/tradeHistory", security: .signature)
        }
    }
}

// MARK - Response

public extension BxResponse {
    public struct Execution: Decodable {
        let execID: String
        let orderID: String
        let clOrdID: String
        let clOrdLinkID: String
        let account: Double
        let symbol: String
        let side: String
        let lastQty: Double
        let lastPx: Double
        let underlyingLastPx: Double
        let lastMkt: String
        let lastLiquidityInd: String
        let simpleOrderQty: Double
        let orderQty: Double
        let price: Double
        let displayQty: Double
        let stopPx: Double
        let pegOffsetValue: Double
        let pegPriceType: String
        let currency: String
        let settlCurrency: String
        let execType: String
        let ordType: String
        let timeInForce: String
        let execInst: String
        let contingencyType: String
        let exDestination: String
        let ordStatus: String
        let triggered: String
        let workingIndicator: Bool
        let ordRejReason: String
        let simpleLeavesQty: Double
        let leavesQty: Double
        let simpleCumQty: Double
        let cumQty: Double
        let avgPx: Double
        let commission: Double
        let tradePublishIndicator: String
        let multiLegReportingType: String
        let text: String
        let trdMatchID: String
        let execCost: Double
        let execComm: Double
        let homeNotional: Double
        let foreignNotional: Double
        let transactTime: Date
        let timestamp: Date
    }
}
