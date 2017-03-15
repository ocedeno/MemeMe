//
//  CollectionViewCell.swift
//  
//
//  Created by Programming on 8/30/15.
//
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    func setProperties (_ topText: String, bottomText: String,backgroundImage: UIImage){
        topLabel.text = topText
        bottomLabel.text = bottomText
        collectionImageView.image = backgroundImage
        collectionImageView.contentMode = .scaleAspectFill
    }
    
    func labelAttributes(){
        
        topLabel.font = UIFont(name: "Impact", size: 10.0)
        topLabel.textColor = UIColor.white
        bottomLabel.font = UIFont(name: "Impact", size: 10.0)
        bottomLabel.textColor = UIColor.white
        
        var topText = topLabel.text!
        var bottomText = bottomLabel.text!
    }
}
