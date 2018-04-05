//
//  General.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-01-26.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation

public protocol StringConvertible { var stringValue: String { get } }
extension String: StringConvertible { public var stringValue: String { return self } }
extension Bool: StringConvertible { public var stringValue: String { return self ? "true" : "false" } }
extension Int: StringConvertible { public var stringValue: String { return String(self) } }
extension Int64: StringConvertible { public var stringValue: String { return String(self) } }
extension Double: StringConvertible { public var stringValue: String { return String(self) } }

extension RawRepresentable where RawValue == String { public var stringValue: String { return rawValue } }

extension Array: StringConvertible where Element: StringConvertible {
    public var stringValue: String {
        return self.map { $0.stringValue }.joined(separator: ",")
    }
}

public protocol Subscribable {
    func subscribe(callback: @escaping (Set<String>) -> Void) -> UUID
    func unsubscribe(token: UUID)
}

public protocol QuoteStreamer: Subscribable {
    var bids: [String : [Quote]] { get }
    var asks: [String : [Quote]] { get }
    var state: SocketState { get }
}

public struct Quote: Decodable, Equatable, CustomStringConvertible {
    let price: Double
    let size: Double

    public init(price: Double, size: Double) {
        self.price = price
        self.size = size
    }

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        price = try container.decode(String.self).toDouble()
        size = try container.decode(String.self).toDouble()
    }

    public var description: String {
        return "(price: \(price), size: \(size))"
    }
}

public typealias QuoteBook = (bids: [Quote], asks: [Quote])

extension String {
    func toDouble() throws -> Double {
        guard let double = Double(self) else {
            throw NSError(domain: "JSON", code: 555, userInfo: ["Issue" : "Failed to convert string to double (\(self))"])
        }
        return double
    }
}

