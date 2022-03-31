//
//  Home.swift
//  FastingTracker
//
//  Created by Shameem Reza on 31/3/22.
//

import SwiftUI

struct Home: View {
    @StateObject var fastingManager = FasingManager()
    
    var title: String {
        switch fastingManager.fastingState {
            
        case .notStarted:
            return "Let's Get Started! 💐"
        case .fasting:
            return "You are Fasting! 💪"
        case .feeding:
            return "You are Eating! 👌"
        }
    }
    
    var body: some View {
        // MARK: HOME
        ZStack {
            // MARK: - TOP SECTION
            VStack(spacing: 40) {
                //MARK: - TITLE
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color("circle1"))
                
                //MARK: FASTING PLAN
                Text(fastingManager.fastingPlan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                
                Spacer()
            } // END TOP SECTION
            .padding()
            
            // MARK: BODY SECTION
            
            VStack(spacing: 40) {
                // MARK: - PROGRESS CIRCLE SECTION
                ProgressCircle()
                    .environmentObject(fastingManager)
                
                // MARK: TIMER SECTINON
                HStack(spacing: 60) {
                    // MARK: START TIME
                    VStack(spacing: 5) {
                        Text(fastingManager.fastingState == .notStarted ? "Start" : "Started")
                            .opacity(0.7)
                        
                        Text(fastingManager.startTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    } // END START TIME
                    
                    // MARK: FINISHED TIME
                    VStack(spacing: 5) {
                        Text(fastingManager.fastingState == .notStarted ? "End" : "Ends")
                            .opacity(0.7)
                        
                        Text(fastingManager.endTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    } // END FINISHED TIME
                } // END TIMER SECTION
                
                // MARK: START AND END BUTTON
                Button {
                    fastingManager.toggleFastinState()
                } label: {
                    Text(fastingManager.fastingState == .fasting ? "END FASTING" : "START FASTING")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                }
            } // END BODY
            .padding()
        } // END HOME
        .foregroundColor(.white)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
