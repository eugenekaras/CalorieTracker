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
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(GenderQuestion.allCases, id: \.self) { question in
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
            }
        }
    }
}

#Preview {
    GenderQuestionsView(selectedQuestion: .constant(.female))
}
