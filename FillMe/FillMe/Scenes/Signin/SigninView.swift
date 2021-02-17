//
//  SigninView.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/28.
//

import UIKit

final class SigninView: UIView {
    
    //MARK:- IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!

    //MARK:- Properties
    let viewModel = SigninViewModel()
    
    //MARK:- IBActions
    @IBAction func signInButtonTouched(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = pwdTextField.text else { return }
        viewModel.createAccount(email: email, password: password)
    }
    
    //MARK:- Initializers
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
    }
    
}
