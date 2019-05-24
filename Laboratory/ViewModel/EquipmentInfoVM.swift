//
//  EquipmentInfoVM.swift
//  Laboratory
//
//  Created by Huy Vo on 5/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

struct EquipmentInfoVM {
    var equipmentName: String
    var available: Int
    var description: String
    var location: String
    var pictureUrl: String
    
    var accessoryType: UITableViewCell.AccessoryType
    
    init(equipment: FullEquipment) {
        equipmentName = equipment.name
        available = equipment.available
        description = equipment.description
        location = equipment.location
        pictureUrl = equipment.pictureUrl
        accessoryType = .disclosureIndicator
    }
}
