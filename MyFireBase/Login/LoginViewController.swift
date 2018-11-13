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

class LoginViewController: BaseViewController {

    var loginVM : LoginViewModel = LoginViewModel()
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupUI()
        self.setupBinding()
    }
    
    func setupUI(){
        loginButton.layer.cornerRadius = 10.0
        loginButton.layer.borderWidth = 2.0
        loginButton.layer.borderColor = UIColor.lightGray.cgColor
        
        signUpButton.layer.cornerRadius = 10.0
        signUpButton.layer.borderWidth = 2.0
        signUpButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setupBinding() {
        loginVM.username.bind(to: usernameTF.rx.text).disposed(by: disposeBag)
        loginVM.password.bind(to: passwordTF.rx.text).disposed(by: disposeBag)

        usernameTF.rx.text
            .orEmpty
            .bind(to : loginVM.username)
            .disposed(by: disposeBag)
        
        passwordTF.rx.text
            .orEmpty
            .bind(to : loginVM.password)
            .disposed(by: disposeBag)
        
        loginButton.rx.controlEvent(UIControlEvents.touchUpInside)
            .subscribe(onNext: {[weak self] _ in
                guard let weakself = self else {return}
            }, onError: { (error) in
                
            }, onCompleted: {
                
            })
            .disposed(by:disposeBag)
        
        loginVM.isValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
    }
}

