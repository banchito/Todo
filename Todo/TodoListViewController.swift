//
//  ViewController.swift
//  Todo
//
//  Created by Esteban Ordonez on 9/11/19.
//  Copyright © 2019 Esteban Ordonez. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    let defaults:UserDefaults = UserDefaults.standard;
    
    var itemArray = [Items]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Items();
        newItem.title =  "Find Mike";
        itemArray.append(newItem);
        
        let newItem2 = Items();
        newItem2.title =  "Buy Egoos";
        itemArray.append(newItem2);
        
        let newItem3 = Items();
        newItem3.title =  "Destroy Demogorgon";
        itemArray.append(newItem3);
        // Do any additional setup after loading the view.
        if let items = defaults.array(forKey: "TodoListArray") as? [Items]{
            itemArray = items
        }
    }
    
    //MARK - Tableview DataSource Methods
    
    // NumbersOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count;
    }
    
    // cellForRowAtIndexPath:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title;
        
        cell.accessoryType = item.done ? .checkmark : .none;
        
        return cell;
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done;
        
        
        
        tableView.reloadData();
        tableView.deselectRow(at: indexPath, animated: true);
    }

   //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField();
        
        let alert = UIAlertController(title: "Add new Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user click the add item button on the UIalert
            let newItem = Items();
            newItem.title = textField.text!;
            self.itemArray.append(newItem);
            self.defaults.set(self.itemArray, forKey: "TodoListArray");
            self.tableView.reloadData(); 
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item";
            textField = alertTextField;
        }
        alert.addAction(action);
        present(alert, animated: true, completion: nil)
    }
}

