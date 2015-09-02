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
    @IBOutlet weak var collectionTopLabel: UILabel!
    @IBOutlet weak var collectionBottomLabel: UILabel!
    
    
    func setProperties (top: String, bottom: String, backgroundImage: UIImage){
        collectionTopLabel.text = top
        collectionBottomLabel.text = bottom
        collectionImageView.image = backgroundImage
        collectionImageView.contentMode = .ScaleAspectFill
    }
}
