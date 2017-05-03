//
//  Images.swift
//  ClickMore
//
//  Created by Pransu Dash on 5/2/17.
//  Copyright © 2017 Pransu Dash. All rights reserved.
//

import Foundation

class Images {
    static var imgIndex : Int = 12
    static var filteredIndex: Int = 0
    
    static var imageArray : [Int:String] = [
        0: "img0",
        1: "img1",
        2: "img2",
        3: "img3",
        4: "img4",
        5: "img5",
        6: "img6",
        7: "img7",
        8: "img8",
        9: "img9",
        10: "img10",
        11: "img11"
    ]
    
    static var adsArray: [Int:FilteredImage] = [:]
    
    static func addFilteredImage(image: FilteredImage) {
        Images.adsArray[Images.filteredIndex] = image
        Images.filteredIndex += 1
    }

}
