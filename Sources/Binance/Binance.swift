//
//  Binance.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-02-01.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation
import CryptoSwift

public struct Binance {
    // MARK - Private

    private init() { }

    private static let socketUrl = "wss://stream.binance.com:9443/stream"
    private static let restUrl = "https://api.binance.com/api"

    private class ApiDetails {
        var token = "---"
        var secret = "---"
    }

    private static let api = ApiDetails()

    // MARK - Public

    public static func setup(token: String, secret: String) {
        api.token = token
        api.secret = secret
    }

    public static let socket = BnSocketAPI(baseUrl: socketUrl, apiToken: api.token, apiSecret: api.secret)
    public static let rest = BnRestAPI(baseUrl: restUrl, apiToken: api.token, apiSecret: api.secret)

    // MARK - Authorisation Helpers

    public static var timestamp: Int64 { return Int64(Date().timeIntervalSince1970*1000) }

    public static func signature(secret: String, allParams: String) -> String {
        return try! HMAC(key: secret, variant: .sha256).authenticate(Array(allParams.utf8)).toHexString()
    }
}

public enum BnSymbol: String, Codable, StringConvertible {
    public init?(base: BnAsset, quote: BnAsset) {
        self.init(rawValue: base.rawValue + quote.rawValue)
    }

    public var quoteAsset: BnAsset { return assets.quote }

    public var baseAsset: BnAsset { return assets.base }

