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
    private var photoDescription = UILabel()

    // MARK: - Properties

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {

    }

    // MARK: - UI Setup
    private func setupUI() {

    }

    // MARK: - Constraints Setup
    private func setupConstraints() {

    }

    // MARK: - Data Setup
//    private func setupCellDatas(from data: T) {
//
//    }
}
