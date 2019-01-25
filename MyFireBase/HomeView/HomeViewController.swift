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
import FBSDKLoginKit
import GoogleSignIn

class HomeViewController: BaseViewController {
    
    @IBOutlet var logoutButton : UIButton!
    
    override func viewDidLoad() {
        logoutButton.setTitle("Logout", for: .normal)
    }
    
    @IBAction func logoutButtonPresssed() {
        
        guard Auth.auth().currentUser == nil else {
            try! Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
            return
        }
        
        do {
            if FBSDKAccessToken.currentAccessTokenIsActive(){
                try Auth.auth().signOut()
                FBSDKAccessToken.setCurrent(nil)
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                GIDSignIn.sharedInstance()?.signOut()
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
