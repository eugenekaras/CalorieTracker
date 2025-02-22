//
//  ContentView.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 20/02/2025.
//

import SwiftUI

extension ContentView {
    enum ContentType {
        case splashView
        case onboarding
        case paywall
        case mainView
    }
}

struct ContentView: View {
    
    //MARK: - States
    @AppStorage("isOnboardingCompleted") private var isOnboardingCompleted: Bool = false
//    @State private var isOnboardingCompleted: Bool = false
    @State private var contentType: ContentType = .splashView
    @State private var paywallNeedToBeShown: Bool = true
    @State private var doWeNeedShowPaywall: Bool = false
    
    //MARK: - View assembling
    var body: some View {
        let _ = Self._printChanges()
        
        Group {
            switch contentType {
            case .splashView:
                SplashView()
                    .onAppear {
                        DispatchQueue
                            .main
                            .asyncAfter(deadline: .now() + 0.5, execute: updateContentViewState)
                    }
            case .onboarding:
                OnboardingView(completionHandler: completeOnboarding)
            case .paywall:
                PaywallView(completionAction: .execute(completePurcheses))
                    .transition(.backslide)
            case .mainView:
                MainView()
            }
        }
    }
    
    //MARK: - Actions
    private func updateContentViewState() {
        guard isOnboardingCompleted else {
            withAnimation { contentType = .onboarding }
            doWeNeedShowPaywall = true
            return
        }
        
        if paywallNeedToBeShown && doWeNeedShowPaywall {
            withAnimation { contentType = .paywall }
            return
        }
        
        withAnimation { contentType = .mainView }
    }
    
    private func completeOnboarding() {
        isOnboardingCompleted = true
        updateContentViewState()
    }
    
    private func completePurcheses() {
        paywallNeedToBeShown = false
        updateContentViewState()
    }
}

#Preview {
    ContentView()
}
