//
//  ItemStore.swift
//  Homepwner
//
//  Created by Joachim Goennheimer on 25.05.20.
//  Copyright © 2020 Joachim Goennheimer. All rights reserved.
//

// import Foundation

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
        
    }
    
    init() {
        for _ in 0..<10 {
            createItem()
        }
    }
}
