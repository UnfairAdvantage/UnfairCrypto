//
//  BnResponse.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-02-04.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation

public struct BnResponse {
    public struct Ping: Decodable { }

    public struct Time: Decodable {
        public let serverTime: Date
    }

    public struct ExchangeInfo: Decodable {
        let timezone: String
        let serverTime: Date

        struct RateLimit: Decodable {
            enum RateLimitType: String, Decodable {
                case requests = "REQUESTS"
                case orders = "ORDERS"
            }

            enum RateLimitInterval: String, Decodable {
                case second = "SECOND"
                case minute = "MINUTE"
                case day = "DAY"
            }
            let rateLimitType: RateLimitType
            let interval: RateLimitInterval
            let limit: Int
        }

        let rateLimits: [RateLimit]
        public enum ExchangeFilter: Decodable {
            case maxNumOrders(limit: Int)
            case maxAlgoOrders(limit: Int)
        }

        let exchangeFilters: [ExchangeFilter] // FIXME: test

        public struct SymbolInfo: Decodable {
            let symbol: BnSymbol

            enum SymbolStatus: String, Decodable {
                case preTrading = "PRE_TRADING"
                case trading = "TRADING"
                case postTrading = "POST_TRADING"
                case endOfDay = "END_OF_DAY"
                case halt = "HALT"
                case auctionMatch = "AUCTION_MATCH"
                case onBreak = "BREAK"
            }

            let status: SymbolStatus

            let baseAsset: BnAsset // enum: fixme: test
            let baseAssetPrecision: Int
            let quoteAsset: BnAsset // enum: fixme: test
            let quotePrecision: Int

            let orderTypes: [BnOrderType]
            let icebergAllowed: Bool

            public enum Filter: Decodable {
                case priceFilter(minPrice: Double, maxPrice: Double, tickSize: Double)
                case lotSize(minQuantity: Double, maxQuantity: Double, stepSize: Double)
                case minNotional(minNotional: Double)
                case maxNumOrders(limit: Int)
                case maxAlgoOrders(limit: Int)
            }

            let filters: [Filter]
        }

        let symbols: [SymbolInfo]
    }

    public struct Depth: Decodable {
        let lastUpdateId: Int
        let bids: [Quote]
        let asks: [Quote]
    }

    public struct Trade: Decodable {
        let id: Int64
        let price: Double
        let quantity: Double
        let time: Date
        let isBuyerMaker: Bool
        let isBestMatch: Bool
    }

    public typealias HistoricalTrade = Trade

    public struct AggTrade: Decodable {
        let aggregateTradeId: Int64
        let price: Double
        let quantity: Double
        let firstTradeId: Int64
        let lastTradeId: Int64
        let timestamp: Date
        let isBuyerMaker: Bool
        let isBestMatch: Bool
    }

    public struct Kline: Decodable {
        let openTime: Date
        let open: Double
        let high: Double
        let low: Double
        let close: Double
        let volume: Double
        let closeTime: Date
        let quoteAssetVolume: Double
        let numberOfTrades: Int
        let takerBuyBaseAssetVolume: Double
        let takerBuyQuoteAssetVolume: Double
    }

    public struct Change24h: Decodable {
        let symbol: BnSymbol
        let priceChange: Double
        let priceChangePercent: Double
        let weightedAvgPrice: Double
        let prevClosePrice: Double
        let lastPrice: Double
        let lastQty: Double
        let bidPrice: Double
        let askPrice: Double
        let openPrice: Double
        let highPrice: Double
        let lowPrice: Double
        let volume: Double
        let quoteVolume: Double
        let openTime: Date
        let closeTime: Date
        let fristId: Int64  // First tradeId
        let lastId: Int64   // Last tradeId
        let count: Int      // Trade count
    }

    public struct Price: Decodable {
        let symbol: BnSymbol
        let price: Double
    }

    public struct BookTicker: Decodable {
        let symbol: BnSymbol
        let bidPrice: Double
        let bidQuantity: Double
        let askPrice: Double
        let askQuantity: Double
    }

