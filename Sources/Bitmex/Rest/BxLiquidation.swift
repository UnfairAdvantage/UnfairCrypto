//
//  BxLiquidation.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-03-08.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation

// MARK - Request

public extension BxRestAPI {
    /** Liquidation : Active Liquidations */
    public var liquidation: Liquidation {
        return Liquidation(api: self)
    }

    public struct Liquidation {
        private let api: BxRestAPI

        public init(api: BxRestAPI) {
            self.api = api
        }

        /** Get liquidation orders */
        public var get: BxRequest<[BxResponse.Liquidation], BxParameters.Main, BxNo, BxYes, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "liquidation")
        }
    }
}

// MARK - Response

public extension BxResponse {
    public struct Liquidation: Decodable {
        let orderID: String
        let symbol: BxSymbol
        let side: BxSide
        let price: Double
        let leavesQty: Int
    }
}

