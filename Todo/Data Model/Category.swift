//
//  Category.swift
//  Todo
//
//  Created by Esteban Ordonez on 9/18/19.
//  Copyright © 2019 Esteban Ordonez. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name:String = ""
    let items = List<Item>()
}
