//
//  ViewController.swift
//  Todo
//
//  Created by Esteban Ordonez on 9/11/19.
//  Copyright © 2019 Esteban Ordonez. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Items]();
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).first?.appendingPathComponent("Items.plist");
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadItems();
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
        saveItems();
        
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
            self.saveItems();
                
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item";
            textField = alertTextField;
        }
        alert.addAction(action);
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation Methods
    func saveItems(){
        let encoder = PropertyListEncoder();
        
        do{
            let data =  try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error enconding item array \(error)")
        }
        self.tableView.reloadData();
    }
    
    func loadItems(){
        let decoder = PropertyListDecoder();
        if let data = try? Data(contentsOf: dataFilePath!){
            do{
                itemArray = try decoder.decode([Items].self, from: data)
            }catch{
                print("Error denconding item array \(error)")
            }
        }
    }
}

