//
//  Document.swift
//  WeScanCollectionViewExample
//
//  Created by Chris Abbod on 3/3/19.
//  Copyright © 2019 Chris Abbod. All rights reserved.
//

import Foundation
import RealmSwift

class Document: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var uuid: String = NSUUID().uuidString
    @objc dynamic var imagePath: String = ""
    
}

