//
//  OnboardingView.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 20/02/2025.
//

import SwiftUI

extension OnboardingView {
    enum OnboardingStep: Int, CaseIterable  {
        case introduction = 0
        case genderQuestions
        case workoutQuestions
        case socialQuestions
        case longTermResults
    }
}

struct OnboardingView: View {
    //MARK: - Environment values and objects
    @EnvironmentObject private var languageManager: LanguageManager
    
    //MARK: - States
    @State private var showLanguagePicker = false
    @State private var showSignIn = false
    @State private var onboardingStep: OnboardingStep = .introduction
    @State private var genderQuestion: GenderQuestion?
    @State private var workoutQuestion: WorkoutQuestion?
    @State private var socialQuestion: SocialQuestion?
    
    //MARK: - Callbacks
    let completionHandler: () -> Void
    
    //MARK: -
    private var progress: Double {
        Double(onboardingStep.rawValue) / Double(OnboardingStep.allCases.count)
    }
    
    private var isNextEnabled: Bool {
        switch onboardingStep {
        case .introduction:
            return true
        case .genderQuestions:
            return genderQuestion != nil
        case .workoutQuestions:
            return workoutQuestion != nil
        case .socialQuestions:
            return socialQuestion != nil
        case .longTermResults:
            return true
        }
    }
    
    //MARK: - View assembling
    var body: some View {
        VStack {
            if onboardingStep != .introduction {
                headerView
            }
            
            Group {
                switch onboardingStep {
                case .introduction:
                    IntroductionView(showSignIn: $showSignIn)
                case .genderQuestions:
                    genderQuestionView
                case .workoutQuestions:
                    workoutQuestionView
                case .socialQuestions:
                    socialQuestionsView
                case .longTermResults:
                    longTermResultsView
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
                        .padding(EdgeInsets(top: 51, leading: 20, bottom: 0, trailing: 20))
                        .opacity([OnboardingStep.introduction].contains(onboardingStep) ? 1 : 0)
                        
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
        .sheet(isPresented: $showSignIn) {
            SignInViewView()
                .presentationDetents([.fraction(0.50)])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(10)
        }
        .ignoresSafeArea()
    }
    
    private var headerView: some View {
        HStack(spacing: 16) {
            backButton
            
            progressView
            
            if onboardingStep == .genderQuestions {
                selectedLanguageButton
            }
        }
        .padding(EdgeInsets(top: 51, leading: 20, bottom: 0, trailing: 20))
    }
    
    private var progressView: some View {
        ProgressView(value: progress, total: 1.0)
            .tint(Color.text.introTitle)
    }
    
    private var backButton: some View {
        Button {
            showBackPage()
        } label: {
            backButtonView
        }
    }
    
    private var backButtonView: some View {
        Color.button.back
            .frame(width: 37, height: 37)
            .clipShape(Circle())
            .overlay {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.text.introTitle)
            }
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
        .disabled(!isNextEnabled)
        .opacity(!isNextEnabled ? 0.5 : 1)
    }
    
    private var nextButtonView: some View {
        HStack {
            Spacer()
            
            Text("onboarding_button_title")
                .font(.subheadline).bold()
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
    
    private var workoutQuestionView: some View {
        QuestionsView(
            title: "workout_question_title",
            subTitle: "workout_question_subtitle"
        ) {
            WorkourQuestionsView(selectedQuestion: $workoutQuestion)
        }
    }
    
    private var socialQuestionsView: some View {
        QuestionsView(
            title: "workout_question_title",
            subTitle: "workout_question_subtitle"
        ) {
            SocialQuestionView(selectedQuestion: $socialQuestion)
        }
    }
    
    private var longTermResultsView: some View {
        QuestionsView(
            title: "long_term_results_title",
            subTitle: nil
        ) {
            Image("onboarding/intro_your_weight")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
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
                onboardingStep = .socialQuestions
            case .socialQuestions:
                onboardingStep = .longTermResults
            case .longTermResults:
                completionHandler()
            }
        }
        
        vibration()
    }
    
    private func showBackPage() {
        withAnimation(.easeInOut(duration: 0.5)) {
            switch onboardingStep {
            case .introduction:
                onboardingStep = .introduction
            case .genderQuestions:
                onboardingStep = .introduction
            case .workoutQuestions:
                onboardingStep = .genderQuestions
            case .socialQuestions:
                onboardingStep = .workoutQuestions
            case .longTermResults:
                onboardingStep = .socialQuestions
            }
        }
    }

    private func vibration() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
//    private func nextStep() {
//        withAnimation(.easeInOut(duration: 0.3)) {
//            if let nextIndex = OnboardingStep.allCases.firstIndex(of: onboardingStep)?.advanced(by: 1),
//               nextIndex < OnboardingStep.allCases.count {
//                onboardingStep = OnboardingStep.allCases[nextIndex]
//            } else {
//                completionHandler()
//            }
//        }
//        
//        vibration()
//    }
//    
//    private func previousStep() {
//        withAnimation(.easeInOut(duration: 0.3)) {
//            if let previousIndex = OnboardingStep.allCases.firstIndex(of: onboardingStep)?.advanced(by: -1),
//               previousIndex >= 0 {
//                onboardingStep = OnboardingStep.allCases[previousIndex]
//            }
//        }
//    }
}

#Preview {
    OnboardingView(completionHandler: {})
}
