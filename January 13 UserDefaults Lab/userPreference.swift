//
//  userPreference.swift
//  January 13 UserDefaults Lab
//
//  Created by Margiett Gil on 1/14/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation

enum HoroscopeSign: String {
    case Aries = "Aries"
    case Taurus = "Taurus"
    case Gemini = "Gemini"
    case Cancer = "Cancer"
    case Leo = "Leo"
    case Virgo = "Virgo"
    case Libra = "Libra"
    case Scorpio = "Scorpio"
    case Sagittarius = "Sagittarius"
    case Capricorn = "Capricorn"
    case Aquarius = "Aquarius"
    case Pisces = "Pisces"
}

struct UserPreferenceKey {
    static let name = "name"
   static let zodiacSign = "sign"
}
class UserPreference {
    
    private init() {}
    
    static let shared = UserPreference()
    //MARK: saving to user default
    func updateZodiac(with zodiac: HoroscopeSign.RawValue) {
        UserDefaults.standard.set(zodiac, forKey: UserPreferenceKey.zodiacSign)
    
    }
    func updatName(with name: String){
        UserDefaults.standard.set(name, forKey: UserPreferenceKey.name)
    }
    //MARK: we are retrieving the information from the user default
    func getUserZodiac() -> HoroscopeSign.RawValue? {
        guard let zodiac = UserDefaults.standard.object(forKey: UserPreferenceKey.zodiacSign) as? String else {
            return nil
        }
        return HoroscopeSign(rawValue: zodiac).map { $0.rawValue }
    }
    func getUserName() -> String? {
        guard let userNameMar = UserDefaults.standard.object(forKey: UserPreferenceKey.name) as? String else {
            return nil
        }
        return userNameMar
    }
  
}

