//
//  HoroscopeModel.swift
//  January 13 UserDefaults Lab
//
//  Created by Margiett Gil on 1/13/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation

struct Horoscope: Codable {
    var sunsign: String
    var date: String
    var horoscope: String
   // var mood: String
}

//class UserPreference {
//    
//    // Why do we need this ??
//    private init() {}
//    
//static let share = UserPreference()
//    
//    func updateHoroscope(with updatedSign: Horoscope) {
//        
//        UserDefaults.standard.set(updatedSign.rawValue, forKey: UserPreferenceKey
//        )
//    }
//    
//}
