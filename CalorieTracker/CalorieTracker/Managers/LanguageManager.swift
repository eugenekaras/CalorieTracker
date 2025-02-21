//
//  LanguageManager.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 21/02/2025.
//

import SwiftUI

enum LanguageRegion: String, CaseIterable {
    case english = "en"
    case russian = "ru"
    case french = "fr"
    case german = "de"
    case spanish = "es"
    case italian = "it"
    case japanese = "ja"
    case chinese = "zh"
    case korean = "ko"
    case turkish = "tr"
    
    var flag: String {
        return regionCode
            .uppercased()
            .unicodeScalars
            .compactMap { UnicodeScalar(127397 + $0.value) }
            .map { String($0) }
            .joined()
    }
    
    var languageName: String {
        switch self {
        case .english: return "English"
        case .russian: return "Русский"
        case .french: return "Français"
        case .german: return "Deutsch"
        case .spanish: return "Español"
        case .italian: return "Italiano"
        case .japanese: return "日本語"
        case .chinese: return "中文"
        case .korean: return "한국어"
        case .turkish: return "Türkçe"
        }
    }
    
    var regionCode: String {
        switch self {
        case .english: return "US"
        case .russian: return "RU"
        case .french: return "FR"
        case .german: return "DE"
        case .spanish: return "ES"
        case .italian: return "IT"
        case .japanese: return "JP"
        case .chinese: return "CN"
        case .korean: return "KR"
        case .turkish: return "TR"
        }
    }
}

class LanguageManager: ObservableObject {
    @Published var locale: Locale = Locale(identifier: Locale.current.identifier)

    func changeLanguage(to language: String) {
        locale = Locale(identifier: language)
        UserDefaults.standard.setValue([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    func currentLanguageRegion() -> LanguageRegion {
        guard let languageCode = locale.language.languageCode?.identifier else {
            return .english
        }
        
        return LanguageRegion(rawValue: languageCode) ?? .english
    }
}
