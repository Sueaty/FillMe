//
//  WriteDiaryViewController.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/29.
//

import UIKit

final class WriteDiaryViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var diaryTitle: UITextField!
    @IBOutlet weak var diaryContent: UITextView!
    @IBOutlet weak var shareEnable: UISwitch!
    
    //MARK:- Properties
    private let todayDate = DateFormatter().today
    private let viewModel = DiaryViewModel()
    
    //MARK:- Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Write"
    }
    
    //MARK:- IBActions
    @IBAction func doneButtonTouched(_ sender: UIBarButtonItem) {
        if let title = diaryTitle.text,
           let content = diaryContent.text {
            let share = shareEnable.isOn
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
