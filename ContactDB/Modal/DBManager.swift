//
//  DBManager.swift
//  ContactDB
//
//  Created by thinhdang on 8/2/20.
//  Copyright © 2020 thinhdang. All rights reserved.
//

import Foundation
import RealmSwift
class Contacts: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var position: String = ""
    @objc dynamic var email: String = ""
    
    convenience init(name: String, phone: String, position: String, email: String) {
        self.init()
        self.name = name
        self.phone = phone
        self.position = position
        self.email = email
    }

}
//
//class DBManager{
//    //bien chua tham chieu toi Realm
//    private var database:Realm
//    
//    //bien chua thuc the lop DBmanager trong program
//    static let shareInstance = DBManager()
//
//    
//    //create function
//    private init(){
//        //khoi tao database real
//        database = try! Realm()
//    }
//    
//    //get data from realm
//    func getDataFromDB() -> Results<Contacts>{
//        let result: Results<Contacts> = database.objects(Contacts.self) //get all object from realm database
//        return result
//    }
//    
//    //MARK: Create object
//    //function create data/insert data into realm database
//    func addObject(name: String,phone: String, position: String, email: String) {
//        let object = Contacts()  //create object
//    
//        //set name,phone,position,email field
//        object.name = name
//        object.phone = phone
//        object.position = position
//        object.email = email
//        
//        //write into realm database
//        try! database.write{
//            database.add(object)
//        }
//    }
//    
//    //MARK: Delete object
//    func deleteOject(object: Contacts) -> Bool {
//        do {
//            try database.write{
//                database.delete(object)
//            }
//            return true
//        } catch {
//            return false
//        }
//    }
//    
//    //MARK: Delete all item
//    func deleteAll() -> Bool {
//        do {
//            try database.write{
//                database.deleteAll()
//            }
//            return true
//        } catch {
//            return false
//        }
//    }
//    
//    //MARK: Upgrade object
//    func updateObject(object: Contacts) -> Bool {
//        do {
//            try database.write{
//                database.add(object, update: .modified)
//            }
//            return true
//        } catch {
//            return false
//        }
//    }
//}
//
