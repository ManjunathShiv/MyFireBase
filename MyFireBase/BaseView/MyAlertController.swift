//
//  MyAlertController.swift
//  MyFireBase
//
//  Created by Manjunath Shivakumara on 21/11/18.
//  Copyright © 2018 Manjunath Shivakumara. All rights reserved.
//

import Foundation
import UIKit

public struct Notification {
    /**
     The title of the Notification.
     */
    var title: String
    
    /**
     The description of the Notification.
     */
    var description: String
    
    /**
     The leading Button Title of the Notification.
     */
    var leadingButtonTitle: String?
    
    /**
     The trailing Button Title of the Notification.
     */
    var trailingButtonTitle: String?
    
    
    /**
     Init
     */
    init(title: String, description: String, leadingButtonTitle: String? = nil, trailingButtonTitle: String? = nil) {
        self.title = title
        self.description = description
        self.leadingButtonTitle = leadingButtonTitle
        self.trailingButtonTitle = trailingButtonTitle
    }
}

extension Notification {
    static var loginFailed: Notification {
        return Notification(title: "Login Failed",
                            description: "There is no user record corresponding to this identifier. The user may have been deleted.",
                            leadingButtonTitle: "OK",
                            trailingButtonTitle: "CANCEL")
    }
}



class MyAlertController : BaseViewController {
    static let shared = MyAlertController()
    
    public func showAlert(_ notification: Notification, completionHandler: ((Int) -> Void)? = nil) {
        let alertController = UIAlertController(title: notification.title, message: notification.description, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func hideAlert() {
        
    }
}
