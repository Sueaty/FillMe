//
//  HomeViewController.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/28.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    //MARK:- Views
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // TO DO:
        // define header & footer view
    
    //MARK:- View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        
        
        if let user = Auth.auth().currentUser {
            // do something
            print("User: \(user.uid)")
        } else {
            // navigate to login
            print("User should login")
        }
        
        collectionView.backgroundColor = .black
        // add subviews
        view.addSubview(collectionView)
        
        // constraints
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -10),
            collectionView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor,
                                                constant: 10),
            collectionView.heightAnchor.constraint(equalTo: view.readableContentGuide.heightAnchor,
                                                   multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate(constraints)

    }
    
    //MARK:- IBActions
    @IBAction func logoutButtonTouched(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    

}
