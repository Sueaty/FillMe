//
//  SigninView.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/28.
//

import UIKit
import Firebase

class SigninView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    let actionCodeSettings = ActionCodeSettings()
    
    @IBAction func sendLinkButtonTouched(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        Auth.auth().sendSignInLink(toEmail: email,
                                   actionCodeSettings: actionCodeSettings) { error in
            // manage error
                // do action
            
            // if the link was sent successfully, inform the user
            // save the email locally so you don't need to ask the suer for it again
            UserDefaults.standard.set(email, forKey: "Email")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitializer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInitializer()
    }
    
    private func commonInitializer() {
        Bundle.main.loadNibNamed("SigninView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        configureActionCodeSettings()
    }
    
    private func configureActionCodeSettings() {
        actionCodeSettings.url = URL(string: "https://fillme.sueaty.com")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
    }
    
}
