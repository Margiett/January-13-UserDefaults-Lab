//
//  ViewController.swift
//  January 13 UserDefaults Lab
//
//  Created by Margiett Gil on 1/13/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bdayPicker: UIPickerView!

    var selectedZ = HoroscopeSign.Cancer.rawValue
    
    var userName = "" {
        didSet{
            nameTextField.text = userName
        }
    }
   
         
    private var zodiacSign = ["Aries",
    "Taurus",
    "Gemini",
    "Cancer",
    "Leo",
    "Virgo",
    "Libra",
    "Scorpio",
    "Sagittarius",
    "Capricorn",
    "Aquarius",
    "Pisces"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        bdayPicker.delegate = self
        bdayPicker.dataSource = self 
       
    }
    

}

extension SettingsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userName = textField.text ?? "Margiett X Gil"
        textField.resignFirstResponder()
        return true
    }

}
extension SettingsVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return zodiacSign.count
    }
}

extension SettingsVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return zodiacSign[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        let sign = zodiacSign[row]
        selectedZ = sign
        UserPreference.shared.updateZodiac(with: sign)
        print(sign)
        
    }
}
