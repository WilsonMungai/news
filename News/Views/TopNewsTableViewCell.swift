//
//  TopNewsTableViewCell.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-24.
//

import UIKit

class TopNewsTableViewCell: UITableViewCell {
    
    // identifier
    static let identifier = "TopNewsTableViewCell"
    
    private let newsImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
//        image.image = UIImage(named: "cool")
        image.clipsToBounds = true
        return image
    }()
    
    private let newsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
//        label.text = "Headlines"
        label.textAlignment = .left
        return label
    }()
    
    private let newsDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
//        label.text = "This is the best news Application that brings you all the latest news. This is the best news Application that brings you all the latest news"
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsImage)
        contentView.addSubview(newsTitle)
        contentView.addSubview(newsDescription)
        
//        setUpLayer()
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    // MARK: - Private functions
    private func addConstraint() {
        NSLayoutConstraint.activate([
            newsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -150),
            
            newsDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsDescription.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 10),
            newsDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -150),
            
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            newsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            newsImage.leadingAnchor.constraint(equalTo: newsDescription.trailingAnchor, constant: 20),
            newsImage.leadingAnchor.constraint(equalTo: newsTitle.trailingAnchor, constant: 20)
        ])
    }
    
    func configure(viewModel: TopNewsViewCellViewModel) {
        newsTitle.text = viewModel.title
        newsDescription.text = viewModel.description
        
        if let data = viewModel.imageData {
            newsImage.image = UIImage(data: data)
        } else if let url = viewModel.imageUrl {
            URLSession.shared.dataTask(with: url) { [weak self] data, _ , error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self?.newsImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
}
