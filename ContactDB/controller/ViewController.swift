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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.TableView.reloadData()
    }
    
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
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        vc.delegate = self
        vc.navigationItem.largeTitleDisplayMode = .never
        present(UINavigationController(rootViewController: vc),animated: true)
    }
}

        //MARK: TABLE VIEW DELEGATE
    extension ViewController:UITableViewDelegate{
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
            vc.navigationItem.largeTitleDisplayMode = .never
            let person = dataList[indexPath.row]
            vc.currentContact = person
            navigationController?.pushViewController(vc, animated: true)
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
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){(action,view,nil) in
                let currentPerson = self.dataList[indexPath.row]
                // create the alert
                 let alert = UIAlertController(title: "Delete contact", message: "Would you like to delete this contact?", preferredStyle: UIAlertController.Style.alert)

                 // add the actions (buttons)
                 alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: {action in
                    RealmService.shared.delete(currentPerson)
                 }))
                 alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

                 // show the alert
                 self.present(alert, animated: true, completion: nil)
                
            }

            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
}

    extension ViewController: AddContactDelegate {
        func addContact(contact: Contacts) {
            self.dismiss(animated: true) {
            self.TableView.reloadData()
        }
    }
}
