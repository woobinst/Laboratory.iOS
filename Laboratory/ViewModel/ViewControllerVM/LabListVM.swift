//
//  LabListVM.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

// For Lab List ViewController
class LabListVM {
    var allLabVMs: [LabVM]?
    var displayingLabVMs: [LabVM]?
    
    func getName(at index: Int) -> String {
        return displayingLabVMs![index].labName
    }
    
    func fetchLabData(completion: @escaping FetchHandler) {
         Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").order(by: "labName", descending: false).getDocuments { [unowned self ](snapshot, error) in
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Labs data"))
            } else {
                var labVMs = [LabVM]()
                for document in (snapshot!.documents) {
                    if let labName = document.data()["labName"] as? String {
                        labVMs.append(LabVM(lab: Lab(name: labName)))
                    }
                }
                self.allLabVMs = labVMs
                self.displayingLabVMs = labVMs
                completion(.success)
            }
        }
    }
    
    func search(by text: String) {
        displayingLabVMs = allLabVMs?.filter({$0.labName.lowercased()
            .prefix(text.count) == text.lowercased()})
    }
}