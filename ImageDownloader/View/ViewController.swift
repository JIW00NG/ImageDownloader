//
//  ViewController.swift
//  ImageDownloader
//
//  Created by JiwKang on 2023/03/01.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var downloadImageViewModel = DownloadImageViewModel()
    
    // MARK: - View Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    private let allDownloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Load All Images", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        render()
        addTargets()
    }
    
    // MARK: - Functions
    
    private func render() {
        [tableView, allDownloadButton].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            allDownloadButton.heightAnchor.constraint(equalToConstant: 40),
            allDownloadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            allDownloadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            allDownloadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: allDownloadButton.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func addTargets() {
        allDownloadButton.addTarget(self, action: #selector(allDownloadPress), for: .touchUpInside)
    }
    
    @objc private func allDownloadPress() {
        for cell in tableView.visibleCells {
            let cell = cell as? ImageDownloadCell
            cell?.downloadImageFromURL()
        }
    }
}

// MARK: - UITableView Delegate & DataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadImageViewModel.urlCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ImageDownloadCell()
        cell.index = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

