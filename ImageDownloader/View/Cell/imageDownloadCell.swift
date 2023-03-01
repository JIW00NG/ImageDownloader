//
//  imageDownloadCell.swift
//  ImageDownloader
//
//  Created by JiwKang on 2023/03/01.
//

import UIKit

class ImageDownloadCell: UITableViewCell {
    
    // MARK: - Properties
    
    var downloadImageViewModel = DownloadImageViewModel()
    var index = 0
    
    // MARK: - View Properties
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private let downloadedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0.5
        return progressView
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Load", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func render() {
        contentView.addSubview(stackView)
        
        [stackView, downloadedImageView, downloadButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [downloadedImageView, progressView, downloadButton].forEach { view in
            stackView.addArrangedSubview(view)
        }

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            downloadedImageView.heightAnchor.constraint(equalToConstant: 100),
            downloadedImageView.widthAnchor.constraint(equalToConstant: 130),
            
            downloadButton.heightAnchor.constraint(equalToConstant: 35),
            downloadButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func addTargets() {
        downloadButton.addTarget(self, action: #selector(downloadImageFromURL), for: .touchUpInside)
    }
    
    @objc func downloadImageFromURL() {
        downloadedImageView.image = UIImage(systemName: "photo")
        
        Task {
            do {
                let downloadedImage = try await downloadImageViewModel.downloadImageFromURL(i: index)
                DispatchQueue.main.async {
                    self.downloadedImageView.image = downloadedImage
                }
            } catch DownloadError.downloadFail {
                print("Image Download Fail!")
            }
        }
    }
}
