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
    @IBOutlet weak var saveButton: UIButton!
    
    var selectedHoroscope: Horoscope?
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        nameLabel.text = name
        
    }
    func loadData() {
        guard let horoscopeLoadData = selectedHoroscope else {
            fatalError("the segue to the detail controller did not work please try again")
        }
        
        horoscopeLabel.text = selectedHoroscope?.sunsign
        horoscopeDetail.text = selectedHoroscope?.horoscope
        
        
        
    }
    
}