    public struct Order {
        public struct Ack: Decodable {
            let symbol: BnSymbol
            let orderId: Int64
            let clientOrderId: String
            let transactTime: Date
        }

        public struct Result: Decodable {
            let symbol: BnSymbol
            let orderId: Int64
            let clientOrderId: String
            let transactTime: Date

            let price: Double
            let originalQuantity: Double
            let executedQuantity: Double
            let status: BnOrderStatus
            let timeInForce: BnTimeInForce
            let type: BnOrderType
            let side: BnOrderSide
        }

        public struct Full: Decodable {
            let symbol: BnSymbol
            let orderId: Int64
            let clientOrderId: String
            let transactTime: Date

            let price: Double
            let originalQuantity: Double
            let executedQuantity: Double
            let status: BnOrderStatus
            let timeInForce: BnTimeInForce
            let type: BnOrderType
            let side: BnOrderSide

            public struct Fill: Decodable {
                let price: Double
                let quantity: Double
                let commission: Double
                let commissionAsset: BnAsset // fixme: test
            }

            let fills: [Fill]
        }
    }

    public struct TestOrder: Decodable { }

    public struct QueryOrder: Decodable {
        let symbol: BnSymbol
        let orderId: Int64
        let clientOrderId: String
        let price: Double
        let originalQuantity: Double
        let executedQuantity: Double
        let status: BnOrderStatus
        let timeInForce: BnTimeInForce
        let type: BnOrderType
        let side: BnOrderSide

        let stopPrice: Double
        let icebergQuantity: Double
        let time: Date
        let isWorking: Bool
    }

    public struct CancelOrder: Decodable {
        let symbol: BnSymbol
        let origClientOrderId: String
        let orderId: Int64
        let clientOrderId: String
    }

    public typealias OpenOrders = QueryOrder

    public typealias AllOrders = QueryOrder

    public struct Account: Decodable {
        let makerCommission: Int
        let takerCommission: Int
        let buyerCommission: Int
        let sellerCommission: Int

        let canTrade: Bool
        let canWithdraw: Bool
        let canDeposit: Bool
        let updateTime: Date

        struct Balance: Decodable {
            let asset: BnAsset // fixme: test
            let free: Double
            let locked: Double
        }

        let balances: [Balance]

        var nonEmptyBalances: [Balance] { return balances.filter { $0.free + $0.locked > 0 } }
    }

    public struct MyTrades: Decodable {
        let id: Int64
        let orderId: Int64
        let price: Double
        let quantity: Double
        let commission: Double
        let commissionAsset: BnAsset // fixme: test
        let time: Date

        let isBuyer: Bool
        let isMaker: Bool
        let isBestMatch: Bool
    }
}

// MARK - Extensions for Decodable Customisation

extension BnResponse.ExchangeInfo.ExchangeFilter {
    private enum CodingKeys: String, CodingKey {
        case filterType
        case limit
    }

    public init(from decoder: Decoder) throws {
        enum FilterType: String, Decodable {
            case maxNumOrders = "EXCHANGE_MAX_NUM_ORDERS"
            case maxAlgoOrders = "EXCHANGE_MAX_ALGO_ORDERS"
        }

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let filterTypeRaw = try container.decode(String.self, forKey: .filterType)
        guard let filterType = FilterType(rawValue: filterTypeRaw) else {
            throw NSError(domain: "JSON", code: 555, userInfo: ["Issue" : "missing or unexpected filter type: \(filterTypeRaw)"])
        }

        switch filterType {
        case .maxNumOrders:
            let limit = try container.decode(Int.self, forKey: .limit)
            self = .maxNumOrders(limit: limit)
        case .maxAlgoOrders:
            let limit = try container.decode(Int.self, forKey: .limit)
            self = .maxAlgoOrders(limit: limit)
        }
    }
}

extension BnResponse.ExchangeInfo.SymbolInfo.Filter {
    private enum CodingKeys: String, CodingKey {
        case filterType
        case minPrice, maxPrice, tickSize
        case minQuantity = "minQty", maxQuantity = "maxQty", stepSize
        case minNotional
        case limit
    }

