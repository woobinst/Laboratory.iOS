//
//  LabEquipmentTVCellSnapshotTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/12/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import FBSnapshotTestCase
@testable import Laboratory

class LabEquipmentCellSnapshotTest: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func test() {
        let bundle = Bundle(for: LabEquipmentTVCell.self)
        let nib = bundle.loadNibNamed(LabEquipmentTVCell.nibId, owner: nil, options: nil)
        let labEquipmentCell = nib?.first as! LabEquipmentTVCell
        
        FBSnapshotVerifyView(labEquipmentCell)
        FBSnapshotVerifyLayer(labEquipmentCell.layer)
    }
}
