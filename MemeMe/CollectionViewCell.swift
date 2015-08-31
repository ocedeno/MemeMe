//
//  CollectionViewCell.swift
//  
//
//  Created by Programming on 8/30/15.
//
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    func setText (top: String, bottom: String){
        topLabel.text = top
        bottomLabel.text = bottom
        
    }
}
