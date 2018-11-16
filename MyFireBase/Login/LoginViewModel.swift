//
//  LoginViewModel.swift
//  MyFireBase
//
//  Created by Manjunath Shivakumara on 12/11/18.
//  Copyright © 2018 Manjunath Shivakumara. All rights reserved.
//

import Foundation
import RxSwift

struct LoginViewModel{
    var email = BehaviorSubject<String>(value: "Power@gmail.com")
    var password = BehaviorSubject<String>(value: "Philips@123")
    
//    var isValid : Observable<Bool>{
//        return Observable.combineLatest(self.email.asObservable(), self.password.asObservable())
//        { (username, password) in
//            return username.isValidEmail
//                && password.count > 0
//        }
//    }
}

extension String {
    var isValidEmail: Bool {
        let emailValidator = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailValidator.evaluate(with: self)
    }
}


