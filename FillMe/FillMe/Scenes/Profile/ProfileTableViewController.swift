//
//  ProfileTableViewController.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/28.
//

import UIKit

protocol ProfileTableViewControllerDelegate: class {
    func didTouchLogin()
}

class ProfileTableViewController: UITableViewController {

    weak var delegate: ProfileTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ProfileTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0,
           indexPath.row == 2 {
            // 지금은 무조건 로그인인데 나중에 state 둬서 logout인 상태로 바꾸게도 해야함
            delegate?.didTouchLogin()
        }
    }
}
