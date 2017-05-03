//
//  AdsViewController.swift
//  ClickMore
//
//  Created by Pransu Dash on 5/2/17.
//  Copyright © 2017 Pransu Dash. All rights reserved.
//

import UIKit

class AdsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collection: UICollectionView!
    var selectedAd: FilteredImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collection.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Images.filteredIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ad", for: indexPath) as! AdCellController
        let ad = Images.adsArray[indexPath.row]
        if (ad != nil) {
            cell.imageView.image = ad?.img
            cell.label.text = ad?.filter.text
            if (ad?.filter.text == "Strawberry Farm") {
                cell.label.font = UIFont(name: cell.label.font.fontName, size: 10)
            }
            cell.label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAd = Images.adsArray[indexPath.row]
        performSegue(withIdentifier: "viewAd", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ViewAdController {
            dest.ad = selectedAd
        }
    }

}
