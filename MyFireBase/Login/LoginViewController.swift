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

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var continueButton: RoundedWhiteButton!
    @IBOutlet weak var passwordTF: UITextField!
    var loginVM : LoginViewModel = LoginViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupBinding()
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
        
        continueButton.rx.controlEvent(UIControlEvents.touchUpInside)
            .subscribe(onNext: {[weak self] _ in
                guard let weakself = self else {return}
            }, onError: { (error) in
                
            }, onCompleted: {
                
            })
            .disposed(by:disposeBag)
        
        loginVM.isValid
            .bind(to: continueButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
    }
}

