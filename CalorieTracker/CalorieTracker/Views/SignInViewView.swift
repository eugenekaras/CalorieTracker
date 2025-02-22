//
//  SignInViewView.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 22/02/2025.
//

import SwiftUI

struct SignInViewView: View {
    //MARK: - Environment values and objects
    @Environment(\.dismiss) var dismiss
    
    //MARK: - View assembling
    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            Divider()
            
            signInView
                .padding(EdgeInsets(top: 50, leading: 20, bottom: 52, trailing: 20))
            
            Spacer()
        }
        .background(Color.backround.signInt)
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Color.button.back
                .frame(width: 37, height: 37)
                .clipShape(Circle())
                .overlay {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.text.introTitle)
                }
        }
    }
    
    private var headerView: some View {
        HStack(spacing: 0) {
            ZStack{
                HStack {
                    Text("Sign In")
                        .font(.title).bold()
                        .foregroundStyle(Color.text.introSubtitle)
                    
                }
                
                HStack {
                    Spacer()
                    
                    backButton
                        .padding(.horizontal, 26)
                }
            }
        }
        .frame(height: 72)
        .background(Color.backround.signInt)
    }
    
    private var signInView: some View {
        VStack(spacing: 16) {
            appleSignInButtonView
            
            googleSignInButtonView
            
            emailSignInButtonView
            
            privacyView
        }
        .background(Color.backround.signInt)
    }
    
    var appleSignInButtonView: some View {
        Button {
         
        } label: {
            HStack {
                Spacer()
                
                Image(systemName: "apple.logo")
                Text("Sign in with Apple")
                    .padding(.leading, 5)
                
                Spacer()
            }
            .foregroundColor(Color.text.onboardingButtonTitle)
            .frame(height: 53)
            .background(Color.button.signInt)
            .cornerRadius(70)
        }
    }
    
    var googleSignInButtonView: some View {
        Button {
         
        } label: {
            HStack {
                Spacer()
                
                Image("icons/google")
                Text("Sign in with Google")
                    .padding(.leading, 5)
                
                Spacer()
            }
            .foregroundColor(Color.text.introTitle)
            .frame(height: 53)
            .overlay {
                RoundedRectangle(cornerRadius: 70)
                    .stroke(Color.button.signInt, lineWidth: 1)
            }
        }
    }
    
    var emailSignInButtonView: some View {
        Button {
         
        } label: {
            HStack {
                Spacer()
                
                Image(systemName: "envelope")
                Text("Continue with email")
                    .padding(.leading, 5)
                
                Spacer()
            }
            .foregroundColor(Color.text.introTitle)
            .frame(height: 53)
            .overlay {
                RoundedRectangle(cornerRadius: 70)
                    .stroke(Color.button.signInt, lineWidth: 1)
            }
        }
    }
    
    var privacyView: some View {
        HStack {
            VStack(alignment: .center, spacing: 3) {
                Text("By continuing you agree to Cal AI's")
                    .font(.caption)
                    .foregroundStyle(Color.text.introSubtitle)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Link(destination: .tos) {
                        linkView(title: NSLocalizedString("Terms and Conditions", comment: ""))
                    }
                    
                    Text("and")
                        .font(.caption)
                        .foregroundStyle(Color.text.introSubtitle)
                        .multilineTextAlignment(.center)
                    
                    Link(destination: .privacy) {
                        linkView(title: NSLocalizedString("Privacy Policy", comment: ""))
                    }
                }
            }
        }
    }
    
    private func linkView(title: String) -> some View {
        Text(title)
            .font(.caption)
            .foregroundStyle(Color.text.introSubtitle)
            .underline(color: Color.text.introSubtitle)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    SignInViewView()
}
