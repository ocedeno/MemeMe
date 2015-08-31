//
//  MemeCollectionViewController.swift
//  
//
//  Created by Programming on 8/30/15.
//
//

import UIKit

class MemeCollectionViewController: UICollectionViewCell, UICollectionViewDelegate {

    var memes = [MemeClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewController", forIndexPath: indexPath) as? MemeCollectionViewController
        let meme = memes[indexPath.item]
        cell.setText(meme.topText, bottom: meme.bottomText)
        let imageView = UIImageView(image: meme.image)
        cell.backgroundView = imageView
        
    }
}
