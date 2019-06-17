//
//  FirestoreSvc.swift
//  Laboratory
//
//  Created by Developers on 5/28/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct FirestoreSvc {
    static func fetchAllEquipments(completion: @escaping FetchAllEquipmentHandler) {
        Firestore.firestore().collection("institutions").document("MXnWedK2McfuhBpVr3WQ").collection("items").order(by: "name", descending: false).getDocuments { (snapshot, error) in
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Equipments data"))
            } else {
                var equipmentVMs = [SimpleEquipmentVM]()
                for document in (snapshot!.documents) {
                    if let equipmentName = document.data()["name"] as? String
                    { equipmentVMs.append(SimpleEquipmentVM(equipment: Equipment(id: document.documentID, name: equipmentName)))
                    }
                }
                completion(.success(equipmentVMs))
            }
        }
    }
    
    static func fetchLabEquipments(byLabId labId: String, completion: @escaping FetchLabEquipmentHandler) {
        Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6")
            .collection("labs").document(labId).collection("equipments")
            .getDocuments { (snapshot, error) in
                if error != nil {
                    completion(.failure(error?.localizedDescription
                        ?? "ERR fetching Lab Equipments data"))
                } else {
                    var addedEquipments = [LabEquipment]()
                    for document in (snapshot!.documents) {
                        if let equipmentName = document.data()["equipmentName"] as? String,
                            let using = document.data()["using"] as? Int {
                            if using != 0 {
                                addedEquipments.append(LabEquipment(id: document.documentID, name: equipmentName, using: using))
                            }
                        }
                    }
                    completion(.success(addedEquipments))
                }
        }
    }
}