    public init(from decoder: Decoder) throws {
        enum FilterType: String, Decodable {
            case priceFilter = "PRICE_FILTER"
            case lotSize = "LOT_SIZE"
            case minNotional = "MIN_NOTIONAL"
            case maxNumOrders = "MAX_NUM_ORDERS"
            case maxAlgoOrders = "MAX_ALGO_ORDERS"
        }

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let filterTypeRaw = try container.decode(String.self, forKey: .filterType)
        guard let filterType = FilterType(rawValue: filterTypeRaw) else {
            throw NSError(domain: "JSON", code: 555, userInfo: ["Issue" : "missing or unexpected filter type: \(filterTypeRaw)"])
        }

        switch filterType {
        case .priceFilter:
            let minPrice = try container.decode(String.self, forKey: .minPrice).toDouble()
            let maxPrice = try container.decode(String.self, forKey: .maxPrice).toDouble()
            let tickSize = try container.decode(String.self, forKey: .tickSize).toDouble()
            self = .priceFilter(minPrice: minPrice, maxPrice: maxPrice, tickSize: tickSize)
        case .lotSize:
            let minQuantity = try container.decode(String.self, forKey: .minQuantity).toDouble()
            let maxQuantity = try container.decode(String.self, forKey: .maxQuantity).toDouble()
            let stepSize = try container.decode(String.self, forKey: .stepSize).toDouble()
            self = .lotSize(minQuantity: minQuantity, maxQuantity: maxQuantity, stepSize: stepSize)
        case .minNotional:
            let minNotional = try container.decode(String.self, forKey: .minNotional).toDouble()
            self = .minNotional(minNotional: minNotional)
        case .maxNumOrders:
            let limit = try container.decode(Int.self, forKey: .limit)
            self = .maxNumOrders(limit: limit)
        case .maxAlgoOrders:
            let limit = try container.decode(Int.self, forKey: .limit)
            self = .maxAlgoOrders(limit: limit)
        }
    }
}

extension BnResponse.Trade {
    private enum CodingKeys: String, CodingKey {
        case id, price, quantity = "qty", time, isBuyerMaker, isBestMatch
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        price = try container.decode(String.self, forKey: .price).toDouble()
        quantity = try container.decode(String.self, forKey: .quantity).toDouble()
        time = try container.decode(Date.self, forKey: .time)
        isBuyerMaker = try container.decode(Bool.self, forKey: .isBuyerMaker)
        isBestMatch = try container.decode(Bool.self, forKey: .isBestMatch)
    }
}

extension BnResponse.AggTrade {
    private enum CodingKeys: String, CodingKey {
        case aggregateTradeId = "a"
        case price = "p"
        case quantity = "q"
        case firstTradeId = "f"
        case lastTradeId = "l"
        case timestamp = "T"
        case isBuyerMaker = "m"
        case isBestMatch = "M"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        aggregateTradeId = try container.decode(Int64.self, forKey: .aggregateTradeId)
        price =  try container.decode(String.self, forKey: .price).toDouble()
        quantity =  try container.decode(String.self, forKey: .quantity).toDouble()
        firstTradeId = try container.decode(Int64.self, forKey: .firstTradeId)
        lastTradeId = try container.decode(Int64.self, forKey: .lastTradeId)
        timestamp = try container.decode(Date.self, forKey: .lastTradeId)
        isBuyerMaker = try container.decode(Bool.self, forKey: .isBuyerMaker)
        isBestMatch = try container.decode(Bool.self, forKey: .isBestMatch)
    }
}

extension BnResponse.Kline {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        openTime = try container.decode(Date.self)
        open = try container.decode(String.self).toDouble()
        high = try container.decode(String.self).toDouble()
        low = try container.decode(String.self).toDouble()
        close = try container.decode(String.self).toDouble()
        volume = try container.decode(String.self).toDouble()
        closeTime = try container.decode(Date.self)
        quoteAssetVolume = try container.decode(String.self).toDouble()
        numberOfTrades = try container.decode(Int.self)
        takerBuyBaseAssetVolume = try container.decode(String.self).toDouble()
        takerBuyQuoteAssetVolume = try container.decode(String.self).toDouble()
    }
}

