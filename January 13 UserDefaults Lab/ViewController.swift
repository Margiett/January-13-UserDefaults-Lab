//
//  ViewController.swift
//  January 13 UserDefaults Lab
//
//  Created by Margiett Gil on 1/13/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bdayPicker: UIPickerView!
    @IBOutlet weak var horoscopeButton: UIButton!
    
    var horoscopeData:Horoscope?
    var userSign:String?{
        didSet {
            getData(sign: userSign!.lowercased())
            print(horoscopeData)
            
        }
    }
    var name = ""

   
    private var horoscope = ["Aries",
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
    
    
    
    private var horoscopePicker: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
       bdayPicker.dataSource = self
       bdayPicker.delegate = self
        horoscopeButton.isEnabled = false
        horoscopePicker = horoscope.first
       
    }
    private func getData(sign: String) {
        APIClient.getHoroscope(sign: sign) { [weak self](result) in
            switch result {
            case .success(let horoscope):
                self?.horoscopeData = horoscope
            case .failure(let error):
                print("error")
                
            }
        }
        
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let horoscopeDetailVC = segue.destination as? HoroscopeDetailVC
        guard let data = horoscopeData else {
            return
        }
        horoscopeDetailVC?.selectedHoroscope = data
        horoscopeDetailVC?.name = name
    }

    
    @IBAction func horoscope(_ sender: UIButton) {
            guard let nameAndHoroscope = nameTextField.text,
            !nameAndHoroscope.isEmpty else {
                showAlert(title: "Name is needed !", message: "Need to input name before you can read you horoscope")
                return
        }
    }


}
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
             return horoscope.count
         }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return horoscope[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        userSign = horoscope[row]

    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        name = nameTextField.text ?? ""
        nameTextField.resignFirstResponder()
        horoscopeButton.isEnabled = true
        return true
    }

}

