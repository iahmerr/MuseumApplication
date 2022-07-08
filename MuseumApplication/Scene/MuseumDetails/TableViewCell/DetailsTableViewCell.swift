//
//  DetailsTableViewCell.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 02/07/2022.
//

import Foundation
import UIKit

final class DetailsTableViewCell: ReusableTableViewCell {
    
    private enum CellConstants {
        static let seperatorsHeight: CGFloat = 1
        static let headingLabelTopAnchor: CGFloat = 10
        static let headingLabelLeadingAnchor: CGFloat = 30
        static let headingLabelHeight: CGFloat = 60
        static let headingLabelWidth: CGFloat = 120
        static let headingLabelBottomAnchor: CGFloat = -20
        static let dataLabelTopAnchor: CGFloat = 10
        static let dataLabelLeadingAnchor: CGFloat = 20
        static let dataLabelTrailingAnchor: CGFloat = -10
        static let dataLabelBottomAnchor: CGFloat = -20
        static let bottomSeperatorLeadingAnchor: CGFloat = 20
        static let bottomSeperatorTrailingAnchor: CGFloat = -20
    }
    
    private lazy var bottomSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = .greyDark
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headingLabel = UILabelFactory.createUILabel(with: .greyDark, textStyle: .small, fontWeight: .bold, alignment: .left)
    private lazy var dataLabel = UILabelFactory.createUILabel(with: .vintage, textStyle: .regular, alignment: .left, numberOfLines: 0)
    
    private var manager: DetailsTableViewCellInputs?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(with manager: Any) {
        self.manager = manager as? DetailsTableViewCellInputs
        self.manager?.outputs = self
        self.manager?.cellLoaded()
        self.setupViews()
        self.setupConstraints()
    }
}

extension DetailsTableViewCell {
    
    func setupViews(){
        [headingLabel, dataLabel, bottomSeperator].forEach(addSubview)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            headingLabel.topAnchor.constraint(equalTo: topAnchor, constant: CellConstants.headingLabelTopAnchor),
            headingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CellConstants.headingLabelLeadingAnchor),
            headingLabel.bottomAnchor.constraint(equalTo: bottomSeperator.topAnchor, constant: CellConstants.headingLabelBottomAnchor),
            headingLabel.widthAnchor.constraint(equalToConstant: CellConstants.headingLabelWidth),
            
            dataLabel.topAnchor.constraint(equalTo: topAnchor, constant: CellConstants.dataLabelTopAnchor),
            dataLabel.leadingAnchor.constraint(equalTo: self.headingLabel.trailingAnchor, constant: CellConstants.dataLabelLeadingAnchor),
            dataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CellConstants.dataLabelTrailingAnchor),
            dataLabel.bottomAnchor.constraint(equalTo: bottomSeperator.topAnchor, constant: CellConstants.dataLabelBottomAnchor),
            
            bottomSeperator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CellConstants.bottomSeperatorLeadingAnchor),
            bottomSeperator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CellConstants.bottomSeperatorTrailingAnchor),
            bottomSeperator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomSeperator.heightAnchor.constraint(equalToConstant: CellConstants.seperatorsHeight)
        ])
    }
}

extension DetailsTableViewCell: DetailsTableViewCellOutputs {
    
    func cellData(title: String, data: String) {
        headingLabel.text = title
        dataLabel.text = data
    }
}
