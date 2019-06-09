//
//  EquipmentInfoVC.swift
//  Laboratory
//
//  Created by Developers on 5/16/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class EquipmentInfoVC: UIViewController, SpinnerPresentable, AlertPresentable {
    
    @IBOutlet private var mainView: EquipmentInfoView!
    let spinnerVC = SpinnerViewController()

    var equipmentName: String?
    private var viewModel = EquipmentInfoVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.isHidden = true
        showSpinner()
        loadEquipmentInfo()
    }

    func loadEquipmentInfo() {
        viewModel.fetchEquipmentInfo(byName: equipmentName!) { [weak self] (fetchResult) in
            guard let self = self else { return }
            switch fetchResult {
            case .success:
                DispatchQueue.main.async {
                    self.updateUI()
                }
//                self.hideActivityIndicator()
            case let .failure(errorStr):
                print(errorStr)
                // show an alert and return to the previous page
                self.presentAlert(forCase: .failToLoadEquipmentInfo, handler: self.goBack)
            }
        }
    }
    
    private func updateUI() {
        mainView.availableLabel.text = viewModel.availableString
        mainView.nameLabel.text = viewModel.equipmentName
        mainView.locationTextView.text = viewModel.location
        LayoutUtil.adjustUITextViewHeight(arg: mainView.locationTextView)
        mainView.descriptionTextView.text = viewModel.description
        LayoutUtil.adjustUITextViewHeight(arg: mainView.descriptionTextView)
        do {
            let url = URL(string: viewModel.pictureUrl)!
            let data = try Data(contentsOf: url)
            mainView.equipmentImageView.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
        
        // show the view
        mainView.isHidden = false
        // hide spinner
        hideSpinner()
    }
    
    func goBack(alert: UIAlertAction!) {
        // go back to Equipment List View
        navigationController?.popViewController(animated: true)
    }
}