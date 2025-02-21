//
//  PaywallView.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 20/02/2025.
//

import SwiftUI

extension PaywallView {
    enum CompletionAction {
        case dismiss
        case execute(() -> ())
    }
}

//MARK: - View assembling
struct PaywallView: View {
    //MARK: - Environment values and objects
    @Environment(\.dismiss) var dismiss
    
    //MARK: -
    private let completionAction: CompletionAction
    
    //MARK: Constuctor
    init(completionAction: CompletionAction = .dismiss) {
        self.completionAction = completionAction
    }
    
    var body: some View {
        ZStack {
            Text("PaywallView")
            
            VStack(spacing: 0) {
                headerView
                
                Spacer()
            }
        }
    }
    
    private var headerView: some View {
        ZStack {
            HStack {
                Spacer()
                
                closeButton
            }
        }
        .padding(EdgeInsets(top: 51, leading: 26, bottom: 0, trailing: 26))
        .edgesIgnoringSafeArea(.top)
    }
    
    private var closeButton: some View {
        Button {
            complete()
        } label: {
            Color.clear
                .frame(width: 24, height: 24)
                .overlay {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundStyle(.gray)
                }
        }
    }
    
    //MARK: - Actions
    
    @MainActor
    func complete() {
        switch completionAction {
        case .dismiss:
            dismiss()
        case .execute(let action):
            action()
        }
    }
}

#Preview {
    PaywallView()
}
