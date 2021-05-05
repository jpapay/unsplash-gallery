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
    private var activityIndicator = UIActivityIndicatorView()

    // MARK: - Properties
    private var viewModel: FeedViewModel

    // MARK: - Initialization
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupObservers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        viewModel.getPhotos()
    }

    // MARK: - UI setup
    private func setupUI() {
        view.backgroundColor = .white

        // Activity Indicator
        view.addSubview(activityIndicator)

        // Feed Header
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Photos"

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        // Feed Photos CollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.minimumLineSpacing = 30.0
        layout.itemSize = CGSize(width: 370, height: 480.0)
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

        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    // MARK: - Observers setup
    private func setupObservers() {
        viewModel.photos.bind(self) { [weak self] _ in

            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true

                self?.feedPhotosCollectionView.reloadData()
            }
        }
    }
}

extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedPhotoCollectionViewCell", for: indexPath) as? FeedPhotoCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.photoData = viewModel.photos.value[indexPath.item]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            guard let cell = cell as? FeedPhotoCollectionViewCell else { return }
            let itemNumber = NSNumber(value: indexPath.item)

            if let cachedImage = self.viewModel.cachePhoto.object(forKey: itemNumber) {
                    cell.photo.image = cachedImage
                } else {
                    self.viewModel.loadImage(with: (self.viewModel.photos.value[indexPath.item].urls?.regular)!) { [weak self] (image) in
                        guard let self = self, let image = image else { return }
                        cell.photo.image = image
                        self.viewModel.cachePhoto.setObject(image, forKey: itemNumber)
                    }
                }

        if let cachedUserImage = self.viewModel.cacheUserPhoto.object(forKey: itemNumber) {
                cell.userImage.image = cachedUserImage
            } else {
                self.viewModel.loadUserImage(with: (self.viewModel.photos.value[indexPath.item].user?.profileImage?.medium)!) { [weak self] (image) in
                    guard let self = self, let image = image else { return }
                    cell.userImage.image = image
                    self.viewModel.cacheUserPhoto.setObject(image, forKey: itemNumber)
                }
            }
        }
}
