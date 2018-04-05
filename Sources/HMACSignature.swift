//
//  HMACSignature.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-01-31.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation
import CryptoSwift

extension String {
    func hmac(key: String, variant: HMAC.Variant) throws -> String {
        return try HMAC(key: key, variant: variant).authenticate(Array(utf8)).toHexString()
    }
}

//extension String {
//    func hmac(algorithm: HMACAlgorithm, key: String) -> String {
//        let cKey = key.cString(using: .utf8)
//        let cData = cString(using: .utf8)
//        var result = [CUnsignedChar](repeating: 0, count: Int(algorithm.digestLength()))
//        CCHmac(algorithm.toCCHmacAlgorithm(), cKey!, Int(strlen(cKey!)), cData!, Int(strlen(cData!)), &result)
//        let hmacData = NSData(bytes: result, length: (Int(algorithm.digestLength())))
//        let hmacBase64 = hmacData.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength76Characters)
//        return String(hmacBase64)
//    }
//
//    func hmacHex(algorithm: HMACAlgorithm, key: String) -> String {
//        let cKey = key.cString(using: .utf8)
//        let cData = cString(using: .utf8)
//        var result = [CUnsignedChar](repeating: 0, count: Int(algorithm.digestLength()))
//        let length = Int(strlen(cKey!))
//        let data = Int(strlen(cData!))
//        CCHmac(algorithm.toCCHmacAlgorithm(), cKey!,length , cData!, data, &result)
//
//        let hmacData = NSData(bytes: result, length: (Int(algorithm.digestLength())))
//
//        var bytes = [UInt8](repeating: 0, count: hmacData.length)
//        hmacData.getBytes(&bytes, length: hmacData.length)
//
//        var hexString = ""
//        for byte in bytes {
//            hexString += String(format:"%02hhx", UInt8(byte))
//        }
//        return hexString
//    }
//}
