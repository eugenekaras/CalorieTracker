//
//  GenderQuestionsView.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 21/02/2025.
//

import SwiftUI

struct GenderQuestionsView: View {
    //MARK: - States
    @Binding var selectedQuestion: GenderQuestion?
    @State private var isPressed = false
    @State private var visibleQuestions: [Bool]
    
    //MARK: - Initializator
    init(selectedQuestion: Binding<GenderQuestion?>) {
         _selectedQuestion = selectedQuestion
         _visibleQuestions = State(initialValue: Array(repeating: false, count: GenderQuestion.allCases.count))
     }
    
    //MARK: - View assembling
    var body: some View {
        VStack(spacing: 12) {
            ForEach(Array(GenderQuestion.allCases.enumerated()), id: \.element) { index, question in
                HStack {
                    Spacer()
                    
                    if selectedQuestion == question {
                        Text(question.title)
                            .font(.subheadline).bold()
                    } else {
                        Text(question.title)
                            .font(.subheadline)
                    }
                    
                    Spacer()
                }
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .frame(height: 52)
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

#Preview {
    GenderQuestionsView(selectedQuestion: .constant(.female))
}
