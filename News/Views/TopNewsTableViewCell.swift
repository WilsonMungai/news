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
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    private let newsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let newsDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsImage)
        contentView.addSubview(newsTitle)
        contentView.addSubview(newsDescription)
        
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    // MARK: - Private functions
    private func addConstraint() {
        NSLayoutConstraint.activate([
            newsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            newsDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsDescription.topAnchor.constraint(equalTo: newsTitle.bottomAnchor),
            
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            newsImage.leadingAnchor.constraint(equalTo: newsTitle.trailingAnchor)
        ])
        
    }
    
}
