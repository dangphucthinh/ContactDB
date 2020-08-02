//
//  Contact.swift
//  Contacts
//
//  Created by thinhdang on 7/30/20.
//  Copyright © 2020 Oscar. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class Contacts: Object {
    dynamic var name: String = ""
    dynamic var position: String = ""
    dynamic var email: String? = nil
    dynamic var phone: String = ""
    
    convenience init(name: String, position: String, email: String?, phone: String){
        self.init()
        self.name = name
        self.position = position
        self.email = email
        self.phone = phone
    }
    
}

