//
//  LanguagePickerView.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 21/02/2025.
//

import SwiftUI

struct LanguagePickerView: View {
    //MARK: - Environment values and objects
    @EnvironmentObject private var languageManager: LanguageManager
    
    //MARK: - States
    @Binding var isPresented: Bool
    
    //MARK: - View assembling
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isPresented = false
                    }
                }
            
            VStack(spacing: 16) {
                ForEach(LanguageRegion.allCases.filter { [LanguageRegion.english, .italian, .turkish].contains($0) }, id: \.self) { language in
                    changeLanguageButton(to: language)
                }
            }
            .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
            .background(Color.backround.changeLanguagePopup)
            .cornerRadius(10)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
    }
    
    func changeLanguageButton(to language: LanguageRegion) -> some View {
        Button(action: {
            changeLanguage(to: language)
            vibration()
            withAnimation(.easeInOut(duration: 0.5)) {
                isPresented = false
            }
        }) {
            changeLanguageButtonView(language: language)
        }
    }
    
    func changeLanguageButtonView(language: LanguageRegion) -> some View {
        HStack {
            Spacer()
            
            Text(language.languageName.capitalized)
            Text(language.flag)
            
            Spacer()
        }
        .font(.subheadline)
        .foregroundStyle(Color.text.introSubtitle)
        .multilineTextAlignment(.center)
        .frame(height: 52)
        .background(Color.button.changeLanguage)
        .cornerRadius(10)
    }
    
    //MARK: - Actions
    
    private func changeLanguage(to language: LanguageRegion) {
        languageManager.changeLanguage(to: language.rawValue)
    }
    
    private func vibration() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

#Preview {
    LanguagePickerView(
        isPresented: .constant(true)
    )
}
