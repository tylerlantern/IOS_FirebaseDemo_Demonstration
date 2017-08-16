//
//  FBApi.swift
//  FirebaseIntroduction
//
//  Created by Nattapong Unaregul on 8/13/17.
//  Copyright © 2017 Nattapong Unaregul. All rights reserved.
//

import UIKit
import Firebase
class FBApi: NSObject {
    
    var storageRef: DatabaseReference = Database.database().reference().child("Storage")
    func add(product : Product)  {
        let newProductRef = storageRef.childByAutoId() // 2
        newProductRef.setValue(product.toDictionary())
    }
    func update(product : Product)  {
        storageRef.child(product.id).updateChildValues(product.toDictionary())
    }
    func remove(product : Product) {
        
    }
}
