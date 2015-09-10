//
//  MemeCollectionViewController.swift
//  
//
//  Created by Programming on 8/30/15.
//
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var rowSelected: Int?
    var appDel: AppDelegate {
        return (UIApplication.sharedApplication().delegate as! AppDelegate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let space: CGFloat = 2.0
        let dimensionWidth = (self.view.frame.size.width - (2 * space)) / 3.0
        let dimensionHeight = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimensionWidth, dimensionHeight)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        collectionView?.reloadData()

        navigationController?.tabBarController?.tabBar.hidden = false
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDel.memes.count
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        let meme = appDel.memes[indexPath.item]
        cell.setProperties(meme.topText, bottomText: meme.bottomText, backgroundImage: meme.image)
        cell.labelAttributes()
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        rowSelected = indexPath.row
        let meme = appDel.memes[rowSelected!]
        performSegueWithIdentifier("memeDetailView", sender: meme.memedImage)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "memeDetailView") {
            let data = sender as! UIImage
            let memeDetailVC = segue.destinationViewController as! MemeDetailViewController
            memeDetailVC.image = data
            memeDetailVC.rowSelected = rowSelected!
        }
    }
}