    case ethbtc = "ETHBTC"
    case ltcbtc = "LTCBTC"
    case bnbbtc = "BNBBTC"
    case neobtc = "NEOBTC"
    case _123456 = "123456"
    case qtumeth = "QTUMETH"
    case eoseth = "EOSETH"
    case snteth = "SNTETH"
    case bnteth = "BNTETH"
    case bccbtc = "BCCBTC"
    case gasbtc = "GASBTC"
    case bnbeth = "BNBETH"
    case btcusdt = "BTCUSDT"
    case ethusdt = "ETHUSDT"
    case hsrbtc = "HSRBTC"
    case oaxeth = "OAXETH"
    case dnteth = "DNTETH"
    case mcoeth = "MCOETH"
    case icneth = "ICNETH"
    case mcobtc = "MCOBTC"
    case wtcbtc = "WTCBTC"
    case wtceth = "WTCETH"
    case lrcbtc = "LRCBTC"
    case lrceth = "LRCETH"
    case qtumbtc = "QTUMBTC"
    case yoyobtc = "YOYOBTC"
    case omgbtc = "OMGBTC"
    case omgeth = "OMGETH"
    case zrxbtc = "ZRXBTC"
    case zrxeth = "ZRXETH"
    case stratbtc = "STRATBTC"
    case strateth = "STRATETH"
    case snglsbtc = "SNGLSBTC"
    case snglseth = "SNGLSETH"
    case bqxbtc = "BQXBTC"
    case bqxeth = "BQXETH"
    case kncbtc = "KNCBTC"
    case knceth = "KNCETH"
    case funbtc = "FUNBTC"
    case funeth = "FUNETH"
    case snmbtc = "SNMBTC"
    case snmeth = "SNMETH"
    case neoeth = "NEOETH"
    case iotabtc = "IOTABTC"
    case iotaeth = "IOTAETH"
    case linkbtc = "LINKBTC"
    case linketh = "LINKETH"
    case xvgbtc = "XVGBTC"
    case xvgeth = "XVGETH"
    case ctrbtc = "CTRBTC"
    case ctreth = "CTRETH"
    case saltbtc = "SALTBTC"
    case salteth = "SALTETH"
    case mdabtc = "MDABTC"
    case mdaeth = "MDAETH"
    case mtlbtc = "MTLBTC"
    case mtleth = "MTLETH"
    case subbtc = "SUBBTC"
    case subeth = "SUBETH"
    case eosbtc = "EOSBTC"
    case sntbtc = "SNTBTC"
    case etceth = "ETCETH"
    case etcbtc = "ETCBTC"
    case mthbtc = "MTHBTC"
    case mtheth = "MTHETH"
    case engbtc = "ENGBTC"
    case engeth = "ENGETH"
    case dntbtc = "DNTBTC"
    case zecbtc = "ZECBTC"
    case zeceth = "ZECETH"
    case bntbtc = "BNTBTC"
    case astbtc = "ASTBTC"
    case asteth = "ASTETH"
    case dashbtc = "DASHBTC"
    case dasheth = "DASHETH"
    case oaxbtc = "OAXBTC"
    case icnbtc = "ICNBTC"
    case btgbtc = "BTGBTC"
    case btgeth = "BTGETH"
    case evxbtc = "EVXBTC"
    case evxeth = "EVXETH"
    case reqbtc = "REQBTC"
    case reqeth = "REQETH"
    case vibbtc = "VIBBTC"
    case vibeth = "VIBETH"
    case hsreth = "HSRETH"
    case trxbtc = "TRXBTC"
    case trxeth = "TRXETH"
    case powrbtc = "POWRBTC"
    case powreth = "POWRETH"
    case arkbtc = "ARKBTC"
    case arketh = "ARKETH"
    case yoyoeth = "YOYOETH"
    case xrpbtc = "XRPBTC"
    case xrpeth = "XRPETH"
    case modbtc = "MODBTC"
    case modeth = "MODETH"
    case enjbtc = "ENJBTC"
    case enjeth = "ENJETH"
    case storjbtc = "STORJBTC"
    case storjeth = "STORJETH"
    case bnbusdt = "BNBUSDT"
    case venbnb = "VENBNB"
    case yoyobnb = "YOYOBNB"
    case powrbnb = "POWRBNB"
    case venbtc = "VENBTC"
    case veneth = "VENETH"
    case kmdbtc = "KMDBTC"
    case kmdeth = "KMDETH"
    case nulsbnb = "NULSBNB"
    case rcnbtc = "RCNBTC"
    case rcneth = "RCNETH"
    case rcnbnb = "RCNBNB"
    case nulsbtc = "NULSBTC"
    case nulseth = "NULSETH"
    case rdnbtc = "RDNBTC"
    case rdneth = "RDNETH"
    case rdnbnb = "RDNBNB"
    case xmrbtc = "XMRBTC"
    case xmreth = "XMRETH"
    case dltbnb = "DLTBNB"
    case wtcbnb = "WTCBNB"
    case dltbtc = "DLTBTC"
    case dlteth = "DLTETH"
    case ambbtc = "AMBBTC"
    case ambeth = "AMBETH"
    case ambbnb = "AMBBNB"
    case bcceth = "BCCETH"
    case bccusdt = "BCCUSDT"
    case bccbnb = "BCCBNB"
    case batbtc = "BATBTC"
    case bateth = "BATETH"
    case batbnb = "BATBNB"
    case bcptbtc = "BCPTBTC"
    case bcpteth = "BCPTETH"
    case bcptbnb = "BCPTBNB"
    case arnbtc = "ARNBTC"
    case arneth = "ARNETH"
    case gvtbtc = "GVTBTC"
    case gvteth = "GVTETH"
    case cdtbtc = "CDTBTC"
    case cdteth = "CDTETH"
    case gxsbtc = "GXSBTC"
    case gxseth = "GXSETH"
    case neousdt = "NEOUSDT"
    case neobnb = "NEOBNB"
    case poebtc = "POEBTC"
    case poeeth = "POEETH"
    case qspbtc = "QSPBTC"
    case qspeth = "QSPETH"
    case qspbnb = "QSPBNB"
    case btsbtc = "BTSBTC"
    case btseth = "BTSETH"
    case btsbnb = "BTSBNB"
    case xzcbtc = "XZCBTC"
    case xzceth = "XZCETH"
    case xzcbnb = "XZCBNB"
    case lskbtc = "LSKBTC"
    case lsketh = "LSKETH"
    case lskbnb = "LSKBNB"
    case tntbtc = "TNTBTC"
    case tnteth = "TNTETH"
    case fuelbtc = "FUELBTC"
    case fueleth = "FUELETH"
    case manabtc = "MANABTC"
    case manaeth = "MANAETH"
    case bcdbtc = "BCDBTC"
    case bcdeth = "BCDETH"
    case dgdbtc = "DGDBTC"
    case dgdeth = "DGDETH"
    case iotabnb = "IOTABNB"
    case adxbtc = "ADXBTC"
    case adxeth = "ADXETH"
    case adxbnb = "ADXBNB"
    case adabtc = "ADABTC"
    case adaeth = "ADAETH"
    case pptbtc = "PPTBTC"
    case ppteth = "PPTETH"
    case cmtbtc = "CMTBTC"
    case cmteth = "CMTETH"
    case cmtbnb = "CMTBNB"
    case xlmbtc = "XLMBTC"
    case xlmeth = "XLMETH"
    case xlmbnb = "XLMBNB"
    case cndbtc = "CNDBTC"
    case cndeth = "CNDETH"
    case cndbnb = "CNDBNB"
    case lendbtc = "LENDBTC"
    case lendeth = "LENDETH"
    case wabibtc = "WABIBTC"
    case wabieth = "WABIETH"
    case wabibnb = "WABIBNB"
    case ltceth = "LTCETH"
    case ltcusdt = "LTCUSDT"
    case ltcbnb = "LTCBNB"
    case tnbbtc = "TNBBTC"
    case tnbeth = "TNBETH"
    case wavesbtc = "WAVESBTC"
    case waveseth = "WAVESETH"
    case wavesbnb = "WAVESBNB"
    case gtobtc = "GTOBTC"
    case gtoeth = "GTOETH"
    case gtobnb = "GTOBNB"
    case icxbtc = "ICXBTC"
    case icxeth = "ICXETH"
    case icxbnb = "ICXBNB"
    case ostbtc = "OSTBTC"
    case osteth = "OSTETH"
    case ostbnb = "OSTBNB"
    case elfbtc = "ELFBTC"
    case elfeth = "ELFETH"
    case aionbtc = "AIONBTC"
    case aioneth = "AIONETH"
    case aionbnb = "AIONBNB"
    case neblbtc = "NEBLBTC"
    case nebleth = "NEBLETH"
    case neblbnb = "NEBLBNB"
    case brdbtc = "BRDBTC"
    case brdeth = "BRDETH"
    case brdbnb = "BRDBNB"
    case mcobnb = "MCOBNB"
    case edobtc = "EDOBTC"
    case edoeth = "EDOETH"
    case wingsbtc = "WINGSBTC"
    case wingseth = "WINGSETH"
    case navbtc = "NAVBTC"
    case naveth = "NAVETH"
    case navbnb = "NAVBNB"
    case lunbtc = "LUNBTC"
    case luneth = "LUNETH"
    case trigbtc = "TRIGBTC"
    case trigeth = "TRIGETH"
    case trigbnb = "TRIGBNB"
    case appcbtc = "APPCBTC"
    case appceth = "APPCETH"
    case appcbnb = "APPCBNB"
    case vibebtc = "VIBEBTC"
    case vibeeth = "VIBEETH"
    case rlcbtc = "RLCBTC"
    case rlceth = "RLCETH"
    case rlcbnb = "RLCBNB"
    case insbtc = "INSBTC"
    case inseth = "INSETH"
    case pivxbtc = "PIVXBTC"
    case pivxeth = "PIVXETH"
    case pivxbnb = "PIVXBNB"
    case iostbtc = "IOSTBTC"
    case iosteth = "IOSTETH"
    case chatbtc = "CHATBTC"
    case chateth = "CHATETH"
    case steembtc = "STEEMBTC"
    case steemeth = "STEEMETH"
    case steembnb = "STEEMBNB"
    case nanobtc = "NANOBTC"
    case nanoeth = "NANOETH"
    case nanobnb = "NANOBNB"
    case viabtc = "VIABTC"
    case viaeth = "VIAETH"
    case viabnb = "VIABNB"
    case blzbtc = "BLZBTC"
    case blzeth = "BLZETH"
    case blzbnb = "BLZBNB"
    case aebtc = "AEBTC"
    case aeeth = "AEETH"
    case aebnb = "AEBNB"
    case rpxbtc = "RPXBTC"
    case rpxeth = "RPXETH"
    case rpxbnb = "RPXBNB"

