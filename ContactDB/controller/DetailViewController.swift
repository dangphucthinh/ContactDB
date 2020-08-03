//
//  DetailViewController.swift
//  ContactDB
//
//  Created by thinhdang on 8/3/20.
//  Copyright © 2020 thinhdang. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    @IBOutlet var DetailTableView: UITableView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    
    var currentContact: Contacts!
    var textName = String() //declear to pass name person
    var textMobile = String()
    var textPosition = String()
    var textEmail = String()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showInfor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEdit))
    }
    

    @objc func showInfor(){
       nameLabel?.text = currentContact.name
       positionLabel?.text = currentContact.position
       emailButton?.setTitle(currentContact.email, for: .normal)
       phoneButton?.setTitle(currentContact.phone, for: .normal)
    }
    
    @objc func handleEdit(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.current = currentContact
        //navigationController?.pushViewController(vc, animated: true)
        present(UINavigationController(rootViewController: vc),animated: true)
    }
}

