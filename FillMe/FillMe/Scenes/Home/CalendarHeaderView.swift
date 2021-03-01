//
//  CalendarHeaderView.swift
//  FillMe
//
//  Created by Sue Cho on 2021/02/23.
//

import UIKit

final class CalendarHeaderView: UIView {
    
    //MARK:- Views
    lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.text = "Month"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    lazy var daysOfWeekTextStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.label.withAlphaComponent(0.2)
        return view
    }()
    
    //MARK:- Properties
    var baseDate = Date() {
        didSet {
            monthLabel.text = DateFormatter().currentCalendarTitle(baseDate: baseDate)
        }
    }
    
    //MARK:- Initializers
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGroupedBackground
        layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        layer.cornerRadius = 15
        layer.cornerCurve = .continuous
        
        addSubview(monthLabel)
        addSubview(daysOfWeekTextStackView)
        addSubview(separatorView)
        
        for dayNumber in 1...7 {
            let dayLabel = UILabel()
            dayLabel.font = .systemFont(ofSize: 12)
            dayLabel.text = dayOfWeekLetter(for: dayNumber)
            dayLabel.textColor = .secondaryLabel
            dayLabel.textAlignment = .center
            daysOfWeekTextStackView.addArrangedSubview(dayLabel)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func dayOfWeekLetter(for dayNumber: Int) -> String {
        switch dayNumber {
        case 1: return "Sun"
        case 2: return "Mon"
        case 3: return "Tue"
        case 4: return "Wed"
        case 5: return "Thu"
        case 6: return "Fri"
        case 7: return "Sat"
        default: return ""
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: topAnchor,
                                            constant: 15),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: 15),
            daysOfWeekTextStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            daysOfWeekTextStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            daysOfWeekTextStackView.bottomAnchor.constraint(equalTo: separatorView.bottomAnchor,
                                                            constant: -5),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
}
