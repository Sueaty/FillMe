//
//  ProfileViewController.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/27.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var imageNameView: NameImageView!

    var tableViewController: ProfileTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewController = self.children[0] as? ProfileTableViewController
        tableViewController?.delegate = self
        imageNameView.profileNameLabel.text = "Sueaty"
    }

}

extension ProfileViewController: ProfileTableViewControllerDelegate {
    func didTouchLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(identifier: "LoginViewController") as LoginViewController
        navigationController?.pushViewController(loginVC, animated: true)
//        loginVC.modalPresentationStyle = .automatic
//        present(loginVC, animated: true, completion: nil)
    }
}
