//
//  InitalViewController.swift
//  MyFireBase
//
//  Created by Manjunath Shivakumara on 13/11/18.
//  Copyright © 2018 Manjunath Shivakumara. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit
import GoogleSignIn

class InitalViewController: BaseViewController {
    
    @IBOutlet weak var authenticateButton : UIButton!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let user = Auth.auth().currentUser {
            print("LoggedIn User - \(user)")
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        } else if let _ = FBSDKAccessToken.current() {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        } else {
//            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//                if let error = error {
//                    return
//                }
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
//                self.navigationController?.pushViewController(vc!, animated: true)
//            }
        }
    }
}
