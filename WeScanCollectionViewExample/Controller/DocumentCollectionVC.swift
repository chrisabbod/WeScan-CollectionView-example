//
//  DocumentCollectionVC.swift
//  WeScanCollectionViewExample
//
//  Created by Chris Abbod on 3/3/19.
//  Copyright © 2019 Chris Abbod. All rights reserved.
//

import UIKit
import RealmSwift

class DocumentCollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    private let reuseIdentifier = "customDocumentCell"
    @IBOutlet weak var documentCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.documentCollectionView.register(UINib(nibName: "DocumentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! DocumentCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        //cell.imageView.image = UIImage(named: images[indexPath.item])
        cell.documentImageView.backgroundColor = UIColor.cyan
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
}
