//
//  BxTrade.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-03-10.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation

// MARK - Request

public extension BxRestAPI {
    /** Trade : Individual & Bucketed Trades */
    public var trade: Trade {
        return Trade(api: self)
    }

    public struct Trade {
        private let api: BxRestAPI

        public init(api: BxRestAPI) {
            self.api = api
        }

        /** Get Trades */
        public var get: BxRequest<[BxResponse.Trade], BxParameters.Main, BxNo, BxYes, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "trade")
        }

        /** Get previous trades in time buckets */
        public func bucketed(binSize: BxBinSize, partial: Bool = false) -> BxRequest<[BxResponse.Trade.BucketedTrade], BxParameters.Main, BxNo, BxYes, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "trade/bucketed", params: ["binSize" : binSize, "partial" : partial])
        }
    }
}

// MARK - Response

public extension BxResponse {
    public struct Trade: Decodable {
        let timestamp: Date
        let symbol: BxSymbol
        let side: BxSide
        let size: Double
        let price: Double
        let tickDirection: BxTickDirection
        let trdMatchID: String
        let grossValue: Int
        let homeNotional: Int
        let foreignNotional: Int

        public struct BucketedTrade: Decodable {
            let timestamp: Date
            let symbol: BxSymbol
            let open: Int
            let high: Int
            let low: Int
            let close: Int
            let trades: Int
            let volume: Int
            let vwap: Int
            let lastSize: Int
            let turnover: Int
            let homeNotional: Int
            let foreignNotional: Int
        }
    }
}
