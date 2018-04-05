//
//  MyTest.swift
//  UnfairCrypto
//
//  Created by Gustaf Kugelberg on 2018-04-02.
//

import Foundation

public class MyClass {
    public static func test() {
        #if os(iOS)
        let myVar = "iOS"
        #elseif os(macOS)
        let myVar = "macOS"
        #endif

        print(myVar)

        Bitmex.rest
            .apiKey
            .get
            .handle { result in
                switch result {
                case .success(let value):
                    print("SUCCESS: Downloaded api keys: \(value.map { $0.name}.joined(separator: ", "))" )
                case .failure(let error):
                    print("FAILURE: \(error)")
                }
        }
    }
}
