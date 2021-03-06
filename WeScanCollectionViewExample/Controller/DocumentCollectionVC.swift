//
//  DocumentCollectionVC.swift
//  WeScanCollectionViewExample
//
//  Created by Chris Abbod on 3/3/19.
//  Copyright © 2019 Chris Abbod. All rights reserved.
//

import UIKit
import WeScan
import RealmSwift

class DocumentCollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ImageScannerControllerDelegate {

    let realm = try! Realm()
    //var documents : Results<Document>?
    var documents: [UIImage] = []
    private let reuseIdentifier = "customDocumentCell"

    @IBOutlet weak var documentCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.documentCollectionView.register(UINib(nibName: "DocumentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadDocuments()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! DocumentCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.documentImageView.image = documents[indexPath.item]
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func loadDocuments() {
        documentCollectionView.reloadData()
    }
    
    //MARK: - WeScan Methods
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    @IBAction func addDocumentButton(_ sender: UIBarButtonItem) {
        let scannerViewController = ImageScannerController()
        scannerViewController.imageScannerDelegate = self
        present(scannerViewController, animated: true)
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        // You are responsible for carefully handling the error
        print(error)
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        
        let newDocument = Document()
        
        //create image url
        let imageName: String = newDocument.uuid
        let imagePath: String = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(imageName).png"
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
        
        //store image url
        let newImage: UIImage = results.scannedImage
        try? newImage.pngData()?.write(to: imageUrl) //Write the pngData to a location
        
        newDocument.imagePath = imagePath
        
        documents.append(newImage)
        
        scanner.dismiss(animated: true)
    }
    
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        // The user tapped 'Cancel' on the scanner
        // You are responsible for dismissing the ImageScannerController
        scanner.dismiss(animated: true)
    }
    
}
