//
//  MainView.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 20/02/2025.
//

import SwiftUI

//MARK: - View assembling
struct MainView: View {
    var body: some View {
        VStack {
            Image(systemName: "smiley")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("There we go!")
        }
        .padding()
    }
}

#Preview {
    MainView()
}
