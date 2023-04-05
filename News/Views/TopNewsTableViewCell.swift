//
//  TopNewsTableViewCell.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-24.
//

import UIKit
import ProgressHUD

class TopNewsTableViewCell: UITableViewCell {
    
    // identifier
    static let identifier = "TopNewsTableViewCell"
    
    private let newsImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    // news title
    private let newsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.textAlignment = .left
        label.font = UIFont(name:"Arial Rounded MT Bold", size: 18)
        return label
    }()
    
    // news source
    private let newsSource: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.textAlignment = .left
        label.font = UIFont(name:"Arial Rounded MT Bold", size: 18)
        label.textColor = UIColor(named: "title")
        return label
    }()
    
    // Loading spinner
    private let spinner: UIActivityIndicatorView =
    {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(newsImage)
        contentView.addSubview(newsTitle)
        contentView.addSubview(newsSource)
        contentView.addSubview(spinner)
        spinner.startAnimating()
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle method
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImage.image = nil
        newsTitle.text = nil
        newsSource.text = nil
    }
    
    
    // MARK: - Private functions
    private func addConstraint() {
        NSLayoutConstraint.activate([
            // news title
            newsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            // news source
            newsSource.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -170),
            newsSource.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsSource.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            // news image constraints
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            newsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            newsImage.leadingAnchor.constraint(equalTo: newsSource.trailingAnchor, constant: 20),
            newsImage.leadingAnchor.constraint(equalTo: newsTitle.trailingAnchor, constant: 20),
            
            spinner.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            spinner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            spinner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            spinner.leadingAnchor.constraint(equalTo: newsSource.trailingAnchor, constant: 20),
            spinner.leadingAnchor.constraint(equalTo: newsTitle.trailingAnchor, constant: 20),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            
//            spinner.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ])
    }
    
    // MARK: - Public functions
    public func configure(viewModel: TopNewsViewCellViewModel) {
        // news title hookup with view model
        newsTitle.text = viewModel.title
        newsSource.text = viewModel.source
        // make usre that we have data
        if let data = viewModel.imageData {
            // if there are images stored in cache, fetch the images from cache instead of downloading again
            newsImage.image = UIImage(data: data)
            // otherwise if ther is no image data, download from the url
        } else if let url = viewModel.imageUrl {
            URLSession.shared.dataTask(with: url) { [weak self] data, _ , error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self?.newsImage.image = UIImage(data: data)
                    self?.spinner.stopAnimating()
                }
                // resume task from suspended state
            }.resume()
            // if there is no image return this
        } else if viewModel.imageUrl == nil {
            newsImage.image = UIImage(systemName: "newspaper")
        }
    }
}
