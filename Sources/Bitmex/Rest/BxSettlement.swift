//
//  BxSettlement.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-03-08.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation

// MARK - Request

public extension BxRestAPI {
    /** Settlement : Historical Settlement Data */
    public var settlement: Settlement {
        return Settlement(api: self)
    }

    public struct Settlement {
        private let api: BxRestAPI

        public init(api: BxRestAPI) {
            self.api = api
        }

        /** Get settlement history */
        public var get: BxRequest<[BxResponse.Settlement], BxParameters.Main, BxNo, BxNo, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "settlement")
        }
    }
}

// MARK - Response

public extension BxResponse {
    public struct Settlement: Decodable {
        let timestamp: Date
        let symbol: BxSymbol
        let settlementType: SettlementType
        let settledPrice: Double
        let optionStrikePrice: Double?
        let optionUnderlyingPrice: Double?
        let bankrupt: Double?
        let taxBase: Double?
        let taxRate: Double?

        public enum SettlementType: String, Decodable {
            case settlement = "Settlement"
        }
    }
}

