//
//  StopwatchView.swift
//  iOSApp5 Watch App
//
//  Created by Chris Goerk on 2025-03-19.
//

import SwiftUI

struct StopwatchView: View {
  @State private var elapsedTime: Double = 0
  @State private var stopwatchRunning = false
  @State private var stopwatchTimer: Timer? = nil
  @State private var lapTimes: [Double] = []
  
  var body: some View {
    VStack {
      Text("Stopwatch")
        .font(.headline)
      
      // Timer with custom LCD font
      Text(formatTime(elapsedTime))
        .font(.custom("LCDAT&TPhoneTimeDate", size: 40))
        .padding()
      
      HStack {
        
        // Button to start and stop the stopwatch
        Button(action: {
          self.toggleStopwatch()
        }) {
          if stopwatchRunning {
            Image(systemName: "stop.fill")
              .frame(width: 60, height: 45)
              .background(Color(red: 0.9, green: 0.0, blue: 0.0))
              .foregroundColor(.white)
              .cornerRadius(10)
              .shadow(color: .white, radius: 5, x: 0, y: 0)
          } else {
            Image(systemName: "play.fill")
              .frame(width: 60, height: 45)
              .background(Color(red: 0.0, green: 0.0, blue: 0.9))
              .foregroundColor(.white)
              .cornerRadius(10)
              .shadow(color: .white, radius: 5, x: 0, y: 0)
          }
        }
        
        // Button to reset the stopwatch
        Button(action: {
          self.resetStopwatch()
        }) {
          Image(systemName: "arrow.counterclockwise")
            .frame(width: 60, height: 45)
            .background(Color(red: 0.0, green: 0.0, blue: 0.9))
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: .white, radius: 5, x: 0, y: 0)
        }
        
        // Button to record the lap time
        Button(action: {
          self.recordLap()
        }) {
          Text("Lap")
            .frame(width: 60, height: 45)
            .background(Color(red: 0.0, green: 0.0, blue: 0.9))
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: .white, radius: 5, x: 0, y: 0)
        }
      }
      .padding(.bottom, 10)
      
      // Scrollable lap times
      ScrollView {
        VStack(spacing: 5) {
          ForEach(Array(lapTimes.enumerated()), id: \.element) { index, lap in
            HStack {
              Text("Lap \(index + 1):")
                .font(.custom("LCDAT&TPhoneTimeDate", size: 16))
                .padding(.leading, 50)
              
              Spacer()
              
              Text(formatTime(lap))
                .font(.custom("LCDAT&TPhoneTimeDate", size: 16))
                .padding(.trailing, 50)
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(5)
          }
        }
      }
      .frame(maxHeight: 300)
    }
    .buttonStyle(PlainButtonStyle())
    .onDisappear {
      stopwatchTimer?.invalidate()
    }
  } // body
  
  // Format elapsed time into MM:SS:XX
  private func formatTime(_ time: Double) -> String {
    let minutes = Int(time) / 60
    let seconds = Int(time) % 60
    let hundredths = Int((time * 100).truncatingRemainder(dividingBy: 100))
    return String(format: "%02d:%02d:%02d", minutes, seconds, hundredths)
  } //formatTime()
  
  // Toggle stopwatch between start and stop
  private func toggleStopwatch() {
    if stopwatchRunning {
      stopwatchTimer?.invalidate()
    } else {
      stopwatchTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
        self.elapsedTime += 0.01
      }
    }
    stopwatchRunning.toggle()
  } // toggleStopwatch()
  
  // Reset the stopwatch
  private func resetStopwatch() {
    elapsedTime = 0
    lapTimes = []
    stopwatchTimer?.invalidate()
    stopwatchRunning = false
  } //resetStopwatch()
  
  // Record a lap time
  private func recordLap() {
    lapTimes.append(elapsedTime)
  } // recordLap()
} // StopwatchView

#Preview {
  StopwatchView()
} // StopwatchView_Previews
