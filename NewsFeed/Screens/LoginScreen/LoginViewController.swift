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
    
    private let viewModel = LoginViewModel()
    private let kAlertTitle = "Alert"
    private let kErrorTitle = "Error"
    private let kNewsSegue = "newsSegueIdentifier"
    
    private enum AlertMessage: String {
        
        case eEid = "Eid field is mandatory!"
        case eName = "Name is mandatory!"
        case eId = "Idbarahno is mandatory!"
        case eEmail = "Email address is mandatory!"
        case eUnified = "Unified number is mandatory!"
        case eMobile = "Mobile number is mandatory!"
        case eEmailFormat = "Email address is not valid format!"
        case eMobileFormat = "Mobile number is not valid format!!"

        var description: String {
            return self.rawValue
        }
    }
    
    //MARK: ViewController life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        showKeyboardSetup()
    }
    
    /*
     Validate textfields and enter submit action
    */
    
    @IBAction func submitAction(_ sender: UIButton) {
        
        guard let eid = eidTextField.text, viewModel.isValid(eid), let eidNumber = Int(eid) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.eEid.description)
            return
        }
        
        guard let name = nameTextField.text, viewModel.isValid(name) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.eName.description)
            return
        }

        guard let id = idTextField.text, viewModel.isValid(id), let idNumber = Int(id) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.eId.description)
            return
        }

        guard let email = emailTextField.text, viewModel.isValid(email) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.eEmail.description)
            return
        }

        guard let unifiedNumber = unifiedNumberTextField.text, viewModel.isValid(unifiedNumber), let unified = Int(unifiedNumber) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.eUnified.description)
            return
        }
        
        guard let mobile = mobileTextField.text, viewModel.isValid(mobile) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.eMobile.description)
            return
        }

        guard viewModel.isValidEmail(email) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.eEmailFormat.description)
            return
        }

        guard viewModel.isValidMobile(mobile) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.eMobileFormat.description)
            return
        }

        viewModel.body = ["eid" : eidNumber, "name" : name, "idbarahno" : idNumber, "emailaddress" : email, "unifiednumber" : unified, "mobileno" : mobile]
        
        // Call Login API with parameters

        Utility.shared.showActivityIndicator()
        viewModel.getApiData { [weak self] (data) in
            
            guard let weakSelf = self else { return }
            
            DispatchQueue.main.async {
                
                Utility.shared.hideActivityIndicator()
                
                guard data != nil else {
                    weakSelf.presentAlert(withTitle: weakSelf.kErrorTitle, message: weakSelf.viewModel.errorMessage ?? "")
                    return
                }
                
                // When success response -> Store the referenceNumber in UserDefaults
                // Push to News feed screen
                
                if let referenceNumber = data?.response?.referenceNo {
                    
                    UserDefaults.standard.set(referenceNumber, forKey: kReferenceNumberKey)
                    
                    weakSelf.performSegue(withIdentifier: weakSelf.kNewsSegue, sender: nil)
                }
            }
        }

    }

    /*
     Remove added observer in deinit
     */

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Keyboard Show

extension LoginViewController {

    private func showKeyboardSetup() {
        
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
    
    private func hideKeyboardWhenTappedAround() {
        
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
