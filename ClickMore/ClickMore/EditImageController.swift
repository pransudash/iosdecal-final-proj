//
//  EditImageController.swift
//  ClickMore
//
//  Created by Pransu Dash on 5/2/17.
//  Copyright © 2017 Pransu Dash. All rights reserved.
//

import UIKit

class EditImageController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var label: UILabel!
    var image: UIImage!
    var newImage: UIImage!
    var filter: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.image = image
        collection.delegate = self
        collection.dataSource = self
        label.text = ""
        label.backgroundColor = UIColor.white.withAlphaComponent(0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filter", for: indexPath) as! FilterCellController
        let imgUrl = Filters.filterImages[indexPath.row]
        if (imgUrl != nil) {
            cell.imgView.image = UIImage(named: imgUrl!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        label.text = Filters.filterNames[indexPath.row]
        if (indexPath.row == 0) {
            label.font = UIFont(name: label.font.fontName, size: 40)
        }
        label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        filter = indexPath.row
    }
    
    @IBAction func savePressed(_ sender: Any) {
        var newImage: FilteredImage = FilteredImage(img: image, filter: label)
        Images.addFilteredImage(image: newImage)
        if let _ = navigationController?.popViewController(animated: true) {
            
        } else {
            performSegue(withIdentifier: "backToHome", sender: self)
        }
        
        
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
