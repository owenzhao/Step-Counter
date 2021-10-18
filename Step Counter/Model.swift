//
//  Model.swift
//  Step Counter
//
//  Created by zhaoxin on 2021/10/18.
//

import Foundation
import RealmSwift
import IceCream

class Step:Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var step = 1
    @objc dynamic var date = Date()
    
    @objc dynamic var isDeleted = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension Step: CKRecordConvertible & CKRecordRecoverable { }
