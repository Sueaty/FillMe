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
        mainTextField.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
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
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("돌아가기", for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemGray
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("저장하기", for: .normal)
        button.isEnabled = false
        button.layer.cornerRadius = 20
        button.backgroundColor = .secondaryLabel
        return button
    }()
    
    //MARK:- Properties
    private let todayDate = DateFormatter().today
    private let viewModel = DiaryViewModel()
    private let selectedDate: Date
    private let diaryUpdate: ((Date) -> Void)
    
    init(selectedDate: Date, diaryUpdate: @escaping ((Date) -> Void)) {
        self.selectedDate = selectedDate
        self.diaryUpdate = diaryUpdate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = DateFormatter().diaryTitleDate(date: selectedDate)
        
        view.addSubview(backgroundImageView)
        view.addSubview(titleTextField)
        view.addSubview(separatorView)
        view.addSubview(contentTextView)
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
        
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
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cancelButton.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 20),
            cancelButton.heightAnchor.constraint(equalToConstant: 44),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 10),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        cancelButton.addTarget(self,
                               action: #selector(returnButtonTouched(_:)),
                               for: .touchUpInside)
        saveButton.addTarget(self,
                             action: #selector(saveButtonTouched(_:)),
                             for: .touchUpInside)
    }

}

extension WriteDiaryViewController {
    
    @objc func returnButtonTouched(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @objc func saveButtonTouched(_ sender: UIButton) {
        if let title = titleTextField.text,
           let content = contentTextView.text {
            let diary = Diary(date: todayDate,
                              title: title,
                              content: content)
            viewModel.saveDiary(diary: diary)
        }
    }
    
}
