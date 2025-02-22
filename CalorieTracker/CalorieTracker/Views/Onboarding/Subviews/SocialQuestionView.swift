//
//  SocialQuestionView.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 21/02/2025.
//

import SwiftUI

struct SocialQuestionView: View {
    //MARK: - States
    @Binding var selectedQuestion: SocialQuestion?
    @State private var isPressed = false
    @State private var visibleQuestions: [Bool]
    
    //MARK: - Initializator
    init(selectedQuestion: Binding<SocialQuestion?>) {
         _selectedQuestion = selectedQuestion
         _visibleQuestions = State(initialValue: Array(repeating: false, count: SocialQuestion.allCases.count))
     }
    
    //MARK: - View assembling
    var body: some View {
        VStack(spacing: 12) {
            ScrollView {
                ForEach(Array(SocialQuestion.allCases.enumerated()), id: \.element) { index, question in
                    HStack {
                        if let iconName = question.iconName {
                            Color.backround.icon
                                .frame(width: 37, height: 37)
                                .clipShape(Circle())
                                .overlay {
                                    Image(iconName)
                                        .foregroundColor(.text.introTitle)
                                }
                        }
                        
                        VStack(alignment: .leading) {
                            if selectedQuestion == question {
                                Text(question.title)
                                    .font(.subheadline).bold()
                            } else {
                                Text(question.title)
                                    .font(.subheadline)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 12)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .frame(height: 72)
                    .questionButtonStyle(
                        selected: Binding(
                            get: { selectedQuestion == question },
                            set: { value in
                                if value {
                                    selectedQuestion = question
                                }
                            }
                        ),
                        isPressed: $isPressed
                    )
                    .scaleEffect(visibleQuestions[index] ? 1.0 : 0.95)
                    .opacity(visibleQuestions[index] ? 1 : 0)
                    .animation(.easeIn(duration: 0.5).delay(Double(index) * 0.3), value: visibleQuestions[index])
                    .onAppear {
                        visibleQuestions[index] = true
                    }
                }
            }
        }
    }
}

#Preview {
    SocialQuestionView(selectedQuestion: .constant(.facebook))
}
