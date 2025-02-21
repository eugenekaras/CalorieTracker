//
//  QuestionsView.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 20/02/2025.
//

import SwiftUI

struct QuestionsView<Content>: View where Content: View {
    //MARK: -
    let title: LocalizedStringKey
    let subTitle: LocalizedStringKey
    
    @ViewBuilder var content: Content

    //MARK: - View assembling
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            
            Spacer()
            
            content
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            Spacer()
        }
    }
    
    private var headerView: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title).bold()
                .foregroundStyle(Color.text.introTitle)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 50, leading: 20, bottom: 0, trailing: 20))
            
            Text(subTitle)
                .font(.subheadline)
                .foregroundStyle(Color.text.introSubtitle)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 3, leading: 20, bottom: 0, trailing: 20))
            
        }

    }
}

#Preview {
//    GenderQuestionsView()
}
