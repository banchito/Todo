//
//  CategoryViewController.swift
//  Todo
//
//  Created by Esteban Ordonez on 9/15/19.
//  Copyright © 2019 Esteban Ordonez. All rights reserved.
//

import UIKit

import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()

    var categories: Results<Category>?
    
   // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories();
    
    }
    
    //MARK - Table View Datasource Methods
    
    // Numbers of Row in Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    // Cell for Row at Index Path
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
        
        return cell;
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        //saveCategories();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC:TodoListViewController = segue.destination as! TodoListViewController;
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    //MARK - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField();
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert);
        let action = UIAlertAction(title: "Add", style: .default){ (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory);
        }
            alert.addAction(action);
            alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Add New Category";
            textField = alertTextField;
        }
        
        present(alert, animated: true, completion: nil);
    }
    
    
    //MARK - Data Manipulation Methods
    func save(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData();
    }
    
    func loadCategories(){
        categories = realm.objects(Category.self)
        tableView.reloadData()
        
    }
    
    
    
    
    
    
    
}
