//
//  Questions.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 20/02/2025.
//

import SwiftUI

protocol SelectableQuestion: Hashable, CaseIterable {
    var title: LocalizedStringKey { get }
    var iconName: String? { get }
}

enum GenderQuestion: LocalizedStringKey, SelectableQuestion {
    case male = "Male"
    case female = "Female"
    case other = "Other"

    var title: LocalizedStringKey { self.rawValue }
    var iconName: String? { nil }
}


enum SocialQuestion: LocalizedStringKey, SelectableQuestion {
    case instagram = "Instagram"
    case facebook = "Facebook"
    case tiktok = "TikTok"
    case youtube = "Youtube"
    case google = "Google"
    case tv = "TV"
    case friendOrFamily = "Friend or family"
    case other = "Other"

    var title: LocalizedStringKey { self.rawValue }
    
    var iconName: String? {
        switch self {
        case .instagram: return "instagram"
        case .facebook: return "facebook"
        case .tiktok: return "tiktok"
        case .youtube: return "youtube"
        case .google: return "google"
        case .tv: return "tv"
        case .friendOrFamily: return "friends"
        case .other: return "other"
        }
    }
}
