//
//  HomeViewController.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/28.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    
    
    @IBAction func logoutButtonTouched(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = Auth.auth().currentUser {
            // do something
            print("User: \(user.uid)")
        } else {
            // navigate to login
            print("User should login")
        }
    }
    

}
