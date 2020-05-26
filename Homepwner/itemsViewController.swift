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
        tableView.backgroundView?.alpha = 0.5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        Silver Challenge. One additional row for displaying "no more items"
        return itemStore.allItems.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell

        var item = Item(name: "No more items", serialNumber: "", valueInDollars: -1)
        cell.valueLabel.text = ""
        cell.serialNumberLabel.text = ""
        
//        check if there is an item for the respective row. Otherwise it is the last row which displays "No more items"
//        if (indexPath.row < itemStore.allItems.count) {
//            item = itemStore.allItems[indexPath.row]
//            cell.detailTextLabel?.text = "$ \(item.valueInDollars)"
//
////            Gold challenge. Changing font size for all rows except last row.
//            cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
//            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
//        }
//
//        cell.textLabel?.text = item.name
//
//        cell.textLabel?.textColor = UIColor(white: 1.0, alpha: 1.0)
//        cell.detailTextLabel?.textColor = UIColor(white: 1.0, alpha: 1.0)
//
        
        if (indexPath.row < itemStore.allItems.count) {
            item = itemStore.allItems[indexPath.row]
            cell.valueLabel.text = "$ \(item.valueInDollars)"
            cell.serialNumberLabel.text = item.serialNumber

                    
//      Gold challenge. Changing font size for all rows except last row.
            cell.nameLabel.font = UIFont.systemFont(ofSize: 20)
            cell.valueLabel.font = UIFont.systemFont(ofSize: 20)
//            has to be made smaller. Otherwise name will overwrite part of it.
            cell.serialNumberLabel.font = UIFont.systemFont(ofSize: 9)

        }

        cell.nameLabel.text = item.name
        
        colorForCell(cell: cell, value: item.valueInDollars)
        
        
//        before implementing ItemCell background image showed everywhere. Therefore font color had to be changed
//        cell.nameLabel.textColor = UIColor(white: 1.0, alpha: 1.0)
//        cell.valueLabel.textColor = UIColor(white: 1.0, alpha: 1.0)
        
        
        
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
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {(action) -> Void in
                self.itemStore.removeItem(item)
                
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            present(ac, animated: true, completion: nil)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
//    bronze challenge
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
//    gold challenge
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if (proposedDestinationIndexPath.row >= itemStore.allItems.count){
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }

//    bronze challenge: cell colors
    func colorForCell(cell: ItemCell, value: Int) ->  Void {

        if(value >= 50){
            cell.valueLabel.textColor = UIColor.red
        }else if(value >= 0){
            cell.valueLabel.textColor = UIColor.green
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showItem"?:
            
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}

