//
//  Images.swift
//  ClickMore
//
//  Created by Pransu Dash on 5/2/17.
//  Copyright © 2017 Pransu Dash. All rights reserved.
//

import Foundation
import UIKit

class Images {
    static var imgIndex : Int = 12
    static var filteredIndex: Int = 0
    
    static var imageArray : [Int:UIImage] = [
        0: UIImage(named: "img0")!,
        1: UIImage(named: "img1")!,
        2: UIImage(named: "img2")!,
        3: UIImage(named: "img3")!,
        4: UIImage(named: "img4")!,
        5: UIImage(named: "img5")!,
        6: UIImage(named: "img6")!,
        7: UIImage(named: "img7")!,
        8: UIImage(named: "img8")!,
        9: UIImage(named: "img9")!,
        10: UIImage(named: "img10")!,
        11: UIImage(named: "img11")!
        
    ]
    
    static var adsArray: [Int:FilteredImage] = [:]
    
    static func addFilteredImage(image: FilteredImage) {
        Images.adsArray[Images.filteredIndex] = image
        Images.filteredIndex += 1
    }
    
    static func addImage(image: UIImage) {
        Images.imageArray[Images.imgIndex] = image
        Images.imgIndex += 1
    }

}
