//
//  InitalViewController.swift
//  MyFireBase
//
//  Created by Manjunath Shivakumara on 13/11/18.
//  Copyright © 2018 Manjunath Shivakumara. All rights reserved.
//

import Foundation
import Firebase

class InitalViewController: BaseViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let user = Auth.auth().currentUser {
            print("LoggedIn User - \(user)")
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}
