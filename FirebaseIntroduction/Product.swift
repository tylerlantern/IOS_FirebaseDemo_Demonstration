//
//  Item.swift
//  FirebaseIntroduction
//
//  Created by Nattapong Unaregul on 8/10/17.
//  Copyright © 2017 Nattapong Unaregul. All rights reserved.
//

import UIKit

struct Product: Serializable {
    var name : String!
    var id : String!
    init(name : String) {
        self.name = name
    }
    init(id : String,name : String) {
        self.name = name
        self.id = id
    }
    init(id : String ,dict :[String : AnyObject]) {
        self.id = id
        self.name = dict["name"] as! String
    }
    var properties: Array<String> {
        return ["name"]
    }
    func valueForKey(key: String) -> Any? {
        switch key {
        case "name":
            return name
        default:
            return nil
        }
    }
}
