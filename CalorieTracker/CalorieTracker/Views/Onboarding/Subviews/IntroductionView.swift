//
//  IntroductionView.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 20/02/2025.
//

import SwiftUI

extension IntroductionView {
    enum IntroductionStep {
        case step1
        case step2
        case step3
        
        var title: LocalizedStringKey {
            switch self {
            case .step1:
                return "intro_title1"
            case .step2:
                return "intro_title2"
            case .step3:
                return "intro_title3"
            }
        }
        
        var subtitle: LocalizedStringKey {
            switch self {
            case .step1:
                return "intro_subtitle1"
            case .step2:
                return "intro_subtitle2"
            case .step3:
                return "intro_subtitle3"
            }
        }
        
        var imageName: String {
            switch self {
            case .step1:
                return "onboarding/intro_img1"
            case .step2:
                return "onboarding/intro_img2"
            case .step3:
                return "onboarding/intro_img3"
            }
        }
    }
}

struct IntroductionView: View {
    //MARK: - States
    @State private var introductionStep: IntroductionStep = .step1

    //MARK: - View assembling
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear

            imageView
            
            VStack {
                Spacer()
                
                VStack {
                    headerView
                    
                    pageIndicator
                    
                    purchasedInfoView
                        .padding(EdgeInsets(top: 6, leading: 20, bottom: 20, trailing: 20))
                }
                .frame(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.45)
                .background(Color.backround.intro)
                .topRoundedCorners(radius: 30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
    
    private var imageView: some View {
        Image(introductionStep.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.5), value: introductionStep)
    }
    
    private var headerView: some View {
        TabView(selection: $introductionStep) {
            ForEach([IntroductionStep.step1, .step2, .step3], id: \.self) { step in
                VStack(alignment: .center) {
                    Text(step.title)
                        .font(.title).bold()
                        .foregroundStyle(Color.text.introTitle)
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 50, leading: 20, bottom: 0, trailing: 20))
                    
                    Text(step.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(Color.text.introSubtitle)
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 3, leading: 20, bottom: 0, trailing: 20))
                    
                    Spacer()
            
                }
                .tag(step)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut(duration: 0.5), value: introductionStep)
    }
    
    private var pageIndicator: some View {
        HStack(spacing: 10) {
            ForEach([IntroductionStep.step1, .step2, .step3], id: \.self) { step in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(introductionStep == step ? Color.text.introIndicator1 : Color.text.introIndicator2)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: introductionStep)
    }
    
    private var purchasedInfoView: some View {
        Group {
            Text("intro_buttom_text1")
                .font(.subheadline) +
            Text(" ")
                .font(.subheadline) +
            Text("intro_buttom_text2")
                .font(.subheadline).bold()
        }
        .foregroundStyle(Color.text.introSubtitle)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    IntroductionView()
}
