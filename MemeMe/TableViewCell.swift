//
//  TableViewCell.swift
//  MemeMe
//
//  Created by Programming on 9/2/15.
//  Copyright (c) 2015 Cedeno Enterprise, Inc. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTopLabel: UILabel!
    @IBOutlet weak var cellBottomLabel: UILabel!
    
    func setTableProperties(topText: String,bottomText: String, imageViewImage: UIImage){
        cellTopLabel.text = topText
        cellBottomLabel.text = bottomText
        cellImageView.image = imageViewImage
        cellImageView.contentMode = .ScaleAspectFill
    }
    
    
}
