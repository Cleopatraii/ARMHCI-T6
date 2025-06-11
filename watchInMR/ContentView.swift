//
//  ContentView.swift
//  watchInMR
//
//  Created by Cleopatra on 2025/6/7.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var sessionManager: SessionManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("📱 Received Sensor Data")
                    .font(.title2)
                    .bold()

                Group {
                    Text("🧭 Accelerometer")
                        .font(.headline)
                    if sessionManager.accelData.isEmpty {
                        Text("No accel data yet.")
                    } else {
                        ForEach(sessionManager.accelData.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                            Text("\(key): \(value)")
                        }
                    }
                }

                Divider()

                Group {
                    Text("🌀 Gyroscope")
                        .font(.headline)
                    if sessionManager.gyroData.isEmpty {
                        Text("No gyro data yet.")
                    } else {
                        ForEach(sessionManager.gyroData.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                            Text("\(key): \(value)")
                        }
                    }
                }
                
                Group {
                                Text("🎯 Shake Gesture")
                                if sessionManager.shakeData.isEmpty {
                                    Text("No gesture detected")
                                } else {
                                    Text("Gesture: \(sessionManager.shakeData["gesture"] ?? "-")")
                                    Text("Direction: \(sessionManager.shakeData["direction"] ?? "-")")
                                }
                            }
                
                
            }
            .padding()
        }
    }
}
