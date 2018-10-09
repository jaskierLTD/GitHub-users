//
//  TableCell.swift
//  GitHub_details
//
//  Created by Alessandro Marconi on 08/10/2018.
//  Copyright © 2018 JaskierLTD. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
        
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var reposLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
