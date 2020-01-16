//
//  HoroscopeDetailVC.swift
//  January 13 UserDefaults Lab
//
//  Created by Margiett Gil on 1/13/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit

class HoroscopeDetailVC: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var horoscopeLabel: UILabel!
    @IBOutlet weak var horoscopeDetail: UITextView!
    
    
     var horoscope: HoroscopeModel?
        
        var currentZodiac = HoroscopeSign.Cancer.rawValue {
            didSet{
                getHoroscope()
                UserPreference.shared.updateZodiac(with: currentZodiac)
            }
        }
        
    var userName = String(){
        didSet {
            UserPreference.shared.updatName(with: userName)
            
            
        }
    }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            updateUI()
            print(currentZodiac)
        }
        
        func updateUI() {
            if let updatedHoroscopeZodiac = UserPreference.shared.getUserZodiac() {
                currentZodiac = updatedHoroscopeZodiac
            }
            if let PersonName = UserPreference.shared.getUserName() {
                       userName = PersonName.capitalized
                   }
        }
        
        func getHoroscope(){
            APIClient.getHoroscope(sign: currentZodiac.lowercased()) { [weak self] (result) in
                switch result {
                case .failure(let appError):
                    print(appError)
                    
                case .success(let horoscope):
                    self?.horoscope = horoscope
                    DispatchQueue.main.async {
                        self?.horoscopeLabel.text = horoscope.sunsign
                        self?.horoscopeDetail.text = horoscope.horoscope
                        self?.nameLabel.text = "\(self?.userName ?? "")'s Horoscope"
                    }
                    
                }
            }
        }
        
        @IBAction func unwindSegue(segue: UIStoryboardSegue) {
            guard let settingsVC = segue.source as? SettingsVC else {
                fatalError("unwind segue does not work")
                
            }
            currentZodiac = settingsVC.selectedZ
            userName = settingsVC.userName
   

            
            
            
            
        }
        
        
        
        
    }
