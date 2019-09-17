//
//  CategoryViewController.swift
//  Todo
//
//  Created by Esteban Ordonez on 9/15/19.
//  Copyright © 2019 Esteban Ordonez. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]();
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories();
    
    }
    
    //MARK - Table View Datasource Methods
    
    // Numbers of Row in Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count;
    }
    
    // Cell for Row at Index Path
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
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
            destinationVC.selectedCategory = categoryArray[indexPath.row];
        }
    }
    //MARK - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField();
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert);
        let action = UIAlertAction(title: "Add", style: .default){ (action) in
            
            let newCategory = Category(context: self.context)//see line 16
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory);
            self.saveCategories();
        }
        alert.addAction(action);
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Add New Category";
            textField = alertTextField;
        }
        
        present(alert, animated: true, completion: nil);
    }
    
    
    //MARK - Data Manipulation Methods
    func saveCategories(){
        
        do{
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData();
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest() ){
        
        //let request : NSFetchRequest<Category> = Category.fetchRequest();
        
        do{
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        //tableView.reloadData();
    }
    
    
    
    
    
    
    
}
