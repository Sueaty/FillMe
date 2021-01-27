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

    override func viewDidLoad() {
        super.viewDidLoad()
        imageNameView.profileNameLabel.text = "Sueaty"
    }

}
