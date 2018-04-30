//
//  BinanceStreamer.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-01-26.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation
import Starscream

public class BnSocketAPI: QuoteStreamer {
    private let url: URL
    private let apiToken: String
    private let apiSecret: String

    private let socket: WebSocket
    private let decoder = JSONDecoder()

    private var subscribers = [UUID : (Set<String>) -> Void]()

    public init(baseUrl: String, apiToken: String, apiSecret: String) {
        self.url = URL(string: baseUrl + BnSocketAPI.depthQuery(symbols: RootSymbol.all))!
        self.apiToken = apiToken
        self.apiSecret = apiSecret

        socket = WebSocket(url: url)
        socket.onText = onText
        socket.onConnect = onConnect
        socket.onDisconnect = { self.state = .disconnected; print("BINANCE DID DISCONNECT \($0?.localizedDescription ?? "-")") }
        socket.connect()
    }

    private func onConnect() {
        state = .connected
    }

    deinit {
        socket.disconnect()
    }

    // MARK - Streamer Protocol

    public var bids = [String : [Quote]]()
    public var asks = [String : [Quote]]()
    public var state: SocketState = .disconnected

    public func subscribe(callback: @escaping (Set<String>) -> Void) -> UUID {
        let token = UUID()
        subscribers[token] = callback
        return token
    }

    public func unsubscribe(token: UUID) {
        subscribers[token] = nil
    }

    // MARK - Websocket

    private func onText(_ message: String) {
//        print("Binance onText: \(message)")

        let json = message.data(using: .utf8)!

        do {
            let orderbook = try decoder.decode(BnOrderbook.self, from: json)
            updateQuotes(orderbook)
        }
        catch {
            print("Binance json error: \(error)")
        }
    }

    private func updateQuotes(_ orderbook: BnOrderbook) {
        guard let symbolSubstring = orderbook.stream.split(separator: "@").first else {
            print("No @ in bn stream name!")
            return
        }

        let symbol = String(symbolSubstring)
        bids[symbol] = orderbook.data.bids.sorted(by: >)
        asks[symbol] = orderbook.data.asks.sorted()

        for callback in subscribers.values {
            callback([symbol])
        }
    }

    private static func depthQuery(symbols: [RootSymbol]) -> String {
        let depth = 20
        let streams = symbols.map { "\($0.bnStream)@depth\(depth)" }
        return "?streams=\(streams.joined(separator: "/"))"
    }
}

struct BnOrderbook: Decodable {
    let stream: String
    let data: BnResponse.Depth
}

