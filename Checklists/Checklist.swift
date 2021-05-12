//
//  Checklist.swift
//  Checklists
//
//  Created by Dewan Sunnah on 5/12/21.
//

import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    var items = [ChecklistItem]()
    
    init(name: String){
        self.name = name
        super.init()
    }
    
}


