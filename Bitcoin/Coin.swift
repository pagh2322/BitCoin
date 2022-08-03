//
//  Coin.swift
//  Bitcoin
//
//  Created by peo on 2022/08/03.
//

struct Coin: Codable, Equatable {
    var e: String
    var E: Double
    var s: String
    var c: String
    var o: String
    var h: String
    var l: String
    var v: String
    var q: String
}

struct Response: Codable {
    var stream: String
    var data: Coin
}
