//
//  DailyWeatherCollectionViewCell.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 27.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import UIKit

class DailyWeatherCollectionViewCell: UICollectionViewCell {
    private let tempLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private let timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .label
        return iv
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [tempLabel, iconImageView, dateLabel, timeLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.axis = .vertical
        sv.distribution = .fill
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant:self.frame.size.height/2),
            iconImageView.widthAnchor.constraint(equalToConstant: self.frame.size.width),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(presentation: DailyWeatherPresentation){
        tempLabel.text = presentation.temp
        iconImageView.image = UIImage(systemName: presentation.iconName)
        dateLabel.text = presentation.date
        timeLabel.text = presentation.time
    }
}
