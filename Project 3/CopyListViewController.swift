//
//  ViewController.swift
//  Project 3
//
//  Created by Tracy Hainer on 7/16/19.
//  Copyright © 2019 Tracy Hainer. All rights reserved.
//

import UIKit
import CoreData

class CopyListViewController: UITableViewController {

    var itemArray = [Item]()
    var storeArray = [Store]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }

    // MARK - TableView Datasource Methods:
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count ; storeArray.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CopyItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        //        if itemArray[indexPath.row].done == true {
        //            cell.accessoryType = .checkmark
        //        } else {
        //            cell.accessoryType = .none
        //        }
        
        return cell
        
}
    // MARK - TableView Delegate Methods:
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(itemArray[indexPath.row])
        
        //         itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
            
            let newStore = Store(context: self.context)
            newStore.title = itemArray[indexPath.row].title
            self.storeArray.append(newStore)
            
            
        } else {
            itemArray[indexPath.row].done = false
        }
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Project Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // What will happen onece the user click the Add Item Button on our UIAlert
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK = Model Manupulation Methods:
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
        
    }
}
