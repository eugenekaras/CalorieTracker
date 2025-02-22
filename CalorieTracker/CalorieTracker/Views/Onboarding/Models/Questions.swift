//
//  Questions.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 20/02/2025.
//

import SwiftUI

protocol SelectableQuestion: Hashable, CaseIterable {
    var title: LocalizedStringKey { get }
    var subtitle: LocalizedStringKey? { get }
    var iconName: String? { get }
}

enum GenderQuestion: LocalizedStringKey, SelectableQuestion {
    case male = "Male"
    case female = "Female"
    case other = "Other"

    var title: LocalizedStringKey { self.rawValue }
    var subtitle: LocalizedStringKey? { nil }
    var iconName: String? { nil }
}

enum WorkoutQuestion: LocalizedStringKey, SelectableQuestion {
    case sometimes = "0-2"
    case few = "3-5"
    case always = "6+"

    var title: LocalizedStringKey { self.rawValue }
    var subtitle: LocalizedStringKey? {
        switch self {
        case .sometimes: return "Workouts now and then"
        case .few: return "A few workouts per week"
        case .always: return "Dedicated athlete"
        }
    }
    var iconName: String? {
        switch self {
        case .sometimes: return "gauge.open.with.lines.needle.33percent.and.arrowtriangle"
        case .few: return "gauge.open.with.lines.needle.67percent.and.arrowtriangle"
        case .always: return "gauge.open.with.lines.needle.84percent.exclamation"
        }
    }
}

enum SocialQuestion: LocalizedStringKey, SelectableQuestion {
    case instagram = "Instagram"
    case facebook = "Facebook"
    case tiktok = "TikTok"
    case youtube = "Youtube"
    case other = "Other"

    var title: LocalizedStringKey { self.rawValue }
    var subtitle: LocalizedStringKey? { nil }
    
    var iconName: String? {
        switch self {
        case .instagram: return "onboarding/social_question/instagram"
        case .facebook: return "onboarding/social_question/facebook"
        case .tiktok: return "onboarding/social_question/tik_tok"
        case .youtube: return "onboarding/social_question/you_tube"
        case .other: return "onboarding/social_question/other"
        }
    }
}

enum UnitSystem {
    case imperial
    case metric
}

struct HeightWeightData {
    var unitSystem: UnitSystem
    var height: Double // In cm for metric and in inches for imperial
    var weight: Double // In kg for metric and in pounds for imperial
}