    private var assets: (base: BnAsset, quote: BnAsset) {
        switch self {
        case .ethbtc: return (.eth, .btc)
        case .ltcbtc: return (.ltc, .btc)
        case .bnbbtc: return (.bnb, .btc)
        case .neobtc: return (.neo, .btc)
        case ._123456: return (._123, ._456)
        case .qtumeth: return (.qtum, .eth)
        case .eoseth: return (.eos, .eth)
        case .snteth: return (.snt, .eth)
        case .bnteth: return (.bnt, .eth)
        case .bccbtc: return (.bcc, .btc)
        case .gasbtc: return (.gas, .btc)
        case .bnbeth: return (.bnb, .eth)
        case .btcusdt: return (.btc, .usdt)
        case .ethusdt: return (.eth, .usdt)
        case .hsrbtc: return (.hsr, .btc)
        case .oaxeth: return (.oax, .eth)
        case .dnteth: return (.dnt, .eth)
        case .mcoeth: return (.mco, .eth)
        case .icneth: return (.icn, .eth)
        case .mcobtc: return (.mco, .btc)
        case .wtcbtc: return (.wtc, .btc)
        case .wtceth: return (.wtc, .eth)
        case .lrcbtc: return (.lrc, .btc)
        case .lrceth: return (.lrc, .eth)
        case .qtumbtc: return (.qtum, .btc)
        case .yoyobtc: return (.yoyo, .btc)
        case .omgbtc: return (.omg, .btc)
        case .omgeth: return (.omg, .eth)
        case .zrxbtc: return (.zrx, .btc)
        case .zrxeth: return (.zrx, .eth)
        case .stratbtc: return (.strat, .btc)
        case .strateth: return (.strat, .eth)
        case .snglsbtc: return (.sngls, .btc)
        case .snglseth: return (.sngls, .eth)
        case .bqxbtc: return (.bqx, .btc)
        case .bqxeth: return (.bqx, .eth)
        case .kncbtc: return (.knc, .btc)
        case .knceth: return (.knc, .eth)
        case .funbtc: return (.fun, .btc)
        case .funeth: return (.fun, .eth)
        case .snmbtc: return (.snm, .btc)
        case .snmeth: return (.snm, .eth)
        case .neoeth: return (.neo, .eth)
        case .iotabtc: return (.iota, .btc)
        case .iotaeth: return (.iota, .eth)
        case .linkbtc: return (.link, .btc)
        case .linketh: return (.link, .eth)
        case .xvgbtc: return (.xvg, .btc)
        case .xvgeth: return (.xvg, .eth)
        case .ctrbtc: return (.ctr, .btc)
        case .ctreth: return (.ctr, .eth)
        case .saltbtc: return (.salt, .btc)
        case .salteth: return (.salt, .eth)
        case .mdabtc: return (.mda, .btc)
        case .mdaeth: return (.mda, .eth)
        case .mtlbtc: return (.mtl, .btc)
        case .mtleth: return (.mtl, .eth)
        case .subbtc: return (.sub, .btc)
        case .subeth: return (.sub, .eth)
        case .eosbtc: return (.eos, .btc)
        case .sntbtc: return (.snt, .btc)
        case .etceth: return (.etc, .eth)
        case .etcbtc: return (.etc, .btc)
        case .mthbtc: return (.mth, .btc)
        case .mtheth: return (.mth, .eth)
        case .engbtc: return (.eng, .btc)
        case .engeth: return (.eng, .eth)
        case .dntbtc: return (.dnt, .btc)
        case .zecbtc: return (.zec, .btc)
        case .zeceth: return (.zec, .eth)
        case .bntbtc: return (.bnt, .btc)
        case .astbtc: return (.ast, .btc)
        case .asteth: return (.ast, .eth)
        case .dashbtc: return (.dash, .btc)
        case .dasheth: return (.dash, .eth)
        case .oaxbtc: return (.oax, .btc)
        case .icnbtc: return (.icn, .btc)
        case .btgbtc: return (.btg, .btc)
        case .btgeth: return (.btg, .eth)
        case .evxbtc: return (.evx, .btc)
        case .evxeth: return (.evx, .eth)
        case .reqbtc: return (.req, .btc)
        case .reqeth: return (.req, .eth)
        case .vibbtc: return (.vib, .btc)
        case .vibeth: return (.vib, .eth)
        case .hsreth: return (.hsr, .eth)
        case .trxbtc: return (.trx, .btc)
        case .trxeth: return (.trx, .eth)
        case .powrbtc: return (.powr, .btc)
        case .powreth: return (.powr, .eth)
        case .arkbtc: return (.ark, .btc)
        case .arketh: return (.ark, .eth)
        case .yoyoeth: return (.yoyo, .eth)
        case .xrpbtc: return (.xrp, .btc)
        case .xrpeth: return (.xrp, .eth)
        case .modbtc: return (.mod, .btc)
        case .modeth: return (.mod, .eth)
        case .enjbtc: return (.enj, .btc)
        case .enjeth: return (.enj, .eth)
        case .storjbtc: return (.storj, .btc)
        case .storjeth: return (.storj, .eth)
        case .bnbusdt: return (.bnb, .usdt)
        case .venbnb: return (.ven, .bnb)
        case .yoyobnb: return (.yoyo, .bnb)
        case .powrbnb: return (.powr, .bnb)
        case .venbtc: return (.ven, .btc)
        case .veneth: return (.ven, .eth)
        case .kmdbtc: return (.kmd, .btc)
        case .kmdeth: return (.kmd, .eth)
        case .nulsbnb: return (.nuls, .bnb)
        case .rcnbtc: return (.rcn, .btc)
        case .rcneth: return (.rcn, .eth)
        case .rcnbnb: return (.rcn, .bnb)
        case .nulsbtc: return (.nuls, .btc)
        case .nulseth: return (.nuls, .eth)
        case .rdnbtc: return (.rdn, .btc)
        case .rdneth: return (.rdn, .eth)
        case .rdnbnb: return (.rdn, .bnb)
        case .xmrbtc: return (.xmr, .btc)
        case .xmreth: return (.xmr, .eth)
        case .dltbnb: return (.dlt, .bnb)
        case .wtcbnb: return (.wtc, .bnb)
        case .dltbtc: return (.dlt, .btc)
        case .dlteth: return (.dlt, .eth)
        case .ambbtc: return (.amb, .btc)
        case .ambeth: return (.amb, .eth)
        case .ambbnb: return (.amb, .bnb)
        case .bcceth: return (.bcc, .eth)
        case .bccusdt: return (.bcc, .usdt)
        case .bccbnb: return (.bcc, .bnb)
        case .batbtc: return (.bat, .btc)
        case .bateth: return (.bat, .eth)
        case .batbnb: return (.bat, .bnb)
        case .bcptbtc: return (.bcpt, .btc)
        case .bcpteth: return (.bcpt, .eth)
        case .bcptbnb: return (.bcpt, .bnb)
        case .arnbtc: return (.arn, .btc)
        case .arneth: return (.arn, .eth)
        case .gvtbtc: return (.gvt, .btc)
        case .gvteth: return (.gvt, .eth)
        case .cdtbtc: return (.cdt, .btc)
        case .cdteth: return (.cdt, .eth)
        case .gxsbtc: return (.gxs, .btc)
        case .gxseth: return (.gxs, .eth)
        case .neousdt: return (.neo, .usdt)
        case .neobnb: return (.neo, .bnb)
        case .poebtc: return (.poe, .btc)
        case .poeeth: return (.poe, .eth)
        case .qspbtc: return (.qsp, .btc)
        case .qspeth: return (.qsp, .eth)
        case .qspbnb: return (.qsp, .bnb)
        case .btsbtc: return (.bts, .btc)
        case .btseth: return (.bts, .eth)
        case .btsbnb: return (.bts, .bnb)
        case .xzcbtc: return (.xzc, .btc)
        case .xzceth: return (.xzc, .eth)
        case .xzcbnb: return (.xzc, .bnb)
        case .lskbtc: return (.lsk, .btc)
        case .lsketh: return (.lsk, .eth)
        case .lskbnb: return (.lsk, .bnb)
        case .tntbtc: return (.tnt, .btc)
        case .tnteth: return (.tnt, .eth)
        case .fuelbtc: return (.fuel, .btc)
        case .fueleth: return (.fuel, .eth)
        case .manabtc: return (.mana, .btc)
        case .manaeth: return (.mana, .eth)
        case .bcdbtc: return (.bcd, .btc)
        case .bcdeth: return (.bcd, .eth)
        case .dgdbtc: return (.dgd, .btc)
        case .dgdeth: return (.dgd, .eth)
        case .iotabnb: return (.iota, .bnb)
        case .adxbtc: return (.adx, .btc)
        case .adxeth: return (.adx, .eth)
        case .adxbnb: return (.adx, .bnb)
        case .adabtc: return (.ada, .btc)
        case .adaeth: return (.ada, .eth)
        case .pptbtc: return (.ppt, .btc)
        case .ppteth: return (.ppt, .eth)
        case .cmtbtc: return (.cmt, .btc)
        case .cmteth: return (.cmt, .eth)
        case .cmtbnb: return (.cmt, .bnb)
        case .xlmbtc: return (.xlm, .btc)
        case .xlmeth: return (.xlm, .eth)
        case .xlmbnb: return (.xlm, .bnb)
        case .cndbtc: return (.cnd, .btc)
        case .cndeth: return (.cnd, .eth)
        case .cndbnb: return (.cnd, .bnb)
        case .lendbtc: return (.lend, .btc)
        case .lendeth: return (.lend, .eth)
        case .wabibtc: return (.wabi, .btc)
        case .wabieth: return (.wabi, .eth)
        case .wabibnb: return (.wabi, .bnb)
        case .ltceth: return (.ltc, .eth)
        case .ltcusdt: return (.ltc, .usdt)
        case .ltcbnb: return (.ltc, .bnb)
        case .tnbbtc: return (.tnb, .btc)
        case .tnbeth: return (.tnb, .eth)
        case .wavesbtc: return (.waves, .btc)
        case .waveseth: return (.waves, .eth)
        case .wavesbnb: return (.waves, .bnb)
        case .gtobtc: return (.gto, .btc)
        case .gtoeth: return (.gto, .eth)
        case .gtobnb: return (.gto, .bnb)
        case .icxbtc: return (.icx, .btc)
        case .icxeth: return (.icx, .eth)
        case .icxbnb: return (.icx, .bnb)
        case .ostbtc: return (.ost, .btc)
        case .osteth: return (.ost, .eth)
        case .ostbnb: return (.ost, .bnb)
        case .elfbtc: return (.elf, .btc)
        case .elfeth: return (.elf, .eth)
        case .aionbtc: return (.aion, .btc)
        case .aioneth: return (.aion, .eth)
        case .aionbnb: return (.aion, .bnb)
        case .neblbtc: return (.nebl, .btc)
        case .nebleth: return (.nebl, .eth)
        case .neblbnb: return (.nebl, .bnb)
        case .brdbtc: return (.brd, .btc)
        case .brdeth: return (.brd, .eth)
        case .brdbnb: return (.brd, .bnb)
        case .mcobnb: return (.mco, .bnb)
        case .edobtc: return (.edo, .btc)
        case .edoeth: return (.edo, .eth)
        case .wingsbtc: return (.wings, .btc)
        case .wingseth: return (.wings, .eth)
        case .navbtc: return (.nav, .btc)
        case .naveth: return (.nav, .eth)
        case .navbnb: return (.nav, .bnb)
        case .lunbtc: return (.lun, .btc)
        case .luneth: return (.lun, .eth)
        case .trigbtc: return (.trig, .btc)
        case .trigeth: return (.trig, .eth)
        case .trigbnb: return (.trig, .bnb)
        case .appcbtc: return (.appc, .btc)
        case .appceth: return (.appc, .eth)
        case .appcbnb: return (.appc, .bnb)
        case .vibebtc: return (.vibe, .btc)
        case .vibeeth: return (.vibe, .eth)
        case .rlcbtc: return (.rlc, .btc)
        case .rlceth: return (.rlc, .eth)
        case .rlcbnb: return (.rlc, .bnb)
        case .insbtc: return (.ins, .btc)
        case .inseth: return (.ins, .eth)
        case .pivxbtc: return (.pivx, .btc)
        case .pivxeth: return (.pivx, .eth)
        case .pivxbnb: return (.pivx, .bnb)
        case .iostbtc: return (.iost, .btc)
        case .iosteth: return (.iost, .eth)
        case .chatbtc: return (.chat, .btc)
        case .chateth: return (.chat, .eth)
        case .steembtc: return (.steem, .btc)
        case .steemeth: return (.steem, .eth)
        case .steembnb: return (.steem, .bnb)
        case .nanobtc: return (.nano, .btc)
        case .nanoeth: return (.nano, .eth)
        case .nanobnb: return (.nano, .bnb)
        case .viabtc: return (.via, .btc)
        case .viaeth: return (.via, .eth)
        case .viabnb: return (.via, .bnb)
        case .blzbtc: return (.blz, .btc)
        case .blzeth: return (.blz, .eth)
        case .blzbnb: return (.blz, .bnb)
        case .aebtc: return (.ae, .btc)
        case .aeeth: return (.ae, .eth)
        case .aebnb: return (.ae, .bnb)
        case .rpxbtc: return (.rpx, .btc)
        case .rpxeth: return (.rpx, .eth)
        case .rpxbnb: return (.rpx, .bnb)
        }
    }
}

