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
    
    let viewModel = DiaryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func doneButtonTouched(_ sender: UIBarButtonItem) {
        let today = DateFormatter().today
        if let title = diaryTitle.text,
           let content = diaryContent.text {
            let share = shareEnable.isOn
            let diary = Diary(date: today,
                              title: title,
                              content: content,
                              share: share)
            viewModel.saveDiary(diary: diary)
        }
         
    }
}