extension BnResponse.Change24h {
    private enum CodingKeys: String, CodingKey {
        case symbol, priceChange, priceChangePercent, weightedAvgPrice, prevClosePrice, lastPrice, lastQty, bidPrice, askPrice, openPrice, highPrice, lowPrice, volume, quoteVolume, openTime, closeTime, fristId, lastId, count
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try container.decode(BnSymbol.self, forKey: .symbol)
        priceChange = try container.decode(String.self, forKey: .priceChange).toDouble()
        priceChangePercent = try container.decode(String.self, forKey: .priceChangePercent).toDouble()
        weightedAvgPrice = try container.decode(String.self, forKey: .weightedAvgPrice).toDouble()
        prevClosePrice = try container.decode(String.self, forKey: .prevClosePrice).toDouble()
        lastPrice = try container.decode(String.self, forKey: .lastPrice).toDouble()
        lastQty = try container.decode(String.self, forKey: .lastQty).toDouble()
        bidPrice = try container.decode(String.self, forKey: .bidPrice).toDouble()
        askPrice = try container.decode(String.self, forKey: .askPrice).toDouble()
        openPrice = try container.decode(String.self, forKey: .openPrice).toDouble()
        highPrice = try container.decode(String.self, forKey: .highPrice).toDouble()
        lowPrice = try container.decode(String.self, forKey: .lowPrice).toDouble()
        volume = try container.decode(String.self, forKey: .volume).toDouble()
        quoteVolume = try container.decode(String.self, forKey: .quoteVolume).toDouble()

        openTime = try container.decode(Date.self, forKey: .openTime)
        closeTime = try container.decode(Date.self, forKey: .closeTime)
        fristId = try container.decode(Int64.self, forKey: .fristId)
        lastId = try container.decode(Int64.self, forKey: .lastId)
        count = try container.decode(Int.self, forKey: .count)
    }
}

extension BnResponse.Price {
    private enum CodingKeys: String, CodingKey {
        case symbol, price
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try container.decode(BnSymbol.self, forKey: .symbol)
        price = try container.decode(String.self, forKey: .price).toDouble()
    }
}

extension BnResponse.BookTicker {
    private enum CodingKeys: String, CodingKey {
        case symbol, bidPrice, bidQuantity = "bidQty", askPrice, askQuantity = "askQty"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try container.decode(BnSymbol.self, forKey: .symbol)
        bidPrice = try container.decode(String.self, forKey: .bidPrice).toDouble()
        bidQuantity = try container.decode(String.self, forKey: .bidQuantity).toDouble()
        askPrice = try container.decode(String.self, forKey: .askPrice).toDouble()
        askQuantity = try container.decode(String.self, forKey: .askQuantity).toDouble()
    }
}

extension BnResponse.Account.Balance {
    private enum CodingKeys: String, CodingKey {
        case asset, free, locked
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        asset = try container.decode(BnAsset.self, forKey: .asset)
        free = try container.decode(String.self, forKey: .free).toDouble()
        locked = try container.decode(String.self, forKey: .locked).toDouble()
    }
}

extension BnResponse.Order.Result {
    private enum CodingKeys: String, CodingKey {
        case symbol, orderId, clientOrderId, transactTime, price, originalQuantity = "origQty", executedQuantity = "executedQty", status, timeInForce, type, side
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try container.decode(BnSymbol.self, forKey: .symbol)
        orderId = try container.decode(Int64.self, forKey: .orderId)
        clientOrderId = try container.decode(String.self, forKey: .clientOrderId)
        transactTime = try container.decode(Date.self, forKey: .transactTime)

        price = try container.decode(String.self, forKey: .price).toDouble()
        originalQuantity = try container.decode(String.self, forKey: .originalQuantity).toDouble()
        executedQuantity = try container.decode(String.self, forKey: .executedQuantity).toDouble()
        status = try container.decode(BnOrderStatus.self, forKey: .status)
        timeInForce = try container.decode(BnTimeInForce.self, forKey: .timeInForce)
        type = try container.decode(BnOrderType.self, forKey: .type)
        side = try container.decode(BnOrderSide.self, forKey: .side)
    }
}

