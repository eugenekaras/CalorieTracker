//
//  OnboardingView.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 20/02/2025.
//

import SwiftUI

extension OnboardingView {
    enum OnboardingStep {
        case introduction
        case genderQuestions
        case workoutQuestions
        
        var title: LocalizedStringKey {
            switch self {
            case .introduction:
                return "intro_title1"
            case .genderQuestions:
                return "intro_title2"
            case .workoutQuestions:
                return "intro_title3"
            }
        }
        
        var subtitle: LocalizedStringKey {
            switch self {
            case .introduction:
                return "intro_subtitle1"
            case .genderQuestions:
                return "intro_subtitle2"
            case .workoutQuestions:
                return "intro_subtitle3"
            }
        }
    }
}

struct OnboardingView: View {
    //MARK: - Environment values and objects
    @EnvironmentObject private var languageManager: LanguageManager
    
    //MARK: - States
    @State private var showLanguagePicker = false
    @State private var onboardingStep: OnboardingStep = .introduction
    @State private var genderQuestion: GenderQuestion?
    
    //MARK: - Callbacks
    let completionHandler: () -> Void
    
    //MARK: - View assembling
    var body: some View {
        VStack(spacing: 0) {
            
            Group {
                switch onboardingStep {
                case .introduction:
                    IntroductionView()
                case .genderQuestions:
                    genderQuestionView
                case .workoutQuestions:
                    IntroductionView()
                }
            }

            Divider()
                .foregroundStyle(Color.backround.onboardingDivider)
            
            nextButton
                .padding(EdgeInsets(top: 15, leading: 20, bottom: 52, trailing: 20))
        }
        .overlay {
            VStack {
                HStack {
                    Spacer ()
                    
                    selectedLanguageButton
                        .padding(EdgeInsets(top: 52, leading: 20, bottom: 52, trailing: 20))
                        .opacity([OnboardingStep.introduction, .genderQuestions].contains(onboardingStep) ? 1 : 0)
                        
                }
                Spacer ()
            }
        }
        .overlay(
            Group {
                if showLanguagePicker {
                    LanguagePickerView(
                        isPresented: $showLanguagePicker
                    )
                    .transition(.opacity)
                }
            }
        )
        .background(Color.backround.onboarding)
        .ignoresSafeArea()
    }
    
    private var selectedLanguageButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.5)) {
                showLanguagePicker = true
            }
        } label: {
            selectedLanguageButtonView
        }
    }
    
    private var selectedLanguageButtonView: some View {
        HStack {
            Text(languageManager.currentLanguageRegion().flag)
            Text(languageManager.currentLanguageRegion().regionCode)
        }
        .font(.subheadline)
        .foregroundStyle(Color.text.introSubtitle)
        .multilineTextAlignment(.center)
        .padding(EdgeInsets(top: 7, leading: 12, bottom: 7, trailing: 12))
        .background(Color.button.changeLanguage)
        .cornerRadius(30)
    }
    
    private var nextButton: some View {
        Button {
            showNextPage()
        } label: {
            nextButtonView
        }
    }
    
    private var nextButtonView: some View {
        HStack {
            Spacer()
            
            Text("onboarding_button_title")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(Color.text.onboardingButtonTitle)
            
            Spacer()
        }
        .frame(height: 52)
        .background(Color.button.onboarding)
        .cornerRadius(30)
    }
    
    private var genderQuestionView: some View {
        QuestionsView(
            title: "gender_question_title",
            subTitle: "gender_question_subtitle"
        ) {
            GenderQuestionsView(selectedQuestion: $genderQuestion)
        }
    }
    
    //MARK: - Actions
    private func showNextPage() {
        withAnimation(.easeInOut(duration: 0.5)) {
            switch onboardingStep {
            case .introduction:
                onboardingStep = .genderQuestions
            case .genderQuestions:
                onboardingStep = .workoutQuestions
            case .workoutQuestions:
                completionHandler()
            }
        }
        
        vibration()
    }

    private func vibration() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
}

#Preview {
    OnboardingView(completionHandler: {})
}
