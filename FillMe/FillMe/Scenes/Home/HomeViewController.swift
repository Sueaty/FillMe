//
//  HomeViewController.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/28.
//

import UIKit
import Firebase

final class HomeViewController: UIViewController {
    
    //MARK:- Views
    private lazy var settingBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.image = UIImage(systemName: "gearshape.fill")
        return item
    }()
    
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
    
    private lazy var headerView = CalendarHeaderView()
    
    //MARK:- Properties
    private let calendarManager = CalendarManager()

    //MARK:- View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = DateFormatter().homeTitle
        navigationItem.rightBarButtonItem = settingBarButton
        
        let swipeRight = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(respondToSwipeGesture(_:)))
        let swipeLeft = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(respondToSwipeGesture(_:)))
        
        swipeRight.direction = .right
        swipeLeft.direction = .left
        collectionView.addGestureRecognizer(swipeRight)
        collectionView.addGestureRecognizer(swipeLeft)
        
        collectionView.backgroundColor = .systemBackground
        view.backgroundColor = .systemBackground
        
        headerView.baseDate = calendarManager.baseDate
        
        if let user = Auth.auth().currentUser {
            // do something
            print("User: \(user.uid)")
        } else {
            // navigate to login
            print("User should login")
        }
        
        // add subviews
        view.addSubview(collectionView)
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                constant: 85),
            collectionView.heightAnchor.constraint(equalTo: view.readableContentGuide.heightAnchor, multiplier: 0.5),
            headerView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 85)
        ])
        
        collectionView.register(CalendarCollectionViewCell.self,
                                forCellWithReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        guard let gesture = gesture as? UISwipeGestureRecognizer else { return }
        switch gesture.direction {
        case .left:
            calendarManager.baseDate
                = calendarManager.calendar.date(byAdding: .month,
                                                value: 1,
                                                to: calendarManager.baseDate) ?? calendarManager.baseDate
        default:
            calendarManager.baseDate
                = calendarManager.calendar.date(byAdding: .month,
                                                value: -1,
                                                to: calendarManager.baseDate) ?? calendarManager.baseDate
        }
        updateCalendar()
    }
    
    private func updateCalendar() {
        let baseDate = calendarManager.baseDate
        calendarManager.days = calendarManager.generateDaysInMonth(for: baseDate)
        collectionView.reloadData()
        headerView.baseDate = baseDate
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

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        calendarManager.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let day = calendarManager.days[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier,
            for: indexPath) as! CalendarCollectionViewCell
        cell.day = day
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = Int(collectionView.frame.width / 7)
        // let height = Int(collectionView.frame.height) / numberOfWeeksInBaseDate
        return CGSize(width: width, height: width)
        
        // memo: CGSize(width: width, height: width) => 달력 크기는 다르지만 cell은 정사각형
        //       CGSize(width: width, height: height) => 달력 크기는 같지만 cell이 달라짐
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let day = calendarManager.days[indexPath.item]
        let diaryVC = WriteDiaryViewController(selectedDate: day.date) { [weak self] date in
            guard let self = self else { return }
            collectionView.reloadItems(at: [indexPath])
        }
        navigationController?.pushViewController(diaryVC, animated: true)
        // TO DO:
            // navigate to 'WriteDiaryVC' so that user can fill the diary for that day
            // of course, it must be disable if selected date is in the future
    }
    
}
