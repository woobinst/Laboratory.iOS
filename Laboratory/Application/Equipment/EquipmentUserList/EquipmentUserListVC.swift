//
//  EquipmentUserListVC.swift
//  Laboratory
//
//  Created by Developers on 6/28/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class EquipmentUserListVC: UITableViewController, AlertPresentable {

    var equipmentId: String!
    private var viewModel = EquipmentUserListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        loadEquipmentUserData()
    }
    @IBAction private func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func loadEquipmentUserData() {
        viewModel.getUsers(forEquipmentId: equipmentId) { [weak self] (fetchResult) in
            guard let self = self else { return }
            switch fetchResult {
            case let .failure(errorStr):
                print(errorStr)
                self.presentAlert(forCase: .failToLoadEquipmentUser)
            case .success:
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.equipmentUserVMs?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseId) else {
                return UITableViewCell(style: .value1, reuseIdentifier: viewModel.reuseId)
            }
            return cell
        }()
        
        let equipmentUserVM = viewModel.equipmentUserVMs?[indexPath.row]
        cell.textLabel?.text = equipmentUserVM?.userName
        cell.textLabel?.font = UIFont(name: secondaryFont, size: 18)
        cell.detailTextLabel?.text = equipmentUserVM?.usingString
        cell.detailTextLabel?.font = UIFont(name: secondaryFont, size: 18)
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
