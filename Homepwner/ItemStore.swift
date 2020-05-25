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
        print(fromIndex)
        print(toIndex)
        if fromIndex == toIndex {
            return
        }
        else if (toIndex >= allItems.count) {
            let movedItem = allItems[fromIndex]
            
            allItems.remove(at: fromIndex)
            
            allItems.insert(movedItem, at: fromIndex)
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
