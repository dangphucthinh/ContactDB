//
//  ViewController.swift
//  ContactDB
//
//  Created by thinhdang on 8/3/20.
//  Copyright © 2020 thinhdang. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    @IBOutlet var TableView: UITableView!

    var aphabel = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var notificationToken:NotificationToken?
    //   var dbContact: DBManager! //create data manager
 
    var dataList : Results<Contacts>!
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
          //  dbContact = DBManager.shareInstance
          //  dataList = dbContact.getDataFromDB()
            
            let realm = RealmService.shared.realm
            dataList = realm.objects(Contacts.self)
            
            notificationToken = realm.observe{ (notification, realm) in
                self.TableView.reloadData()
            }
            
            TableView.dataSource = self
            //MARK:--BUTTON ADD delegate
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddContact))
            
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationToken?.invalidate()
        RealmService.shared.stopObservingErrors(in: self)
    }
    


    @objc func handleAddContact(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "addView") as! AddViewController
//        vc.handleDone(in: self) { (name, phone, position, email) in
//            let newContact = Contacts(name: name, phone: phone, position: position, email: email)
                
//            RealmService.shared.create(newContact)
//        }
        vc.delegate = self
        vc.navigationItem.largeTitleDisplayMode = .never
        present(UINavigationController(rootViewController: vc),animated: true)
    }
}
           
        //MARK: -CREATE A TITLE
    extension ViewController:UITableViewDataSource{
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return self.aphabel[section]
        }
    
        //MARK: -SHOW NUMBER OF SECTION
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        //MARK: -SHOW NUMBER OF ROW IN SECTION
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataList.count;
        }
        
        //MARK: -DISPLAY A DATA IN TABLE VIEW
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
            let currentPerson = dataList[indexPath.row]
            cell.configure(with: currentPerson)
            return cell
        }
}

extension ViewController: AddContactDelegate {
    func addContact(contact: Contacts) {
            self.dismiss(animated: true) {
            self.TableView.reloadData()
                print(self.dataList!)
        }
    }
}