public enum BnAsset: String, Codable, StringConvertible {
    case btc = "BTC"
    case ltc = "LTC"
    case eth = "ETH"
    case bnc = "BNC"
    case ico = "ICO"
    case neo = "NEO"
    case bnb = "BNB"
    case _123 = "123"
    case _456 = "456"
    case qtum = "QTUM"
    case eos = "EOS"
    case snt = "SNT"
    case bnt = "BNT"
    case gas = "GAS"
    case bcc = "BCC"
    case btm = "BTM"
    case usdt = "USDT"
    case hcc = "HCC"
    case hsr = "HSR"
    case oax = "OAX"
    case dnt = "DNT"
    case mco = "MCO"
    case icn = "ICN"
    case elc = "ELC"
    case pay = "PAY"
    case zrx = "ZRX"
    case omg = "OMG"
    case wtc = "WTC"
    case lrx = "LRX"
    case yoyo = "YOYO"
    case lrc = "LRC"
    case llt = "LLT"
    case trx = "TRX"
    case fid = "FID"
    case sngls = "SNGLS"
    case strat = "STRAT"
    case bqx = "BQX"
    case fun = "FUN"
    case knc = "KNC"
    case cdt = "CDT"
    case xvg = "XVG"
    case iota = "IOTA"
    case snm = "SNM"
    case link = "LINK"
    case cvc = "CVC"
    case tnt = "TNT"
    case rep = "REP"
    case ctr = "CTR"
    case mda = "MDA"
    case mtl = "MTL"
    case salt = "SALT"
    case nuls = "NULS"
    case sub = "SUB"
    case stx = "STX"
    case mth = "MTH"
    case cat = "CAT"
    case adx = "ADX"
    case pix = "PIX"
    case etc = "ETC"
    case eng = "ENG"
    case zec = "ZEC"
    case ast = "AST"
    case a1st = "1ST"
    case gnt = "GNT"
    case dgd = "DGD"
    case bat = "BAT"
    case dash = "DASH"
    case powr = "POWR"
    case btg = "BTG"
    case req = "REQ"
    case xmr = "XMR"
    case evx = "EVX"
    case vib = "VIB"
    case enj = "ENJ"
    case ven = "VEN"
    case cag = "CAG"
    case edg = "EDG"
    case ark = "ARK"
    case xrp = "XRP"
    case mod = "MOD"
    case avt = "AVT"
    case storj = "STORJ"
    case kmd = "KMD"
    case rcn = "RCN"
    case edo = "EDO"
    case qash = "QASH"
    case san = "SAN"
    case data = "DATA"
    case dlt = "DLT"
    case gup = "GUP"
    case mcap = "MCAP"
    case mana = "MANA"
    case ppt = "PPT"
    case otn = "OTN"
    case cfd = "CFD"
    case rdn = "RDN"
    case gxs = "GXS"
    case amb = "AMB"
    case arn = "ARN"
    case bcpt = "BCPT"
    case cnd = "CND"
    case gvt = "GVT"
    case poe = "POE"
    case alis = "ALIS"
    case bts = "BTS"
    case fuel = "FUEL"
    case xzc = "XZC"
    case qsp = "QSP"
    case lsk = "LSK"
    case bcd = "BCD"
    case tnb = "TNB"
    case grx = "GRX"
    case star = "STAR"
    case ada = "ADA"
    case lend = "LEND"
    case ift = "IFT"
    case kick = "KICK"
    case ukg = "UKG"
    case voise = "VOISE"
    case xlm = "XLM"
    case cmt = "CMT"
    case waves = "WAVES"
    case wabi = "WABI"
    case sbtc = "SBTC"
    case bcx = "BCX"
    case gto = "GTO"
    case etf = "ETF"
    case icx = "ICX"
    case ost = "OST"
    case elf = "ELF"
    case aion = "AION"
    case wings = "WINGS"
    case brd = "BRD"
    case nebl = "NEBL"
    case nav = "NAV"
    case vibe = "VIBE"
    case lun = "LUN"
    case trig = "TRIG"
    case appc = "APPC"
    case chat = "CHAT"
    case rlc = "RLC"
    case ins = "INS"
    case pivx = "PIVX"
    case iost = "IOST"
    case steem = "STEEM"
    case nano = "NANO"
    case ae = "AE"
    case via = "VIA"
    case blz = "BLZ"
    case sys = "SYS"
    case rpx = "RPX"
}

