//
//  DetailCell.swift
//  GitHub_details
//
//  Created by Alessandro Marconi on 09/10/2018.
//  Copyright © 2018 JaskierLTD. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
