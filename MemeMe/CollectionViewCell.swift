//
//  CollectionViewCell.swift
//  
//
//  Created by Programming on 8/30/15.
//
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var topText: String!
    var bottomText: String!
    var imageView: UIImageView!
    
    func setText (top: String, bottom: String){
        topText = top
        bottomText = bottom
        
    }
}
