//
//  AddViewController.swift
//  ContactDB
//
//  Created by thinhdang on 8/3/20.
//  Copyright © 2020 thinhdang. All rights reserved.
//

import UIKit


protocol AddContactDelegate: AnyObject
 {
    func addContact(contact: Contacts)
}
class AddViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    weak var delegate:AddContactDelegate?
    //MARK: --PROPERTIES
   
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldMobile: UITextField!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var textFieldPosition: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    
    var currentContact:Contacts!
    //MARK: --INIT
       override func viewDidLoad() {
           super.viewDidLoad()
    
           self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
           self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
            //Do any additional setup after loading the view.
       }
    
    //MARK: --HANDLE FUNCTION Delegate
    @objc func handleDone(){
        let name: String = textFieldName.text!,
        phone: String = textFieldMobile.text!,
        position: String = textFieldPosition.text!,
        email:String = textFieldEmail.text!
        self.currentContact = Contacts(name: name, phone: phone, position: position, email: email)
        
        if(name.isEmpty || phone.isEmpty){
            let alert = UIAlertController(title: "Error", message: "You have to input name or phone", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            }))
            self.present(alert,animated: true,completion: nil)
            return
            
        }else{
            RealmService.shared.create(currentContact)
        }
        delegate?.addContact(contact: currentContact)
    }

    @objc func handleCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: --IMPORT AVATAR
//     @IBAction func importPhoto(_ sender: Any) {
//        let image = UIImagePickerController()
//        image.allowsEditing = true
//        image.sourceType = .photoLibrary
//        image.delegate = self
//        present(image,animated: true)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
//            imageAvatar.image = image
//        }else{
//            let alert = UIAlertController(title: "Error", message: "Something wrong!.", preferredStyle: UIAlertController.Style.alert)
//
//            // add an action (button)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//            // show the alert
//            self.present(alert, animated: true, completion: nil)
//        }
//         picker.dismiss(animated: true, completion: nil)
//    }
    
}