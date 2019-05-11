//
//  LabTableViewCell.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabTVCell: UITableViewCell {

    @IBOutlet var labNameLbl: UILabel!
    
    var labVM: LabVM! {
        didSet {
            labNameLbl.text = labVM.labName
            accessoryType = labVM.accessoryType
        }
    }
}
