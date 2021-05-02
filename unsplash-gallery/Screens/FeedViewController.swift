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

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }

    // MARK: - UI setup
    private func setupUI() {
        view.backgroundColor = .white

        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Photos"

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }

    // MARK: - Constraints setup
    private func setupConstraints() {
        //
    }
}
