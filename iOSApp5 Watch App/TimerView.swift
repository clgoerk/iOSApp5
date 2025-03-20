//
//  TimerView.swift
//  iOSApp5 Watch App
//
//  Created by Chris Goerk on 2025-03-19.
//

import SwiftUI
import WatchKit

struct TimerView: View {
  @State private var hours: Int = 0
  @State private var minutes: Int = 0
  @State private var seconds: Int = 0
  @State private var timeRemaining: Int = 0
  @State private var timerRunning = false
  @State private var timer: Timer? = nil

  var body: some View {
    VStack {
      Text("Set Timer")
        .font(.headline)

      // Timer Picker (HH:MM:SS)
      HStack {
        Picker("Hours", selection: $hours) {
          ForEach(0..<24, id: \.self) { Text("\($0) h") }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 60, height: 60)

        Picker("Minutes", selection: $minutes) {
          ForEach(0..<60, id: \.self) { Text("\($0) m") }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 60, height: 60)

        Picker("Seconds", selection: $seconds) {
          ForEach(0..<60, id: \.self) { Text("\($0) s") }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 60, height: 60)
      }
      .padding()
      
      // Display with custom LCD font
      Text(formatTime(timeRemaining))
          .font(.custom("LCDAT&TPhoneTimeDate", size: 40))
  
      // Button to start and pause the timer
      HStack {
        Button(action: startTimer) {
            if timerRunning {
                Image(systemName: "pause.fill")
                    .padding()
                    .frame(width: 65, height: 45)
                    .background(Color(red: 0.9, green: 0.9, blue: 0.0))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: .white, radius: 5, x: 0, y: 0)
            } else {
                Image(systemName: "play.fill")
                    .padding()
                    .frame(width: 65, height: 45)
                    .background(Color(red: 0.0, green: 0.0, blue: 0.9))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: .white, radius: 5, x: 0, y: 0)
            }
        }
        .padding()
        
        // Button to reset the timer
        Button(action: resetTimer) {
          Image(systemName: "arrow.counterclockwise")
            .padding()
            .frame(width: 65, height: 45)
            .background(Color(red: 0.0, green: 0.0, blue: 0.9))
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: .white, radius: 5, x: 0, y: 0)
        }
        .padding()
      }
      
    }
    .buttonStyle(PlainButtonStyle())
    .onDisappear { timer?.invalidate() }
  } // body

  // Format time into HH:MM:SS
  private func formatTime(_ seconds: Int) -> String {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let seconds = seconds % 60
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
  } // formatTime()

  // Start or Pause the timer
  private func startTimer() {
    if timerRunning {
      timer?.invalidate()
    } else {
      if timeRemaining == 0 { 
        timeRemaining = (hours * 3600) + (minutes * 60) + seconds
      }

      timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
        if self.timeRemaining > 0 {
          self.timeRemaining -= 1
        } else {
          self.timer?.invalidate()
          self.timerRunning = false
          self.triggerAlarm()
        }
      }
    }
    timerRunning.toggle()
  } // startTimer()

  // Function to trigger default alarm sound and haptic feedback
  private func triggerAlarm() {
    // Haptic feedback
    WKInterfaceDevice.current().play(.notification)

    // Play default system sound
    WKInterfaceDevice.current().play(.success)
  } // triggerAlarm()

  // Reset the timer
  private func resetTimer() {
    timer?.invalidate()
    timerRunning = false
    timeRemaining = 0
  } // resetTimer()
} // TimerView

#Preview {
  TimerView()
} // TimerView_Previews
