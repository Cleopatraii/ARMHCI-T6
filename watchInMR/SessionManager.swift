//
//  SessionManager.swift
//  watchInMR
//
//  Created by Cleopatra on 2025/6/8.
//
import WatchConnectivity

class SessionManager: NSObject, ObservableObject, WCSessionDelegate {
    @Published var accelData: [String: Any] = [:]
    @Published var gyroData: [String: Any] = [:]
    @Published var shakeData: [String: Any] = [:]
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
            print("✅ WCSession activated on iPhone")
        }
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            print("📥 Message received: \(message)")
            
            if message.keys.contains("accelX") {
                           self.accelData = message
                           print("📥 Received accel data: \(message)")
                       } else if message.keys.contains("gyroX") {
                           self.gyroData = message
                           print("📥 Received gyro data: \(message)")
                       } else if message.keys.contains("gesture") {
                           self.shakeData = message
                           print("📥 Received shake gesture: \(message)")
                
            }
        }
    }

    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
}
