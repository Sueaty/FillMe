//
//  NameImageView.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/27.
//

import UIKit

// there are 2 ways you can create your custom UIView
    // 1. programatically 2. in IB
    // there's an initializer for each method, so we need to override them both
class NameImageView: UIView {
    
    //MARK:- IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    //MARK:- Initializers
    // for using CustomView in code
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitializer()
    }
    
    // for using CustomView in IB
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInitializer()
    }
    
    private func commonInitializer() {
        // load XIB
        Bundle.main.loadNibNamed("NameImageView", owner: self, options: nil) // load XIB by name from memory
        addSubview(contentView)
        // positioning the contentView to take up the entire view's appearance (not the best pattern.... 그럼 어쩌라는겨)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // configure view
        configureView()
    }
    
    //MARK:- View Configuration
    private func configureView() {
        profileImageView.layer.cornerRadius = profileImageView.image?.size.width ?? 120 / 2
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.backgroundColor = UIColor.lightGray
    }

}
