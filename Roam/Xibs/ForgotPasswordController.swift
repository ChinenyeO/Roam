//
//  ForgotPasswordController.swift
//  Roam
//
//  Created by Darrel Muonekwu on 8/10/19.
//  Copyright © 2019 Darrel Muonekwu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPasswordController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }

    @IBAction func resetPasswordClicked(_ sender: Any) {
        activityIndicator.startAnimating()
        
        guard let email = emailField.text, !email.isEmpty
        else {
            let message = "Looks like you forgot to enter your email address."
            self.activityIndicator.stopAnimating()
            self.displayError(title: "Whoops.", message: message, completion: {_ in
            })
            return
        }
        
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.activityIndicator.stopAnimating()
                self.displayError(error: error)
                return
            }
            
            let message = "Your reset email is on it's way to \(email)!."
            self.activityIndicator.stopAnimating()
            self.displayError(title: "All Done.", message: message, completion:{_ in
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 150
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
