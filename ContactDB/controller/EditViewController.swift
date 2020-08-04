//
//  EditViewController.swift
//  ContactDB
//
//  Created by thinhdang on 8/3/20.
//  Copyright © 2020 thinhdang. All rights reserved.
//

import UIKit
import RealmSwift

class EditViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    var current:Contacts!
    override func viewDidLoad() {
        super.viewDidLoad()
        show()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleSave))
    }
    
    @objc func show(){
        nameTextField.text = current.name
        positionTextField.text = current.position
        phoneTextField.text = current.phone
        emailTextField.text = current.email
    }
    
    @objc func handleSave(_ sender: UIBarButtonItem){
        let name = nameTextField?.text,
        phone = phoneTextField?.text,
        position = positionTextField?.text,
        email = emailTextField?.text
        
        let dict: [String: Any?] = ["name": name,
                                    "phone": phone,
                                    "email": email,
                                    "position": position]
        RealmService.shared.update(current, with: dict)
        self.dismiss(animated: true, completion: nil)
    }
}
