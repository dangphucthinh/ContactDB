//
//  ContactTableViewCell.swift
//  Contacts
//
//  Created by thinhdang on 7/30/20.
//  Copyright © 2020 Oscar. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet var textName:UILabel!
    @IBOutlet var textPosition:UILabel!
    
    func configure(with contactLine: Contacts) {
        textName.text = contactLine.name
        textPosition.text = contactLine.position
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


