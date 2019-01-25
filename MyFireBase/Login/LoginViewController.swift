//
//  LoginViewController.swift
//  MyFireBase
//
//  Created by Manjunath Shivakumara on 02/11/18.
//  Copyright © 2018 Manjunath Shivakumara. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn

class LoginViewController: BaseViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var continueStackView: UIStackView!
    @IBOutlet weak var facebookLoginButton : FBSDKLoginButton!
    @IBOutlet weak var googleLoginButton : GIDSignInButton!
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var continueButton: RoundedWhiteButton!
    @IBOutlet weak var passwordTF: UITextField!
    var loginVM : LoginViewModel = LoginViewModel()
    var disposeBag = DisposeBag()
    let activityView : UIActivityIndicatorView = UIActivityIndicatorView(style: .white)
    var googleCredential : AuthCredential? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setUpActivityView()
        self.setupBinding()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let _ = FBSDKAccessToken.current() {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        } else if googleCredential != nil {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
    func setUpActivityView() {
        activityView.color = UIColor.white
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        continueButton.center = continueStackView.center
        
        activityView.center = self.continueButton.center
        activityView.hidesWhenStopped = true
        
        self.view.addSubview(activityView)
    }
    
    func setupBinding() {
        loginVM.email.bind(to: emailTF.rx.text).disposed(by: disposeBag)
        loginVM.password.bind(to: passwordTF.rx.text).disposed(by: disposeBag)

        emailTF.rx.text
            .orEmpty
            .bind(to : loginVM.email)
            .disposed(by: disposeBag)
        
        passwordTF.rx.text
            .orEmpty
            .bind(to : loginVM.password)
            .disposed(by: disposeBag)
        
        continueButton.rx.controlEvent(UIControlEvents.touchUpInside)
            .subscribe(onNext: {[weak self] _ in
                guard let weakself = self else {return}
                weakself.continueButton.setTitle("", for: .normal)
                weakself.activityView.startAnimating()
                weakself.continueButton.bringSubviewToFront(weakself.activityView)
                weakself.loginUser()
                
            }, onError: { (error) in
                
            }, onCompleted: {
                
            })
            .disposed(by:disposeBag)
        
        loginVM.isValid
            .bind(to: continueButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        facebookLoginButton.rx.controlEvent(UIControlEvents.touchUpInside)
            .subscribe(onNext: {[weak self] _ in
                guard let weakself = self else {return}
                weakself.facebookLoginButton.readPermissions = ["public_profile", "email"]
            }).dispose()
        
        googleLoginButton.rx.controlEvent(UIControlEvents.touchUpInside)
            .subscribe(onNext: { _ in
                GIDSignIn.sharedInstance().signIn()
            }).dispose()
        
    }
    
    func loginUser() {
        guard let email = self.emailTF.text else { return }
        guard let password = self.passwordTF.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("Login Successful")
                self.activityView.stopAnimating()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            } else {
                print("Error logging in: \(error!.localizedDescription)")
                self.continueButton.setTitle("Continue", for: .normal)
                self.activityView.stopAnimating()
                MyAlertController.shared.showAlert(.loginFailed)
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            return
        }
        
        guard let authentication = user.authentication else { return }
        googleCredential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                                accessToken: authentication.accessToken)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

}

