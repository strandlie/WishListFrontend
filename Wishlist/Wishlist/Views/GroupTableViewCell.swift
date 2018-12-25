//
//  GroupTableViewCell.swift
//  Wishlist
//
//  Created by Håkon Strandlie on 25/12/2018.
//  Copyright © 2018 Håkon Strandlie. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
