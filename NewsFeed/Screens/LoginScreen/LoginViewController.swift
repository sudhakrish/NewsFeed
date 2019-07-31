//
//  LoginViewController.swift
//  NewsFeed
//
//  Created by Ratheesh on 31/07/19.
//  Copyright © 2019 Ratheesh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var eidTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var unifiedNumberTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var scrollBottomConstraint: NSLayoutConstraint!
    let viewModel = LoginViewModel()

    //MARK: ViewController life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        showKeyboardSetup()
    }
    
    // Validate textfields and enter submit action
    
    @IBAction func submitAction(_ sender: UIButton) {
        
        guard let eid = eidTextField.text, viewModel.isValid(eid) else {
            self.presentAlert(withTitle: "Alert", message: "Eid field is mandatory!")
            return
        }
        
        guard let name = nameTextField.text, viewModel.isValid(name) else {
            self.presentAlert(withTitle: "Alert", message: "Name is mandatory!")
            return
        }

        guard let id = idTextField.text, viewModel.isValid(id) else {
            self.presentAlert(withTitle: "Alert", message: "Idbarahno is mandatory!")
            return
        }

        guard let email = emailTextField.text, viewModel.isValid(email) else {
            self.presentAlert(withTitle: "Alert", message: "Email address is mandatory!")
            return
        }

        guard let unifiedNumber = unifiedNumberTextField.text, viewModel.isValid(unifiedNumber) else {
            self.presentAlert(withTitle: "Alert", message: "Unified number is mandatory!")
            return
        }
        
        guard let mobile = mobileTextField.text, viewModel.isValid(mobile) else {
            self.presentAlert(withTitle: "Alert", message: "Mobile number is mandatory!")
            return
        }

        guard viewModel.isValidEmail(email) else {
            self.presentAlert(withTitle: "Alert", message: "Email address is not valid format!")
            return
        }

        guard viewModel.isValidMobile(mobile) else {
            self.presentAlert(withTitle: "Alert", message: "Mobile number is not valid format!!")
            return
        }

    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Keyboard Show

extension LoginViewController {

    func showKeyboardSetup() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            scrollBottomConstraint.constant = -keyboardHeight
        }
    }

}

// MARK: - Keyboard Dismiss

extension LoginViewController {
    
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        
        UIView.animate(withDuration: 0.30, animations: { 
            self.scrollBottomConstraint.constant = 0
            self.view.endEditing(true)
        })
    }
}
