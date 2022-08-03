//
//  WebSocketStream.swift
//  Bitcoin
//
//  Created by peo on 2022/08/03.
//

import Foundation
import SwiftUI

final class WebSocketStream: NSObject, ObservableObject {
    
    let urlSession: URLSession
    let webSocketTask: URLSessionWebSocketTask
    
    init(
        url: String = "wss://stream.binance.com:9443/stream?streams=btcusdt@miniTicker",
        session: URLSession = URLSession.shared
    ) {
        urlSession = session
        webSocketTask = urlSession.webSocketTask(with: URL(string: url)!)
        webSocketTask.resume()
    }
    
    func listenForMessages() async -> Coin? {
        do {
            let message = try await webSocketTask.receive()
            switch message {
            case .string(let string):
                if let data = string.data(using: .utf8) {
                    return try JSONDecoder().decode(Response.self, from: data).data
                }
            case .data(let data):
                return try JSONDecoder().decode(Response.self, from: data).data
            @unknown default:
                fatalError()
            }
        } catch {
            fatalError()
        }
        return nil
    }
}

extension WebSocketStream: URLSessionWebSocketDelegate {
    
    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didOpenWithProtocol protocol: String?
    ) {
        print("didOpenWithProtocol")
    }
    
    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didCloseWith closeCode: URLSessionWebSocketTask.CloseCode,
        reason: Data?
    ) {
        print("didCloseWith")
    }
}
