//
//  MemeClass.swift
//  MemeMe
//
//  Created by Programming on 8/26/15.
//  Copyright (c) 2015 Cedeno Enterprise, Inc. All rights reserved.
//

import Foundation
import UIKit

class MemeClass {
    
    var text1: String!
    var text2: String!
    var image: UIImage!
    var memedImage: UIImage!
    
    init(text1: String, text2: String, image: UIImage, memedImage: UIImage){
        
        self.text1 = text1
        self.text2 = text2
        self.image = image
        self.memedImage = memedImage
    }
}
