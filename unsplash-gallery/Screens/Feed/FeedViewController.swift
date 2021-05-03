//
//  FeedViewController.swift
//  unsplash-gallery
//
//  Created by Jeremy Papay on 01/05/2021.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {

    // MARK: - UI Elements
    private var feedPhotosCollectionView = UICollectionView(withFlowLayout: true)

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }

    // MARK: - UI setup
    private func setupUI() {
        view.backgroundColor = .white

        // Feed Header
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Photos"

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        // Feed Photos CollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.minimumLineSpacing = 30.0
        layout.itemSize = CGSize(width: 370, height: 430.0)
        layout.scrollDirection = .vertical

        feedPhotosCollectionView.setCollectionViewLayout(layout, animated: true)
        feedPhotosCollectionView.delegate = self
        feedPhotosCollectionView.dataSource = self
        feedPhotosCollectionView.register(FeedPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "FeedPhotoCollectionViewCell")
        feedPhotosCollectionView.backgroundColor = .clear

        view.addSubview(feedPhotosCollectionView)
    }

    // MARK: - Constraints setup
    private func setupConstraints() {
        feedPhotosCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedPhotoCollectionViewCell", for: indexPath) as? FeedPhotoCollectionViewCell else {
            return UICollectionViewCell()
        }

        return cell
    }
}
