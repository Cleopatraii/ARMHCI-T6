//
//  InterfaceController.swift
//  watchInMR
//
//  Created by Cleopatra on 2025/6/10.
//
// Swift 用 protocol 来表示接口

//选了第三个Delegate模式
//import WatchKit
//import Foundation
//import WatchConnectivity
//import WatchShaker
//
//class InterfaceController: WKInterfaceController {
//
////    override func awake(withContext context: Any?) {
////        super.awake(withContext: context)
////        // Configure interface objects here.
////    }
//
//    var shaker = WatchShaker(shakeSensibility: .shakeSensibilityNormal, delay: 0.2)
//
//    override func willActivate() {
//
//        super.willActivate()
//        shaker.delegate = self
//        shaker.start()
//        
//        if WCSession.isSupported() {
//           WCSession.default.delegate = self
//           WCSession.default.activate()}
//        
//    }
//
//    override func didDeactivate() {
//
//        super.didDeactivate()
//        shaker.stop()
//
//    }
//
//}
//
////// 接收 shake 回调callback
//extension InterfaceController: WatchShakerDelegate
//{
//    //把 self 作为 delegate 交给 shaker，然后 shaker 内部在 shake 时回调
//    func watchShaker(_ watchShaker: WatchShaker, didShakeWith sensibility: ShakeSensibility, direction: ShakeDirection) {
//        let directionString = String(describing: direction)
//        print("💥 SHAKE DETECTED with direction: \(directionString)")
//
//        let message: [String: Any] = [
//            "gesture": "shake",
//            "direction": directionString
//        ]
//
//        if WCSession.default.isReachable {
//            WCSession.default.sendMessage(message, replyHandler: nil) { error in
//                print("❌ Send failed: \(error.localizedDescription)")
//            }
//        } else {
//            print("⚠️ iPhone not reachable")
//        }
//    }
//
//
//    func watchShaker(_ watchShaker: WatchShaker, didFailWith error: Error) {
//        print(error.localizedDescription)
//    }
//}
//
//// 通信
//extension InterfaceController: WCSessionDelegate {
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
//}

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        print("✅ InterfaceController loaded (not used in SwiftUI mode)")
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
}
