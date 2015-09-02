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
    
    func setProperties (backgroundImage: UIImage){
        collectionImageView.image = backgroundImage
        collectionImageView.contentMode = .ScaleAspectFill
    }
}
