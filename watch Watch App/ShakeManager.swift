//
//  ShakeManager.swift
//  watchInMR
//
//  Created by Cleopatra on 2025/6/11.
//

//SwiftUI + ObservableObject
//让一个 ObservableObject 类（这里是 ShakeManager）来：
//管理 WatchShaker 实例，实现 WatchShakerDelegate，将方向信息用 @Published 变量公开

//因为官方的InterfaceController 没继承ObservableObject，也没有 @Published 的变量
import Foundation
import WatchShaker
import WatchConnectivity
import Combine

//继承4个
class ShakeManager: NSObject, ObservableObject, WatchShakerDelegate, WCSessionDelegate {
    private let shaker = WatchShaker(shakeSensibility: .shakeSensibilityNormal, delay: 0.2)

    @Published var direction: String = "—"

    override init() {
        super.init()

        shaker.delegate = self
        shaker.start()

        if WCSession.isSupported() {
            //让 InterfaceController 类实现了 WatchShakerDelegate
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }

    func watchShaker(_ watchShaker: WatchShaker, didShakeWith sensibility: ShakeSensibility, direction: ShakeDirection) {
        let dir = String(describing: direction)

        DispatchQueue.main.async {
            self.direction = dir
        }

        let message: [String: Any] = [
            "gesture": "shake",
            "direction": dir
        ]

        if WCSession.default.isReachable {
            WCSession.default.sendMessage(message, replyHandler: nil)
        }
    }

    func watchShaker(_ watchShaker: WatchShaker, didFailWith error: Error) {
        print("Shake error: \(error.localizedDescription)")
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
}
