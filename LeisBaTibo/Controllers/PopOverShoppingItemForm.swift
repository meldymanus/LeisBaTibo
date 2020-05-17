//
//  PopOverShoppingItemForm.swift
//  Todoey
//
//  Created by Test for Word on 5/16/20.
//

import UIKit

class PopOverShoppingItemForm: UIViewController {

    
    @IBOutlet weak var itemNameTxt: UITextField!
    @IBOutlet weak var brandNameTxt: UITextField!
    @IBOutlet weak var storeTxt: UITextField!
    @IBOutlet weak var noteTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    

    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        print("\(brandNameTxt.text!)")
        
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        


        
        dismiss(animated: true, completion: nil)
    }
    

}
