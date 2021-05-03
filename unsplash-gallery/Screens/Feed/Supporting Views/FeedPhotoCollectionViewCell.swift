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
    private var userImage = UIView()
    private var username = UILabel()
    private var photo = UIView()
    private var photoDescription = UITextView()

    // MARK: - Properties

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

    }

    // MARK: - UI Setup
    private func setupUI() {
        // User Image
        userImage.layer.cornerRadius = 22.5
        userImage.backgroundColor = .blue
        self.addSubview(userImage)

        // User Name
        username.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        username.text = "grahammansfield1"
        username.textColor = .black
        username.translatesAutoresizingMaskIntoConstraints = false
        username.adjustsFontSizeToFitWidth = false
        username.numberOfLines = 0
        self.addSubview(username)

        // Photo
        photo.layer.cornerRadius = 60.0
        photo.backgroundColor = .green
        self.addSubview(photo)
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
    }

    // MARK: - Data Setup
//    private func setupCellDatas(from data: T) {
//
//    }
}

extension FeedPhotoCollectionViewCell {

    enum Layout {
        static let top: CGFloat = 18.0
        static let left: CGFloat = 15.0
        static let offset: CGFloat = 5.0
        static let usernameAlignement = 25.0
    }
}