extension BnResponse.Order.Full.Fill {
    private enum CodingKeys: String, CodingKey {
        case price, quantity = "qty", commission, commissionAsset
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        price = try container.decode(String.self, forKey: .price).toDouble()
        quantity = try container.decode(String.self, forKey: .quantity).toDouble()
        commission = try container.decode(String.self, forKey: .commission).toDouble()
        commissionAsset = try container.decode(BnAsset.self, forKey: .commissionAsset)
    }
}

extension BnResponse.Order.Full {
    private enum CodingKeys: String, CodingKey {
        case symbol, orderId, clientOrderId, transactTime, price, originalQuantity = "origQty", executedQuantity = "executedQty", status, timeInForce, type, side, fills
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try container.decode(BnSymbol.self, forKey: .symbol)
        orderId = try container.decode(Int64.self, forKey: .orderId)
        clientOrderId = try container.decode(String.self, forKey: .clientOrderId)
        transactTime = try container.decode(Date.self, forKey: .transactTime)

        price = try container.decode(String.self, forKey: .price).toDouble()
        originalQuantity = try container.decode(String.self, forKey: .originalQuantity).toDouble()
        executedQuantity = try container.decode(String.self, forKey: .executedQuantity).toDouble()
        status = try container.decode(BnOrderStatus.self, forKey: .status)
        timeInForce = try container.decode(BnTimeInForce.self, forKey: .timeInForce)
        type = try container.decode(BnOrderType.self, forKey: .type)
        side = try container.decode(BnOrderSide.self, forKey: .side)
        fills = try container.decode([Fill].self, forKey: .fills)
    }
}

extension BnResponse.QueryOrder {
    private enum CodingKeys: String, CodingKey {
        case symbol, orderId, clientOrderId, price, originalQuantity = "origQty", executedQuantity = "executedQty", status, timeInForce, type, side, isMaker, stopPrice, icebergQuantity = "icebergQty", time, isWorking
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try container.decode(BnSymbol.self, forKey: .symbol)
        orderId = try container.decode(Int64.self, forKey: .orderId)
        clientOrderId = try container.decode(String.self, forKey: .clientOrderId)
        price = try container.decode(String.self, forKey: .price).toDouble()
        originalQuantity = try container.decode(String.self, forKey: .originalQuantity).toDouble()
        executedQuantity = try container.decode(String.self, forKey: .executedQuantity).toDouble()
        status = try container.decode(BnOrderStatus.self, forKey: .status)
        timeInForce = try container.decode(BnTimeInForce.self, forKey: .timeInForce)
        type = try container.decode(BnOrderType.self, forKey: .type)
        side = try container.decode(BnOrderSide.self, forKey: .side)
        stopPrice = try container.decode(String.self, forKey: .stopPrice).toDouble()
        icebergQuantity = try container.decode(String.self, forKey: .icebergQuantity).toDouble()
        time = try container.decode(Date.self, forKey: .time)
        isWorking = try container.decode(Bool.self, forKey: .isWorking)
    }
}

extension BnResponse.MyTrades {
    private enum CodingKeys: String, CodingKey {
        case id, orderId, price, quantity = "qty", commission, commissionAsset, time, isBuyer, isMaker, isBestMatch
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        orderId = try container.decode(Int64.self, forKey: .orderId)
        price = try container.decode(String.self, forKey: .price).toDouble()
        quantity = try container.decode(String.self, forKey: .quantity).toDouble()
        commission = try container.decode(String.self, forKey: .commission).toDouble()
        commissionAsset = try container.decode(BnAsset.self, forKey: .commissionAsset)
        time = try container.decode(Date.self, forKey: .time)
        isBuyer = try container.decode(Bool.self, forKey: .isBuyer)
        isMaker = try container.decode(Bool.self, forKey: .isMaker)
        isBestMatch = try container.decode(Bool.self, forKey: .isBestMatch)
    }
}
