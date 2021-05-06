//
//  PhotoDetailViewController.swift
//  unsplash-gallery
//
//  Created by Jeremy Papay on 05/05/2021.
//

import UIKit
import SnapKit

class PhotoDetailViewController: UIViewController {

    // MARK: - UI Elements
    private var photo = UIImageView()
    private var infoButton = UIButton(type: .infoLight)

    // MARK: - Properties
    private var viewModel: PhotoDetailViewModel

    // MARK: - Initialization
    init(viewModel: PhotoDetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getExif(with: viewModel.photoData.id ?? "")

        setupUI()
        setupDatas()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    // MARK: - UI setup
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1)

        // Photo
        photo.contentMode = .scaleAspectFit
        photo.clipsToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(photo)

        // Info Button
        infoButton.tintColor = .white
        infoButton.addTarget(self, action: #selector(showDetails), for: .touchUpInside)

        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
    }

    // MARK: - Constraints setup
    private func setupConstraints() {
        photo.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupDatas() {
        photo.image = viewModel.photo
    }

    @objc func showDetails() {
        let modalDetails = ModalViewController()
        modalDetails.modalPresentationStyle = .custom
        modalDetails.transitioningDelegate = self
        self.present(modalDetails, animated: true, completion: nil)
    }
}

extension PhotoDetailViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
