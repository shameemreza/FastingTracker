//
//  ProgressCircle.swift
//  FastingTracker
//
//  Created by Shameem Reza on 31/3/22.
//

import SwiftUI

struct ProgressCircle: View {
    
    @EnvironmentObject var fastingManager: FasingManager
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    
    var body: some View {
        ZStack {
            // MARK: PLACEHOLDER CIRCLE
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            // MARK: CLORED CIRCLE
            Circle()
                .trim(from: 0.0, to: min(fastingManager.progress, 1.0))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color("circle1"), Color("circle2"), Color("circle3"), Color("circle4"), Color("circle5")]), center: .center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect((Angle(degrees: 270)))
                .animation(.easeInOut, value: fastingManager.progress)
            
            
            // MARK: - TIMER AND TEXT
            
            if fastingManager.fastingState == .notStarted {
                // MARK: - UPCOMING FAST
                VStack(spacing: 5) {
                    Text("Upcoming Fast")
                        .opacity(0.7)
                    
                    Text("\(fastingManager.fastingPlan.fastingPeriod.formatted()) Hours")
                        .font(.title)
                        .fontWeight(.bold)
                } // END UPCOMING FAST
            } else {
                VStack(spacing: 30) {
                    // MARK: - ELAPSED TIME
                    VStack(spacing: 5) {
                        Text("Elapsed Time (\(fastingManager.progress.formatted(.percent)))")
                            .opacity(0.7)
                        
                        Text(fastingManager.startTime, style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                    } // END ELAPSED TIME
                    .padding(.top)
                    
                    // MARK: - REMAINING TIME
                    VStack(spacing: 5) {
                        if !fastingManager.elapsed {
                            Text("Remaining Time (\((1 - fastingManager.progress).formatted(.percent)))")
                                .opacity(0.7)
                        } else {
                            Text("Extra Time")
                                .opacity(0.7)
                        }
                        
                        Text(fastingManager.endTime, style: .timer)
                            .font(.title2)
                            .fontWeight(.bold)
                    } // END REMAINING TIME
                } // END VSTACK
            }
            
        } // END ZSTACK
        .frame(width: 250, height: 250)
        .padding()
//        .onAppear {
//            fastingManager.progress = 1
//        }
        .onReceive(timer) {_ in
            fastingManager.track()
        }
    }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircle()
            .environmentObject(FasingManager())
    }
}
