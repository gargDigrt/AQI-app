//
//  SocketManager.swift
//  AQI app
//
//  Created by Vivek on 20/06/21.
//

import Foundation

protocol AQIUpdateDelegate: class {
    func didReceiveUpdates(_ cities: [City])
}

class SocketManager {
    var webSocket: WebSocketConnection!
    weak var aqiDelegate: AQIUpdateDelegate!
    func initialize() {
        let wsUrl = URL(string: WEB_SOCKET_SERVER_URL)!
        webSocket = WebSocketTaskConnection(url: wsUrl)
        webSocket.delegate = self
        webSocket.connect()
    }
    
}

extension SocketManager: WebSocketConnectionDelegate {
    func onConnected(connection: WebSocketConnection) {
        print("Connected")
    }
    
    func onDisconnected(connection: WebSocketConnection, error: Error?) {
        if let error = error {
            print("Disconnected with error:\(error)")
        } else {
            print("Disconnected normally")
        }
    }
    
    func onError(connection: WebSocketConnection, error: Error) {
        print("Connection error:\(error)")
    }
    
    func onMessage(connection: WebSocketConnection, text: String) {
        guard let data = text.toData() else {return}
        guard let cities = try? JSONDecoder().decode([City].self, from: data) else {return}
        aqiDelegate.didReceiveUpdates(cities)
    }
    
    func onMessage(connection: WebSocketConnection, data: Data) {
        print("Data message: \(data)")
    }
    
}
