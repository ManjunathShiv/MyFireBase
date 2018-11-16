//
//  SignupViewController.swift
//  MyFireBase
//
//  Created by Manjunath Shivakumara on 12/11/18.
//  Copyright © 2018 Manjunath Shivakumara. All rights reserved.
//


import UIKit
import RxCocoa
import RxSwift
import Firebase

class SignupViewController: BaseViewController {
    
    @IBOutlet weak var continueStackView: UIStackView!
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var continueButton: RoundedWhiteButton!
    @IBOutlet weak var passwordTF: UITextField!
    var signupVM : SignUpViewModel = SignUpViewModel()
    var disposeBag = DisposeBag()
    let activityView : UIActivityIndicatorView = UIActivityIndicatorView(style: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setUpActivityView()
        self.setupBinding()
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
        signupVM.username.bind(to: usernameTF.rx.text).disposed(by: disposeBag)
        signupVM.email.bind(to: emailTF.rx.text).disposed(by: disposeBag)
        signupVM.password.bind(to: passwordTF.rx.text).disposed(by: disposeBag)
        
        usernameTF.rx.text
            .orEmpty
            .bind(to : signupVM.username)
            .disposed(by: disposeBag)
        
        emailTF.rx.text
            .orEmpty
            .bind(to : signupVM.email)
            .disposed(by: disposeBag)
        
        passwordTF.rx.text
            .orEmpty
            .bind(to : signupVM.password)
            .disposed(by: disposeBag)
        
        continueButton.rx.controlEvent(UIControlEvents.touchUpInside)
            .subscribe(onNext: {[weak self] _ in
                guard let weakself = self else {return}
                weakself.continueButton.setTitle("", for: .normal)
                weakself.activityView.startAnimating()
                weakself.continueButton.bringSubviewToFront(weakself.activityView)
                weakself.createUser()
                }, onError: { (error) in
                    
            }, onCompleted: {
                
            })
            .disposed(by:disposeBag)
        
        signupVM.isValid
            .bind(to: continueButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
    }
    
    func createUser() {
        guard let username = usernameTF.text else { return }
        guard let email = emailTF.text else { return }
        guard let password = passwordTF.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("User created!")
                self.activityView.stopAnimating()
                self.continueButton.setTitle("Continue", for: .normal)
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username

                changeRequest?.commitChanges { error in
                    if error == nil {
                        print("User display name changed!")
                        self.dismiss(animated: false, completion: nil)
                    } else {
                        print("Error: \(error!.localizedDescription)")
                    }
                }
                
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
    }
    
}

