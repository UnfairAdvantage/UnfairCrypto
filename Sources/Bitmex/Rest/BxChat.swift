//
//  BxChat.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-03-08.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation

// MARK - Request

public extension BxRestAPI {
    /** Chat : Trollbox Data */
    public var chat: Chat {
        return Chat(api: self)
    }

    public struct Chat {
        private let api: BxRestAPI

        public init(api: BxRestAPI) {
            self.api = api
        }

        // FIXME: Check if id is ever not an int
        /** Get chat messages */
        public var get: BxRequest<[BxResponse.Chat], BxParameters.Chat, BxNo, BxYes, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "chat")
        }

        /** Send a chat message */
        public func send( _ message: String) -> BxRequest<BxResponse.Chat, BxParameters.Chat, BxNo, BxNo, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "chat", method: .post, security: .signature, params: ["message" : message])
        }

        /** Get available channels */
        public var channels: BxRequest<[BxResponse.Chat.Channel], BxParameters.None, BxYes, BxYes, BxColumns.Customs> {
            return BxRequest(api: api, endpoint: "chat/channels")
        }

        /** Get connected users */
        public var connected: BxRequest<BxResponse.Chat.Connected, BxParameters.None, BxNo, BxNo, BxColumns.Custom> {
            return BxRequest(api: api, endpoint: "chat/connected")
        }
    }
}

// MARK - Response

public extension BxResponse {
    public struct Chat: Decodable {
        let id: Double
        let date: Date
        let user: String
        let message: String
        let html: String
        let fromBot: Bool
        let channelID: Int

        public struct Channel: Decodable {
            let id: Int
            let name: String
        }

        public struct Connected: Decodable {
            let users: Double
            let bots: String
        }
    }
}
