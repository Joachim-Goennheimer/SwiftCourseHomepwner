//
//  CreateDateViewController.swift
//  Homepwner
//
//  Created by Joachim Goennheimer on 26.05.20.
//  Copyright © 2020 Joachim Goennheimer. All rights reserved.
//

// import Foundation

import UIKit

class CreateDateViewController: UIViewController {
    
    var datePicker: UIDatePicker!
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
//    takes old date from item and makes it initial value of date picker
        datePicker.date = item.dateCreated
        self.view.addSubview(datePicker)
        
    }
//    if view changed back the new date will be stored in item
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        item.dateCreated = datePicker.date
    }
    
    

}
