//
//  WriteDiaryViewController.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/29.
//

import UIKit

final class WriteDiaryViewController: UIViewController {
  
    //MARK:- Views
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(named: "background") {
            
            imageView.image = image
        }
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.1
        return imageView
    }()
    
    private lazy var titleTextField: UITextField = {
        let mainTextField = UITextField()
        mainTextField.translatesAutoresizingMaskIntoConstraints = false
        mainTextField.placeholder = "제목 없음"
        mainTextField.font = UIFont.systemFont(ofSize: 25,
                                              weight: .heavy)
        return mainTextField
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.label.withAlphaComponent(0.2)
        return view
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        textView.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.secondaryLabel.cgColor
        textView.backgroundColor = .clear
        return textView
    }()
    
    private lazy var sharingSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        return switcher
    }()
    
    //MARK:- Properties
    private let todayDate = DateFormatter().today
    private let viewModel = DiaryViewModel()
    
    //MARK:- View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
   
        view.addSubview(backgroundImageView)
        view.addSubview(titleTextField)
        view.addSubview(separatorView)
        view.addSubview(contentTextView)
        view.addSubview(sharingSwitch)
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTextField.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 20),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            separatorView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentTextView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20),
            contentTextView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.75),
            sharingSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sharingSwitch.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 10)
        ])
    }
    
    //MARK:- IBActions
    @IBAction func doneButtonTouched(_ sender: UIBarButtonItem) {
        if let title = titleTextField.text,
           let content = contentTextView.text {
            let share = sharingSwitch.isOn
            let diary = Diary(date: todayDate,
                              title: title,
                              content: content,
                              share: share)
            viewModel.saveDiary(diary: diary)
        }
    }
    
    @IBAction func cancelButtonTouched(_ sender: UIBarButtonItem) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.popViewController(animated: true)
    }
    
}
