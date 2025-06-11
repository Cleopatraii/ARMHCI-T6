//
//  ContentView.swift
//  WatchApp Watch App
//
//  Created by Cleopatra on 2025/6/7.
//

import SwiftUI

struct ContentView: View {
    @StateObject var motionManager = MotionManager()
    @StateObject var shakeManager = ShakeManager()
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text("Real time sensor Data")
                    .font(.headline)

                VStack(alignment: .leading) {
                    Text("🧭 Accelerometer")
                    Text("X: \(motionManager.accelX, specifier: "%.2f")")
                    Text("Y: \(motionManager.accelY, specifier: "%.2f")")
                    Text("Z: \(motionManager.accelZ, specifier: "%.2f")")
                }

                VStack(alignment: .leading) {
                    Text("Gyroscope")
                    Text("X: \(motionManager.gyroX, specifier: "%.2f")")
                    Text("Y: \(motionManager.gyroY, specifier: "%.2f")")
                    Text("Z: \(motionManager.gyroZ, specifier: "%.2f")")
                }
                
                VStack(spacing: 16) {
                           Text("🎯 Shake Direction")
                           Text("Direction: \(shakeManager.direction)")
                               .font(.title2)
                       }
                
            }
            .padding()
        }
        .onAppear {
            motionManager.start()
        }
    }
}

#Preview {
    ContentView()
}
