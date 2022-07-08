//
//  MuseumDetailsViewController.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 02/07/2022.
//

import UIKit

class MuseumDetailsViewController: UIViewController {
    
    private enum ControllerConstants {
        static let tableViewEstimatedRowHeight: CGFloat = 44
        static let detailImageTopAnchor: CGFloat = 20
        static let detailImageLeadingAnchor: CGFloat = 30
        static let detailImageTrailingAnchor: CGFloat = -30
        static let detailImageHeightAnchor: CGFloat = 220
        static let bottomSeperatorTopAnchor: CGFloat = 10
        static let bottomSeperatorLeadingAnchor: CGFloat = 20
        static let bottomSeperatorTrailingAnchor: CGFloat = -20
        static let bottomSeperatorHeightAnchor: CGFloat = 1
    }
    
    private lazy var detailImage: UIImageView = UIImageViewFactory.createImageView(mode: .scaleToFill)
    
    private lazy var bottomSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = .greyDark
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = UITableViewFactory.createUITableView(seperatorStyle: .none)
    
    private let manager: MuseumDetailsInputs

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = self.manager.getTitleText()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setupView()
        setupConstraints()
        setupTableViewCells()
        addAndShowActivity()
    }
    
    init(manager: MuseumDetailsInputs) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
        self.manager.delegate = self
        self.manager.viewLoaded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

fileprivate extension MuseumDetailsViewController {
    
    private func setupView() {
        [detailImage, bottomSeperator ,tableView].forEach(view.addSubview)
    }
    
    private func setupTableViewCells(){
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.reuseIdentifier)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            detailImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ControllerConstants.detailImageTopAnchor),
            detailImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControllerConstants.detailImageLeadingAnchor),
            detailImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControllerConstants.detailImageTrailingAnchor),
            detailImage.heightAnchor.constraint(equalToConstant: ControllerConstants.detailImageHeightAnchor),
            
            bottomSeperator.topAnchor.constraint(equalTo: detailImage.bottomAnchor, constant: ControllerConstants.bottomSeperatorTopAnchor),
            bottomSeperator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControllerConstants.bottomSeperatorLeadingAnchor ),
            bottomSeperator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControllerConstants.bottomSeperatorTrailingAnchor),
            bottomSeperator.heightAnchor.constraint(equalToConstant: ControllerConstants.bottomSeperatorHeightAnchor),
            tableView.topAnchor.constraint(equalTo: bottomSeperator.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MuseumDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.manager.getNumberOfCell(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellManager = DetailsTableViewCellManager(title: self.manager.getCellData(for: indexPath.row).0, data: self.manager.getCellData(for: indexPath.row).1)
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.reuseIdentifier, for: indexPath) as! DetailsTableViewCell
        cell.configure(with: cellManager)
        return cell
    }
}

extension MuseumDetailsViewController: MuseumDetailsOutputs {
    func reloadView(with image: String) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.detailImage.loadImage(with: URL(string: image), showsIndicator: true)
            self.removeActivity()
        }
    }
    
    func showError(with message: String) {
        self.showError(error: AppError(error: message))
        self.removeActivity()
    }
}
