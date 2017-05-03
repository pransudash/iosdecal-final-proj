//
//  ViewAdController.swift
//  ClickMore
//
//  Created by Pransu Dash on 5/2/17.
//  Copyright © 2017 Pransu Dash. All rights reserved.
//

import UIKit

class ViewAdController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    var ad: FilteredImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = ad.img
        label.text = ad.filter.text
        label.backgroundColor = ad.filter.backgroundColor
        label.font = ad.filter.font
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
