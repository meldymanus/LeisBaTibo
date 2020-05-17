
import Foundation
import RealmSwift

class Data: Object {
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
    
}
