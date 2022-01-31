//
//  BuildingCollectionViewCell.swift
//  PracticeMaze
//
//  Created by Jiajun's Computer on 8/5/20.
//  Copyright © 2020 Jiajun Yan. All rights reserved.
//

import UIKit

class BuildingCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var name: UILabel!
    var building : String?
    
    
    
    func configure(building : String){
        self.building = building
        self.backgroundColor = .black
        name.text = "Building " + building[building.index(building.startIndex, offsetBy: 8)...]
        name.textColor = .white
        name.alpha = 1
    }
}
