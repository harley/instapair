//
//  PhotoCell.swift
//  instapair
//
//  Created by Harley Trung on 8/27/15.
//  Copyright (c) 2015 ht. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
