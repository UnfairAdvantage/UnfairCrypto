//
//  BnRestAPI.swift
//  CremonaBot
//
//  Created by Gustaf Kugelberg on 2018-02-02.
//  Copyright © 2018 Cremona. All rights reserved.
//

import Foundation
import Alamofire

public class BnRestAPI {
    public var recvWindow: Int64?

    private let baseUrl: URL
    private let apiToken: String
    private let apiSecret: String

    private let decoder = JSONDecoder()

    public init(baseUrl: String, apiToken: String, apiSecret: String) {
        self.baseUrl = URL(string: baseUrl)!
        self.apiToken = apiToken
        self.apiSecret = apiSecret
        decoder.dateDecodingStrategy = .millisecondsSince1970
    }

    public func request<T: Decodable>(at endpoint: String, with method: RestMethod = .get, query: [URLQueryItem] = [], security: BnSecurity = .none, handle: @escaping (T) -> Void) {
        print("BN SENDING REQ: \(endpoint), QUERY:  \(query)")

        let headers: HTTPHeaders
        var queryItems = query
        guard let components = NSURLComponents(url: baseUrl.appendingPathComponent(endpoint), resolvingAgainstBaseURL: false) else { return }

        switch security {
        case .none:
            headers = [:]
        case .apiKey:
            headers = httpHeaders
        case .signature:
            queryItems.append(URLQueryItem(name: "timestamp", value: String(Binance.timestamp)))

            if let recvWindow = recvWindow {
                queryItems.append(URLQueryItem(name: "recvWindow", value: String(recvWindow)))
            }

            components.queryItems = queryItems
            let signature = Binance.signature(secret: apiSecret, allParams: components.query!)
            let signatureItem = URLQueryItem(name: "signature", value: signature)

            queryItems.append(signatureItem)
            components.queryItems = queryItems

            headers = httpHeaders
        }

        guard let url = components.url else { return }

        Alamofire
            .request(url, method: method.http, headers: headers)
            .responseData { response in
                switch response.result {
                case .success(let json):
//                    print("Bn Reply \(T.self):\n\(String(data: json, encoding: .utf8) ?? "[EMPTY]")")

                    do {
                        handle(try self.decoder.decode(T.self, from: json))
                    }
                    catch {
                        print("BnRest (\(T.self)): error parsing\n\(error)\n\n\(String(data: json, encoding: .utf8) ?? "[EMPTY]")")
                    }

                case .failure(let error):
                    print("Request \(endpoint) failed with error: \(error)")
                }
        }
    }

    // MARK - Helpers

    private var httpHeaders: HTTPHeaders {
        return ["X-MBX-APIKEY" : apiToken]
    }
}
