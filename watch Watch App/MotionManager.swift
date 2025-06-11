//
//  MotionManager.swift
//  watchInMR
//
//  Created by Cleopatra on 2025/6/7.
//

import Foundation
import CoreMotion
import WatchConnectivity
import Combine

class MotionManager: NSObject, ObservableObject, WCSessionDelegate {
    private let motionManager = CMMotionManager()

    // 用于可视化
    @Published var accelX: Double = 0.0
    @Published var accelY: Double = 0.0
    @Published var accelZ: Double = 0.0

    @Published var gyroX: Double = 0.0
    @Published var gyroY: Double = 0.0
    @Published var gyroZ: Double = 0.0

    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }

    func start() {
        guard motionManager.isAccelerometerAvailable else { return }

        // Gyroscope 可选启用
        // guard motionManager.isGyroAvailable else {
        //     print("Gyroscope not available")
        //     return
        // }

        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data, error in
            guard let data = data else { return }

            // 更新 UI
            DispatchQueue.main.async {
                self.accelX = data.acceleration.x
                self.accelY = data.acceleration.y
                self.accelZ = data.acceleration.z
            }

            // 构造加速度数据发送
            let accelMessage: [String: Any] = [
                "accelX": data.acceleration.x,
                "accelY": data.acceleration.y,
                "accelZ": data.acceleration.z,
                "timestamp": Date().timeIntervalSince1970
            ]

            if WCSession.default.isReachable {
                WCSession.default.sendMessage(accelMessage, replyHandler: nil)
            }
        }

        motionManager.deviceMotionUpdateInterval = 0.2
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { data, error in
            guard let motion = data else { return }

            DispatchQueue.main.async {
                self.gyroX = motion.rotationRate.x
                self.gyroY = motion.rotationRate.y
                self.gyroZ = motion.rotationRate.z
            }

            let gyroMessage: [String: Any] = [
                "gyroX": motion.rotationRate.x,
                "gyroY": motion.rotationRate.y,
                "gyroZ": motion.rotationRate.z,
                "timestamp": Date().timeIntervalSince1970
            ]

            if WCSession.default.isReachable {
                WCSession.default.sendMessage(gyroMessage, replyHandler: nil)
            }
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // 可选：处理激活状态
    }
}
