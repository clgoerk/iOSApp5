//
//  ContentView.swift
//  iOSApp5 Watch App
//
//  Created by Chris Goerk on 2025-03-19.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      VStack {
        Text("Choose a Timer")
          .font(.headline)
          .padding()
        
        // Button to navigate to Timer View
        NavigationLink(destination: TimerView()) {
          Text("Timer")
            .font(.title2)
            .padding()
            .frame(width: 200, height: 50)
            .background(Color(red: 0.0, green: 0.0, blue: 0.9))
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: .white, radius: 5, x: 0, y: 0)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.bottom, 10)
        
        // Button to navigate to Stopwatch View
        NavigationLink(destination: StopwatchView()) {
          Text("Stopwatch")
            .font(.title2)
            .padding()
            .frame(width: 200, height: 50)
            .background(Color(red: 0.0, green: 0.0, blue: 0.9))
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: .white, radius: 5, x: 0, y: 0)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.bottom, 5)
      }
    }
  } // body
} // ContentView

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
} // ContentView_Previews
