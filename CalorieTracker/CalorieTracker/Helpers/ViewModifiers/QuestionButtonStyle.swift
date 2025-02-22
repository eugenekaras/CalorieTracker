//
//  QuestionButtonStyle.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 21/02/2025.
//

import SwiftUI

struct QuestionButtonStyle: ViewModifier {
    @Binding var selected: Bool
    @Binding var isPressed: Bool
    
    func body(content: Content) -> some View {
        content
            .background(selected ? Color.button.selectedQuestion : Color.button.unselectedQuestion)
            .cornerRadius(12)
            .foregroundStyle(selected ? Color.button.unselectedQuestion : Color.button.selectedQuestion)
            .scaleEffect(selected && isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.3), value: isPressed)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            isPressed = true
                            selected = true
                            
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                    }
                    .onEnded { _ in
                        isPressed = false
                    }
            )
    }
}


extension View {
    func questionButtonStyle(selected: Binding<Bool>, isPressed: Binding<Bool>) -> some View {
        modifier(QuestionButtonStyle(selected: selected, isPressed: isPressed))
    }
}
