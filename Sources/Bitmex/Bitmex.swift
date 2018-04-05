//
//  Bitmex.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-02-01.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation
import CryptoSwift

public struct Bitmex {
    
    // MARK - Public

    /** The web socket interface of Bitmex */
    public static let socket = BxSocketAPI(baseUrl: socketUrl, apiId: api.id, apiSecret: api.secret)

    /** The rest interface of Bitmex */
    public static let rest = BxRestAPI(baseUrl: restUrl, apiId: api.id, apiSecret: api.secret)

    // MARK - Private

    private init() {}
    private static let socketUrl = "wss://www.bitmex.com/realtime"
    private static let restUrl = "https://www.bitmex.com/api/v1/"

    /** Set up Bitmex with API id and API secret */
    public static func setup(id: String, secret: String) {
        api.id = id
        api.secret = secret
    }

    private class ApiDetails {
        var id = "---"
        var secret = "---"
    }

    private static let api = ApiDetails()

    // MARK - Internal

    static var nonce: Int64 { return Int64(round(Date().timeIntervalSinceReferenceDate*1000)) }

    static func signature(secret: String, verb: Method, path: String, nonce: Int64, data: String = "") -> String {
        let string = verb.rawValue + path + String(nonce) + data
        return try! HMAC(key: secret, variant: .sha256).authenticate(Array(string.utf8)).toHexString()
    }
}

public struct BxInstrumentOld: Decodable, CustomStringConvertible {
    public let symbol: String
    public let rootSymbol: RootSymbol
    public let expiry: Date?

    public let fairBasisRate: Float

    public var description: String {
        return "\(symbol): \(Int(round(fairBasisRate*100)))%"
    }
}

//public struct BxPosition: Decodable, CustomStringConvertible {
//    public let account: Int
//    public let symbol: String
//    public let currency: String
//    public let underlying: String
//
//    public let lastValue: Float
//
//    public var description: String {
//        return "\(symbol): \(underlying) > \(lastValue)"
//    }
//}

public enum RootSymbol: String, Decodable {
    static var all: [RootSymbol] {
        return [.xbt, .ada, .bch, .dash, .eth, .etc, .ltc, .xmr, .xrp, .xlm, .zec, .neo]
    }

    case xbt = "XBT"
    case ada = "ADA"
    case bch = "BCH"
    case dash = "DASH"
    case eth = "ETH"
    case etc = "ETC"
    case ltc = "LTC"
    case xmr = "XMR"
    case xrp = "XRP"
    case xlm = "XLM"
    case zec = "ZEC"
    case neo = "NEO"

    init?(bxSymbol: String) {
        guard let rootSymbol = RootSymbol.all.first(where: { bxSymbol.hasPrefix($0.bxRootSymbol) }) else {
            return nil
        }

        self = rootSymbol
    }

    init?(bnSymbol: String) {
        guard let rootSymbol = RootSymbol.all.first(where: { bnSymbol == $0.bnStream }) else {
            return nil
        }

        self = rootSymbol
    }

    public var decimals: Int {
        switch self {
        case .xbt: return 1
        case .ada: return 8
        case .bch: return 4
        case .dash: return 6
        case .eth: return 5
        case .etc: return 6
        case .ltc: return 5
        case .xmr: return 6
        case .xrp: return 8
        case .xlm: return 8
        case .zec: return 5
        case .neo: return 5 // fixme
        }
    }

    public var bnStream: String {
        switch self {
        case .xbt: return "btcusdt"
        case .ada: return "adabtc"
        case .bch: return "bccbtc"
        case .dash: return "dashbtc"
        case .eth: return "ethbtc"
        case .etc: return "etcbtc"
        case .ltc: return "ltcbtc"
        case .xmr: return "xmrbtc"
        case .xrp: return "xrpbtc"
        case .xlm: return "xlmbtc"
        case .zec: return "zecbtc"
        case .neo: return "zecbtc" // fixme
        }
    }

    //    public var bnSymbol: String {
    //        switch self {
    //        case .xbt: return "btcusdt"
    //        case .ada: return "adabtc"
    //        case .bch: return "bccbtc"
    //        case .dash: return "dashbtc"
    //        case .eth: return "ethbtc"
    //        case .etc: return "etcbtc"
    //        case .ltc: return "ltcbtc"
    //        case .xmr: return "xmrbtc"
    //        case .xrp: return "xrpbtc"
    //        case .xlm: return "xlmbtc"
    //        case .zec: return "zecbtc"
    //        }
    //    }

    public var bxRootSymbol: String {
        return rawValue
    }
}



