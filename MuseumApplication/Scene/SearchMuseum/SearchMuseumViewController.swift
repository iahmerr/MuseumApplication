//
//  ViewController.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 30/06/2022.
//

import UIKit

final class SearchMuseumViewController: UIViewController {
    
    private enum ControllerConstants {
        static let headerLabelTopAnchor: CGFloat = 15
        static let headerLabelLeadingAnchor: CGFloat = 30
        static let headerLabelTrailingAnchor: CGFloat = -30
        static let searchFieldTopAnchor: CGFloat = 15
        static let searchFieldLeadingAnchor: CGFloat = 30
        static let searchFieldTrailingAnchor: CGFloat = -30
        static let searchFieldHeightConstant: CGFloat = 50
        static let searchItemsCornerRadiusConstant: CGFloat = 5
        static let searchButtonTopAnchor: CGFloat = 15
        static let searchButtonLeadingAnchor: CGFloat = 5
        static let searchButtonTrailingAnchor: CGFloat = -15
        static let searchButtonHeightWidthConstant: CGFloat = 50
        static let tableViewTopAnchor: CGFloat = 20
        static let tableViewEstimatedRowHeight: CGFloat = 44
        static let numberOfLinesOfCell: Int = 0
    }
    
    private let headerLabel = UILabelFactory.createUILabel(with: .black, textStyle: .title2, alignment: .left, numberOfLines: 0, text: "Find your favourite Museum.. ")
    
    private let searchField: UITextField = UITextFieldFactory.createTextField(placeHolderText: "Search here",backgroundColor: .cellLight)
    
    private let searchButton : UIButton = UIButtonFactory.createButton(backgroundImage: UIImage(named: "icon_searchButton"))
    
    private lazy var tableView: UITableView = UITableViewFactory.createUITableView()
    
    private let manager: SearchMuseumInputs
    private let router: SearchModuleRouteable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.manager.getTitleText()
        view.backgroundColor = .white
        
        setupView()
        setupConstraints()
        hideKeyboardWhenTappedAround()
        setupTableView()
        textFieldEventsObserver()
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        manager.viewLoaded()
    }
    
    init(manager: SearchMuseumInputs, router: SearchModuleRouteable) {
        self.manager = manager
        self.router = router
        super.init(nibName: nil, bundle: nil)
        self.manager.outputs = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        searchField.layer.cornerRadius = ControllerConstants.searchItemsCornerRadiusConstant
        searchButton.layer.cornerRadius = ControllerConstants.searchItemsCornerRadiusConstant
    }
}

//MARK: UI Setup

fileprivate extension SearchMuseumViewController {
    
    private func setupView() {
        [headerLabel,searchField, searchButton, tableView].forEach(view.addSubview)
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.reuseIdentifier)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ControllerConstants.headerLabelTopAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControllerConstants.headerLabelLeadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControllerConstants.headerLabelTrailingAnchor),
            searchField.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: ControllerConstants.searchFieldTopAnchor),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControllerConstants.searchFieldLeadingAnchor),
            searchField.heightAnchor.constraint(equalToConstant: ControllerConstants.searchFieldHeightConstant),
            searchButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: ControllerConstants.searchButtonTopAnchor),
            searchButton.leadingAnchor.constraint(equalTo: searchField.trailingAnchor, constant: ControllerConstants.searchButtonLeadingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControllerConstants.searchButtonTrailingAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: ControllerConstants.searchButtonHeightWidthConstant),
            searchButton.widthAnchor.constraint(equalToConstant: ControllerConstants.searchButtonHeightWidthConstant),
            
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: ControllerConstants.tableViewTopAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: Outputs

extension SearchMuseumViewController : SearchMuseumOutputs {
    
    func reloadView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.removeActivity()
        }
    }
}

//MARK: Items Interations

fileprivate extension SearchMuseumViewController {
    
    @objc
    func searchButtonTapped(){
        self.addAndShowActivity()
        self.manager.searchButtonTapped(self.searchField.text)
    }
    
    func textFieldEventsObserver(){
        let editingChanged = UIAction {[weak self] _ in
            guard let self = self else { return }
            self.manager.textFieldChanged(by: self.searchField.text ?? "")
        }
        searchField.addAction(editingChanged, for: .editingChanged)
    }
}

extension SearchMuseumViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.manager.numberOfCellinSection(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellManager = SearchResultTableViewCellManager(result: self.manager.getCellData(for: indexPath.row))
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.reuseIdentifier) as! SearchResultTableViewCell
        cell.configure(with: cellManager)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.router.navigateToDetails(with: self.manager.getCellData(for: indexPath.row), nav: self.navigationController!)
    }
}
