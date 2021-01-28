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
    @IBOutlet weak var pwdTextField: UITextField!
    
    let actionCodeSettings = ActionCodeSettings()
    
    @IBAction func signInButtonTouched(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let pwd = pwdTextField.text else { return }
        Auth.auth().createUser(withEmail: email,
                               password: pwd) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Register Success")
            }
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
