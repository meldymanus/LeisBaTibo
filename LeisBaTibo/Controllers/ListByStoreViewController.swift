
import UIKit
import RealmSwift
import SwipeCellKit

class ListByStoreViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var storeItems: Results<Data>?
    
    var selectedStore: String?
    //    {
    //            didSet {
    //                loadItems()
    //            }
    //        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ToDoListViewController.back(sender:)))
        newBackButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = newBackButton
        
        self.navigationItem.title = selectedStore!
        
        loadItems()
        
    }
    
    @objc func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        
        // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    //MARK: - TableView Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return storeItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.tableView.rowHeight = 75.0
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListByStoreCell", for: indexPath) as! SwipeTableViewCell
        
        //         if storeItems?[indexPath.row].store == selectedStore {
        
        cell.detailTextLabel?.numberOfLines = 0
        
        cell.textLabel?.text = storeItems?[indexPath.row].itemName ?? "No Categories added yet"
        cell.detailTextLabel?.text = "\(storeItems?[indexPath.row].brand ?? "N/A")\nPrice $\(String(storeItems![indexPath.row].regularPrice) ?? "N/A")"
        
        
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
    
    //MARK: - TableView Delegate Methods: Delete Item
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = storeItems?[indexPath.row] {
            
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
                                                                
                                                                
                                                                if let item = self.storeItems?[indexPath.row] {
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
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func loadItems() {
        
        storeItems = realm.objects(Data.self)
        storeItems = storeItems?.filter("store CONTAINS %@", selectedStore!).sorted(byKeyPath: "itemName", ascending: true)
        tableView.reloadData()
    }
    
    @IBAction func completeShoppingButtonPressed(_ sender: UIButton) {

        
    }
    
}

//MARK: - Swipe Cell Delegate Method

extension ListByStoreViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            if let item = self.storeItems?[indexPath.row] {
                do {
                    try self.realm.write {
                        self.realm.delete(item)
                    }
                    
                } catch {
                    print("Error deleting item: \(error)")
                }
            }
            
            tableView.reloadData()
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    
    
}
