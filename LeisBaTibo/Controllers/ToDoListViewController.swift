
import UIKit
import RealmSwift
import SwipeCellKit

class ToDoListViewController: UITableViewController {
    
    
    let realm = try! Realm()
    
    var items: Results<Data>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ToDoListViewController.back(sender:)))
        newBackButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = newBackButton
        
        loadItems()
        
    }
    
    @objc func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        
        // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: - TableView Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items?.count ?? 1
    }
    
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
    //        cell.delegate = self
    //        return cell
    //    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.tableView.rowHeight = 100.0
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! SwipeTableViewCell
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.textLabel?.text = items?[indexPath.row].itemName ?? "No Categories added yet"
        
        cell.detailTextLabel?.text = "\(items?[indexPath.row].brand ?? "N/A")\nPrice $\(String(items![indexPath.row].regularPrice) ?? "N/A")\nat \(items?[indexPath.row].store ?? "N/A")"
        
        //        cell.textLabel?.text = items?[indexPath.row].itemName ?? "No Categories added yet"
        
        
        //Ternary operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        
        //       cell.accessoryType = item.done == true ? .checkmark : .none
        
        // code above (cell.accessoryType = item.done == true ? .checkmark : .none) to replace 5 lines code below
        //        if item.done == true {
        //            cell.accessoryType = .checkmark
        //        } else {
        //            cell.accessoryType = .none
        //        }
        
        cell.delegate = self
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods: EDIT Item
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = items?[indexPath.row] {
            
            var textFieldStore = UITextField()
            var textFieldItemName = UITextField()
            var textFieldBrand = UITextField()
            var textFieldRegularPrice = UITextField()
            var textFieldSalePrice = UITextField()
            var textFieldSaleNote = UITextField()
            
            let alert = UIAlertController(title: "Edit Your Item", message: "", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let action = UIAlertAction(title: "Save Change", style: .default) { (action) in
                
                //What will happen once the user clicks the Add item button on our UIAlert
                
                if let textFieldStoreSafe = textFieldStore.text {
                    if textFieldStoreSafe != "" {
                        if let textFieldItemNameSafe = textFieldItemName.text {
                            if textFieldItemNameSafe != "" {
                                if let textFieldBrandSafe = textFieldBrand.text {
                                    if textFieldBrandSafe != "" {
                                        if let textFieldRegularPriceSafe = textFieldRegularPrice.text {
                                            if textFieldRegularPriceSafe != "" {
                                                if let textFieldSalePriceSafe = textFieldSalePrice.text {
                                                    if textFieldSalePriceSafe != "" {
                                                        if let textFieldSaleNoteSafe = textFieldSaleNote.text {
                                                            if textFieldSaleNoteSafe != "" {
                                                                
                                                                
                                                                if let item = self.items?[indexPath.row] {
                                                                    do {
                                                                        try self.realm.write {
                                                                            item.store = textFieldStore.text!
                                                                            item.itemName = textFieldItemName.text!
                                                                            item.brand = textFieldBrand.text!
                                                                            item.regularPrice = Float(textFieldRegularPrice.text!)!
                                                                            item.salePrice = Float(textFieldSalePrice.text!)!
                                                                            item.note = textFieldSaleNote.text!
                                                                        }
                                                                    } catch {
                                                                        print("Error Saving Edited Items: \(error)")
                                                                    }
                                                                }
                                                                self.tableView.reloadData()
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    print("error")
                }
                
            }
            
            
            alert.addTextField { (alertTextField) in
                alertTextField.insertText(item.store)
                textFieldStore = alertTextField
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.insertText(item.itemName)
                textFieldItemName = alertTextField
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.insertText(item.brand)
                textFieldBrand = alertTextField
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.insertText(String(item.regularPrice))
                textFieldRegularPrice = alertTextField
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.insertText(String(item.salePrice))
                textFieldSalePrice = alertTextField
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.insertText(item.note)
                textFieldSaleNote = alertTextField
            }

            alert.addAction(action)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
            
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textFieldStore = UITextField()
        var textFieldItemName = UITextField()
        var textFieldBrand = UITextField()
        var textFieldRegularPrice = UITextField()
        var textFieldSalePrice = UITextField()
        var textFieldSaleNote = UITextField()
        
        
        let alert = UIAlertController(title: "Add Items To Shopping List", message: "", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            
            
            
            //What will happen once the user clicks the Add item button on our UIAlert
            
            if let textFieldStoreSafe = textFieldStore.text {
                if textFieldStoreSafe != "" {
                    if let textFieldItemNameSafe = textFieldItemName.text {
                        if textFieldItemNameSafe != "" {
                            if let textFieldBrandSafe = textFieldBrand.text {
                                if textFieldBrandSafe != "" {
                                    if let textFieldRegularPriceSafe = textFieldRegularPrice.text {
                                        if textFieldRegularPriceSafe != "" {
                                            if let textFieldSalePriceSafe = textFieldSalePrice.text {
                                                if textFieldSalePriceSafe != "" {
                                                    if let textFieldSaleNoteSafe = textFieldSaleNote.text {
                                                        if textFieldSaleNoteSafe != "" {
                                                            
                                                            let newItem = Data()
                                                            
                                                            newItem.store = textFieldStore.text!
                                                            newItem.itemName = textFieldItemName.text!
                                                            newItem.brand = textFieldBrand.text!
                                                            newItem.regularPrice = Float(textFieldRegularPrice.text!)!
                                                            newItem.salePrice = Float(textFieldSalePrice.text!)!
                                                            newItem.note = textFieldSaleNote.text!
                                                            
                                                            self.saveItems(itemArray: newItem)
                                                            
//                                                            let newItemToCompletedTable = CompletedItemsData()
//
//                                                            newItemToCompletedTable.store = textFieldStore.text!
//                                                            newItemToCompletedTable.itemName = textFieldItemName.text!
//                                                            newItemToCompletedTable.brand = textFieldBrand.text!
//                                                            newItemToCompletedTable.regularPrice = Float(textFieldRegularPrice.text!)!
//                                                            newItemToCompletedTable.salePrice = Float(textFieldSalePrice.text!)!
//                                                            newItemToCompletedTable.note = textFieldSaleNote.text!
//
//                                                            self.saveCompletedItems(itemArray: newItemToCompletedTable)
                                                            
                                                            
                                                            self.tableView.reloadData()
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                print("error")
            }
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "<Enter Store Name>"
            textFieldStore = alertTextField
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "<Enter Item Name>"
            textFieldItemName = alertTextField
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "<Enter Brand of the Item>"
            textFieldBrand = alertTextField
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "<Enter Price Before Diskon>"
            textFieldRegularPrice = alertTextField
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "<Enter Sale Price/ Paid Price>"
            textFieldSalePrice = alertTextField
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "<Enter Additional Note>"
            textFieldSaleNote = alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Go Back To Previous Screen
    
    func saveItems(itemArray: Data) {
        do {
            try realm.write {
                realm.add(itemArray)
            }
        } catch {
            print("Error Saving Item \(error)")
        }
    }
    
    func saveCompletedItems(itemArray: CompletedItemsData) {
        do {
            try realm.write {
                realm.add(itemArray)
            }
        } catch {
            print("Error Saving Completed Item \(error)")
        }
    }
    
    
    func loadItems() {
        
        items = realm.objects(Data.self).sorted(byKeyPath: "itemName", ascending: true)
        
        tableView.reloadData()
        
    }
}

//MARK: - Swipe Cell Delegate Method

extension ToDoListViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            if let item = self.items?[indexPath.row] {
                do {
                    try self.realm.write {
                        self.realm.delete(item)
                    }
                    
                } catch {
                    print("Error deleting item: \(error)")
                }
            }
            
            tableView.reloadData()        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
}
