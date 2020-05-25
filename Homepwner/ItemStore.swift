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
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        
        if fromIndex == toIndex {
            return
        }
//            check is necessary because No more items is implemented as additional row. Otherwise app might crash
//            Note: not necessary anymore after completing gold challenge.
        else if (toIndex >= allItems.count || fromIndex >= allItems.count) {
            return
        }
        else {

            let movedItem = allItems[fromIndex]
            allItems.remove(at: fromIndex)
            allItems.insert(movedItem, at: toIndex)
        }
        
    }
//
//    init() {
//        for _ in 0..<10 {
//            createItem()
//        }
//    }
}
