//
//  BaseViewController.swift
//  MyFireBase
//
//  Created by Manjunath Shivakumara on 12/11/18.
//  Copyright © 2018 Manjunath Shivakumara. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class BaseViewController: UIViewController {
    //MARK: - Properties
    @IBInspectable
    var shouldShowNavigationBar: Bool = false
    
    @IBInspectable
    var shouldAddGradientBackground: Bool = true
    
    @IBInspectable
    var shouldShowStatusBar: Bool = true
    
    var gradientLayer: CAGradientLayer!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if shouldAddGradientBackground {
            self.addGradientBackgroundColor()
        }
        self.addTapGestureToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
    }
    
    //MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}

//MARK: - Add Background Gradient
extension BaseViewController {
    func addGradientBackgroundColor() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [primaryColor.cgColor, secondaryColor.cgColor]
        self.view.layer.addSublayer(gradientLayer)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

//MARK: - Setup Navigation Bar
extension BaseViewController {
    func setupNavigationBar() {
        if shouldShowNavigationBar {
            self.styleNavigationBar()
        }
        self.navigationController?.setNavigationBarHidden(!shouldShowNavigationBar, animated: true)
    }
    
    func styleNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        if shouldAddGradientBackground {
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.tintColor = .white
        } else {
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.tintColor = .white
        }
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let uidFont = UIFont.init(name: "HelveticaNeue", size: 20.0)
        guard let font = uidFont else { return }
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
    }
}

extension UIViewController {
    func addTapGestureToHideKeyboard() {
        let tapGesture  = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
