//
//  LoginViewController.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/28.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

extension LoginViewController: LoginViewDelegate {
    
    func didTouchSignin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(identifier: "SigninViewController")
        loginVC.modalPresentationStyle = .automatic
        present(loginVC, animated: true, completion: nil)
    }
    
}
