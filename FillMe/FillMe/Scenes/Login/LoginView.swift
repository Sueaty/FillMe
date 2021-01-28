//
//  LoginView.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/28.
//

import UIKit

final class LoginView: UIView {
    
    //MARK:- IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    //MARK:- IBActions
    @IBAction func loginButtonTouched(_ sender: UIButton) {
        // firebase authentication 목록 확인(?)
    }
    
    @IBAction func signinButtonTouched(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signinVC = storyboard.instantiateViewController(identifier: "SigninViewController")
        signinVC.modalPresentationStyle = .automatic
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
        Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
}
