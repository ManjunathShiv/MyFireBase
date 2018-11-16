//
//  HomeViewController.swift
//  MyFireBase
//
//  Created by Manjunath Shivakumara on 16/11/18.
//  Copyright © 2018 Manjunath Shivakumara. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class HomeViewController: BaseViewController {
    
    @IBOutlet var logoutButton : UIButton!
    
    override func viewDidLoad() {
        logoutButton.setTitle("LoggedIn", for: .normal)
    }
    
    @IBAction func logoutButtonPresssed() {
        try! Auth.auth().signOut()
        self.navigationController?.popToRootViewController(animated: true)
    }
}
