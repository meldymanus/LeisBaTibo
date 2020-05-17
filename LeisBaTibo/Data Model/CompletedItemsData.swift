//
//  CompletedItemsData.swift
//  Todoey
//
//  Created by Test for Word on 5/14/20.
//

import Foundation
import RealmSwift

class CompletedItemsData: Object {
    @objc dynamic var store: String = ""
    @objc dynamic var subCategory: String = ""
    @objc dynamic var itemName: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var brand: String = ""
    @objc dynamic var weightOrCount: String = ""
    @objc dynamic var regularPrice: Float = 0.0
    @objc dynamic var salePrice: Float = 0.0
    //@objc dynamic var picture: CIImageOption? = nil
    @objc dynamic var note: String = ""
    @objc dynamic var completed: Bool = false
}
