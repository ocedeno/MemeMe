//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Programming on 8/30/15.
//  Copyright (c) 2015 Cedeno Enterprise, Inc. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var rowSelected: Int?
    var appDel: AppDelegate {
        return (UIApplication.shared.delegate as! AppDelegate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clear
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDel.memes.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let meme = appDel.memes[indexPath.row]
        
        cell.setTableProperties(meme.topText, bottomText: meme.bottomText, imageViewImage: meme.memedImage)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelected = indexPath.row
        let meme = appDel.memes[rowSelected!]
        performSegue(withIdentifier: "memeDetailView", sender: meme.memedImage)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "memeDetailView") {
            let data = sender as! UIImage
            let memeDetailVC = segue.destination as! MemeDetailViewController
            memeDetailVC.image = data
            memeDetailVC.rowSelected = rowSelected!
        }
    }
}
