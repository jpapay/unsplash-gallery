//
//  FeedPhotoCollectionViewCell.swift
//  unsplash-gallery
//
//  Created by Jeremy Papay on 03/05/2021.
//

import UIKit
import SnapKit

class FeedPhotoCollectionViewCell: UICollectionViewCell {

    // MARK: - UI Elements
    var userImage = UIImageView()
    private var username = UILabel()
    var photo = UIImageView()
    private var photoDescription = UILabel()

    // MARK: - Properties
    var photoData: Photo? {
        didSet {
            setupCellDatas(from: photoData!)
        }
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.photo.image = nil
    }

    // MARK: - UI Setup
    private func setupUI() {
        // User Image
        userImage.contentMode = .scaleAspectFill
        userImage.clipsToBounds = true
        userImage.translatesAutoresizingMaskIntoConstraints = true
        userImage.layer.cornerRadius = 22.5
        self.addSubview(userImage)

        // User Name
        username.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        username.textColor = .black
        username.translatesAutoresizingMaskIntoConstraints = false
        username.adjustsFontSizeToFitWidth = false
        username.numberOfLines = 0
        self.addSubview(username)

        // Photo
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = true
        photo.layer.cornerRadius = 60.0
        self.addSubview(photo)

        // Photo Description
        photoDescription.font = UIFont(name: "HelveticaNeue", size: 16.0)
        photoDescription.textColor = .black
        photoDescription.translatesAutoresizingMaskIntoConstraints = false
        photoDescription.adjustsFontSizeToFitWidth = false
        photoDescription.numberOfLines = 0
        self.addSubview(photoDescription)
    }

    // MARK: - Constraints Setup
    private func setupConstraints() {
        userImage.snp.makeConstraints {
            $0.width.height.equalTo(45.0)
            $0.top.equalTo(Layout.top)
            $0.left.equalToSuperview()
        }

        username.snp.makeConstraints {
            $0.top.equalTo(Layout.usernameAlignement)
            $0.left.equalTo(userImage.snp.right).offset(10.0)
        }

        photo.snp.makeConstraints {
            $0.width.height.equalTo(370.0)
            $0.top.equalTo(userImage.snp.bottom).offset(15.0)
            $0.centerX.equalToSuperview()
        }

        photoDescription.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(photo.snp.bottom).offset(15.0)
        }
    }

    // MARK: - Data Setup
    private func setupCellDatas(from data: Photo) {
        username.text = data.user?.username
        photoDescription.text = data.photoDescription?.capitalizingFirstLetter() ?? data.altDescription?.capitalizingFirstLetter() ?? ""
    }
}

extension FeedPhotoCollectionViewCell {

    enum Layout {
        static let top: CGFloat = 18.0
        static let left: CGFloat = 15.0
        static let offset: CGFloat = 5.0
        static let usernameAlignement = 25.0
    }
}
