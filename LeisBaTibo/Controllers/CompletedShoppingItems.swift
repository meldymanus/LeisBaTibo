//
//  CompletedShoppingItems.swift
//  LeisBaTibo
//
//  Created by Test for Word on 5/21/20.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CompletedShoppingItems: UITableViewController {
    
    
    let realm = try! Realm()
    
    var items: Results<CompletedItemsData>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        loadItems()
        
    }
    
    

    

    
    //MARK: - TableView Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.tableView.rowHeight = 60.0
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedCell", for: indexPath) as! SwipeTableViewCell
        
        cell.detailTextLabel?.numberOfLines = 0
        
        cell.textLabel?.text = "\(items?[indexPath.row].itemName  ?? "No Categories added yet") -  $\(String(items![indexPath.row].estimatedPrice) ?? "N/A")/ \(String(items![indexPath.row].quantityForEstimatedPrice) ?? "N/A")\(String(items![indexPath.row].unitMeasurement) ?? "N/A")"
        
        cell.detailTextLabel?.text = "\(items?[indexPath.row].brand ?? "N/A"), at \(items?[indexPath.row].store ?? "N/A")"
        
        let label1 = UILabel.init(frame: CGRect(x:0,y:0,width:75,height:20))
        label1.textColor = UIColor.blue
        label1.textAlignment = .right
        label1.adjustsFontSizeToFitWidth = true
        label1.font = .boldSystemFont(ofSize: 18)
        
        //calculation of cost of item
        var cost: Double = 0.0
        cost = items![indexPath.row].buyingQuantity / items![indexPath.row].quantityForEstimatedPrice * items![indexPath.row].estimatedPrice
        
        label1.text = "$\(String(cost) ?? "N/A")"
        
        //                cell.accessoryView = label
        
        let label2 = UILabel.init(frame: CGRect(x:0,y:0,width:75,height:60))
        label2.textColor = UIColor.blue
        label2.textAlignment = .right
        label2.adjustsFontSizeToFitWidth = true
        label2.font = .boldSystemFont(ofSize: 12)
        

        label2.text = "(\(String(items![indexPath.row].buyingQuantity) ?? "N/A") \(items![indexPath.row].unitMeasurement ?? "N/A"))"
        
        //create container view to hold 2 custom label in prototype cell
        //label1 for cost of item; label2 for number of item bought and unit (lb/oz/etc)
        let container = UIView(frame: CGRect(x:0,y:0,width:75,height:40))
        container.addSubview(label1)
        container.addSubview(label2)
        cell.accessoryView = container
        
        cell.delegate = self
        
        return cell
        
    }
    
    //MARK: - UNUSED: TableView Delegate Methods: EDIT Item
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if let item = items?[indexPath.row] {
//
//            var textFieldStore = UITextField()
//            var textFieldItemName = UITextField()
//            var textFieldBrand = UITextField()
//            var textFieldestimatedPrice = UITextField()
//            var textFieldBuyQuantity = UITextField()
//            var textFieldSaleNote = UITextField()
//
//            let alert = UIAlertController(title: "Edit Your Item", message: "", preferredStyle: .alert)
//
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//            let action = UIAlertAction(title: "Save Change", style: .default) { (action) in
//
//                //What will happen once the user clicks the Add item button on our UIAlert
//
//                if let textFieldStoreSafe = textFieldStore.text {
//                    if textFieldStoreSafe != "" {
//                        if let textFieldItemNameSafe = textFieldItemName.text {
//                            if textFieldItemNameSafe != "" {
//                                if let textFieldBrandSafe = textFieldBrand.text {
//                                    if textFieldBrandSafe != "" {
//                                        if let textFieldestimatedPriceSafe = textFieldestimatedPrice.text {
//                                            if textFieldestimatedPriceSafe != "" {
//                                                if let textFieldBuyQuantitySafe = textFieldBuyQuantity.text {
//                                                    if textFieldBuyQuantitySafe != "" {
//                                                        if let textFieldSaleNoteSafe = textFieldSaleNote.text {
//                                                            if textFieldSaleNoteSafe != "" {
//
//
//                                                                if let item = self.items?[indexPath.row] {
//                                                                    do {
//                                                                        try self.realm.write {
//                                                                            item.store = textFieldStore.text!
//                                                                            item.itemName = textFieldItemName.text!
//                                                                            item.brand = textFieldBrand.text!
//                                                                            item.estimatedPrice = Double(textFieldestimatedPrice.text!)!
//                                                                            item.buyingQuantity = Double(textFieldBuyQuantity.text!)!
//                                                                            item.note = textFieldSaleNote.text!
//                                                                        }
//                                                                    } catch {
//                                                                        print("Error Saving Edited Items: \(error)")
//                                                                    }
//                                                                }
//                                                                self.tableView.reloadData()
//                                                            }
//                                                        }
//                                                    }
//                                                }
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                } else {
//                    print("error")
//                }
//
//            }
//
//
//            alert.addTextField { (alertTextField) in
//                alertTextField.insertText(item.store)
//                textFieldStore = alertTextField
//            }
//
//            alert.addTextField { (alertTextField) in
//                alertTextField.insertText(item.itemName)
//                textFieldItemName = alertTextField
//            }
//
//            alert.addTextField { (alertTextField) in
//                alertTextField.insertText(item.brand)
//                textFieldBrand = alertTextField
//            }
//
//            alert.addTextField { (alertTextField) in
//                alertTextField.insertText(String(item.estimatedPrice))
//                textFieldestimatedPrice = alertTextField
//            }
//
//            alert.addTextField { (alertTextField) in
//                alertTextField.insertText(String(item.buyingQuantity))
//                textFieldBuyQuantity = alertTextField
//            }
//
//            alert.addTextField { (alertTextField) in
//                alertTextField.insertText(item.note)
//                textFieldSaleNote = alertTextField
//            }
//
//            alert.addAction(action)
//            alert.addAction(cancelAction)
//
//            present(alert, animated: true, completion: nil)
//
//
//        }
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - UNUSED Func (Add New Items)
    
    //NOT IN USE CODE
    //This func has been replaced with a container VC with PopOver segue
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textFieldStore = UITextField()
        var textFieldItemName = UITextField()
        var textFieldBrand = UITextField()
        var textFieldestimatedPrice = UITextField()
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
                                    if let textFieldestimatedPriceSafe = textFieldestimatedPrice.text {
                                        if textFieldestimatedPriceSafe != "" {
                                            if let textFieldSalePriceSafe = textFieldSalePrice.text {
                                                if textFieldSalePriceSafe != "" {
                                                    if let textFieldSaleNoteSafe = textFieldSaleNote.text {
                                                        if textFieldSaleNoteSafe != "" {
                                                            
                                                            let newItem = CompletedItemsData()
                                                            
                                                            newItem.store = textFieldStore.text!
                                                            newItem.itemName = textFieldItemName.text!
                                                            newItem.brand = textFieldBrand.text!
                                                            newItem.estimatedPrice = Double(textFieldestimatedPrice.text!)!
                                                            newItem.salePrice = Double(textFieldSalePrice.text!)!
                                                            newItem.note = textFieldSaleNote.text!
                                                            
                                                            self.saveItems(itemArray: newItem)
                                                            
                                                            //                                                            let newItemToCompletedTable = CompletedItemsData()
                                                            //
                                                            //                                                            newItemToCompletedTable.store = textFieldStore.text!
                                                            //                                                            newItemToCompletedTable.itemName = textFieldItemName.text!
                                                            //                                                            newItemToCompletedTable.brand = textFieldBrand.text!
                                                            //                                                            newItemToCompletedTable.estimatedPrice = Float(textFieldestimatedPrice.text!)!
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
            textFieldestimatedPrice = alertTextField
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
    
    
    func saveItems(itemArray: CompletedItemsData) {
        do {
            try realm.write {
                realm.add(itemArray)
            }
        } catch {
            print("Error Saving Item \(error)")
        }
    }
    
    
    
    func loadItems() {
        
        items = realm.objects(CompletedItemsData.self).sorted(byKeyPath: "itemName", ascending: true)
        
        tableView.reloadData()
        
    }
    
    
    
}

//MARK: - Swipe Cell Delegate Method

extension CompletedShoppingItems: SwipeTableViewCellDelegate {
    
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
            tableView.reloadData()
            
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
}
