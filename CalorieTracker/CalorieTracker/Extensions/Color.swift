//
//  Color.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 20/02/2025.
//

import SwiftUI

extension Color {
    enum backround {
        static let intro = Color("background/intro")
        static let onboarding = Color.white
        static let onboardingDivider = Color.gray
        static let changeLanguagePopup = Color.white
    }
    
    enum text {
        static let onboardingButtonTitle = Color.white
        static let introTitle = Color.black
        static let introSubtitle = Color.black
        static let introIndicator1 = Color.black
        static let introIndicator2 = Color.gray.opacity(0.3)
    }
    
    enum button {
        static let selectedQuestion = Color.black
        static let unselectedQuestion = Color("background/changeLanguageButton")
        static let changeLanguage = Color("background/changeLanguageButton")
        static let onboarding = Color.black
    }
}
