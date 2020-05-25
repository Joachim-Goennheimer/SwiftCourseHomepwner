//
//  ViewController.swift
//  Homepwner
//
//  Created by Joachim Goennheimer on 25.05.20.
//  Copyright © 2020 Joachim Goennheimer. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {

    var itemStore: ItemStore!
    var numberOfItems: Int = 0

    @IBAction func toggleEditingMode(_ sender: UIButton) {
        
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        }
        else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    
    @IBAction func addNewItem(_ sender: UIButton) {
        
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         tableView.backgroundView = UIImageView(image: UIImage(named: "wood-591631_1280"))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        Silver Challenge. One additional row for displaying "no more items"
        return itemStore.allItems.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        var item = Item(name: "No more items", serialNumber: "", valueInDollars: 0)
        cell.detailTextLabel?.text = ""
        
//        check if there is an item for the respective row. Otherwise it is the last row which displays "No more items"
        if (indexPath.row < itemStore.allItems.count) {
            item = itemStore.allItems[indexPath.row]
            cell.detailTextLabel?.text = "$ \(item.valueInDollars)"
            
//            Gold challenge. Changing font size for all rows except last row.
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
        }

        cell.textLabel?.text = item.name
        
        cell.textLabel?.textColor = UIColor(white: 1.0, alpha: 1.0)
        cell.detailTextLabel?.textColor = UIColor(white: 1.0, alpha: 1.0)
        
        return cell
    }
    
//    Gold challenge. Changing height of rows.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row < itemStore.allItems.count) {
            return CGFloat(60)
        } else {
            return CGFloat(44)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        var isEditable = true
        
        if(indexPath.row >= itemStore.allItems.count) {
            isEditable = false
        }
        return isEditable
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            itemStore.removeItem(item)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

