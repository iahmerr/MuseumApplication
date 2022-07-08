//
//  SearchResultTableViewCell.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 03/07/2022.
//

import UIKit

class SearchResultTableViewCell: ReusableTableViewCell {
    
    private let resultLabel: UILabel = UILabelFactory.createUILabel(textStyle: .small, fontWeight: .regular, alignment: .center, numberOfLines: 0)
    
    private var manager: SearchResultManagerInputs?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(with manager: Any) {
        self.manager = manager as? SearchResultManagerInputs
        setupViews()
        setupConstraints()
        self.manager?.delegate = self
        self.manager?.cellLoaded()
    }
}

extension SearchResultTableViewCell {
    
    func setupViews(){
        addSubview(resultLabel)
    }
    
    func setupConstraints(){
        resultLabel.pin(to: self, padding: (5,-5,10,-10))
    }
}

extension SearchResultTableViewCell: SearchResultManagerOutput {
    func postResult(result: String) {
        self.resultLabel.text = result
    }
}


