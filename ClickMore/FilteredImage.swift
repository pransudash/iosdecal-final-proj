//
//  FilteredImage.swift
//  ClickMore
//
//  Created by Pransu Dash on 5/2/17.
//  Copyright © 2017 Pransu Dash. All rights reserved.
//

import Foundation
import UIKit

struct FilteredImage {
    var img: UIImage!
    var filter: UILabel!
    
    init(img: UIImage, filter: UILabel) {
        self.img = img
        self.filter = filter
    }
}
