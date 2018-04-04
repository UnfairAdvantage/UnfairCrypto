//
//  BxFunding.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-02-25.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation

// MARK - Request

public extension BxRestAPI {
    /** Funding : Swap Funding History */
    public var funding: Funding {
        return Funding(api: self)
    }

    public struct Funding {
        private let api: BxRestAPI

        public init(api: BxRestAPI) {
            self.api = api
        }

        /** Get funding history */
        public var get: BxRequest<[BxResponse.Funding], BxParameters.Main, BxNo, BxYes, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "funding")
        }
    }
}

// MARK - Response

public extension BxResponse {
    public struct Funding: Decodable {
        let symbol: BxSymbol
        let timestamp: Date
        let fundingInterval: Date
        let fundingRate: Float
        let fundingRateDaily: Float
    }
}

