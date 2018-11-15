//
//  SignUpViewModel.swift
//  MyFireBase
//
//  Created by Manjunath Shivakumara on 12/11/18.
//  Copyright © 2018 Manjunath Shivakumara. All rights reserved.
//

import Foundation
import RxSwift

struct SignUpViewModel{
    var username = BehaviorSubject<String>(value: "")
    var email = BehaviorSubject<String>(value: "")
    var password = BehaviorSubject<String>(value: "")
  
    var isValid : Observable<Bool>{
        return Observable.combineLatest(self.username.asObservable(), self.password.asObservable(),self.email.asObservable())
        { (username, password, email) in
            return email.isValidEmail
                && password.count > 0 && username.count > 0
        }
    }
}
