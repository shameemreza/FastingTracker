//
//  ContentView.swift
//  FastingTracker
//
//  Created by Shameem Reza on 27/3/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // MARK: BACKGROUND
            Color("BG")
                .ignoresSafeArea()
            
            Home()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
