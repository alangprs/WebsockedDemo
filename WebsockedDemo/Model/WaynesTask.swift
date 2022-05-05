//
//  WaynesTask.swift
//  WebsockedDemo
//
//  Created by 翁燮羽 on 2022/5/3.
//

import Foundation
import Starscream

class StarscreamWebSocket {
    var webSocket: WebSocket?
    var displayMessages: DisplayMessages?
    var didData: (([DataClass]) -> Void)?

    ///連線方法
    func connect() {
        guard let url = URL(string: "wss://stream.yshyqxx.com/stream?streams=btcusdt@trade") else {
            print("Error: can not create URL")
            return
        }

        let request = URLRequest(url: url)

        webSocket = WebSocket(request: request)
        webSocket?.delegate = self

        webSocket?.connect()
    }

    ///斷線方法
    func disconnect() {
        webSocket?.disconnect()
    }
}

extension StarscreamWebSocket: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(_):
            print("WebSocket is connected")
        case .disconnected(let reason, let code):
            print("Disconnected: code=\(code), reason=\(reason)")
        case .text(let message):
            do {
                let result = try JSONDecoder().decode(DisplayMessages.self, from: Data(message.utf8))
                displayMessages = result
                didData?([result.data])
            } catch {
                print("didReceive event error", error)
            }
        case .binary(_):
            break
        case .pong(_):
            break
        case .ping(_):
            break
        case .error(let error):
            print(error ?? "")
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            print("WebSocket is cancelled")
        }
    }
}

// MARK: - DisplayMessages
struct DisplayMessages: Codable {
    let stream: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let dataE: String
    let e: Int
    let s: String
    let dataT: Int
    let p, q: String
    let b, a, t: Int
    let dataM, m: Bool

    enum CodingKeys: String, CodingKey {
        case dataE = "e"
        case e = "E"
        case s
        case dataT = "t"
        case p, q, b, a
        case t = "T"
        case dataM = "m"
        case m = "M"
    }
}

