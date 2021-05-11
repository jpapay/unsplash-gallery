//
//  ModalViewController.swift
//  unsplash-gallery
//
//  Created by Jeremy Papay on 06/05/2021.
//

import UIKit

class ModalViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: PhotoDetailViewModel
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?

    // MARK: - UI Elements
    private var containerView = UIView()
    private var titleLabel = UILabel()
    private var makeLabel = UILabel()
    private var modelLabel = UILabel()
    private var exposureLabel = UILabel()
    private var apertureLabel = UILabel()
    private var focalLabel = UILabel()
    private var isoLabel = UILabel()

    // MARK: - Initialization
    init(viewModel: PhotoDetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupData()
    }

    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }

    // MARK: - UI setup
    private func setupUI() {
        // Gesture Recognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)

        // Container View
        containerView.backgroundColor = #colorLiteral(red: 0.1794748902, green: 0.1794748902, blue: 0.1794748902, alpha: 1)
        containerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
        view.addSubview(containerView)

        // Title Label
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        titleLabel.text = "Infos"
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.numberOfLines = 0
        containerView.addSubview(titleLabel)

        // Make Label
        makeLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        makeLabel.textColor = .white
        makeLabel.translatesAutoresizingMaskIntoConstraints = false
        makeLabel.adjustsFontSizeToFitWidth = false
        makeLabel.numberOfLines = 0
        containerView.addSubview(makeLabel)

        // Model Label
        modelLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        modelLabel.textColor = .white
        modelLabel.translatesAutoresizingMaskIntoConstraints = false
        modelLabel.adjustsFontSizeToFitWidth = false
        modelLabel.numberOfLines = 0
        containerView.addSubview(modelLabel)

        // Exposure Label
        exposureLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        exposureLabel.textColor = .white
        exposureLabel.translatesAutoresizingMaskIntoConstraints = false
        exposureLabel.adjustsFontSizeToFitWidth = false
        exposureLabel.numberOfLines = 0
        containerView.addSubview(exposureLabel)

        // Aperture Label
        apertureLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        apertureLabel.textColor = .white
        apertureLabel.translatesAutoresizingMaskIntoConstraints = false
        apertureLabel.adjustsFontSizeToFitWidth = false
        apertureLabel.numberOfLines = 0
        containerView.addSubview(apertureLabel)

        // Focal Label
        focalLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        focalLabel.textColor = .white
        focalLabel.translatesAutoresizingMaskIntoConstraints = false
        focalLabel.adjustsFontSizeToFitWidth = false
        focalLabel.numberOfLines = 0
        containerView.addSubview(focalLabel)

        // Iso Label
        isoLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        isoLabel.textColor = .white
        isoLabel.translatesAutoresizingMaskIntoConstraints = false
        isoLabel.adjustsFontSizeToFitWidth = false
        isoLabel.numberOfLines = 0
        containerView.addSubview(isoLabel)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(Layout.top)
        }

        makeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Layout.largeTopOffset)
            $0.left.equalTo(Layout.left)
        }

        modelLabel.snp.makeConstraints {
            $0.top.equalTo(makeLabel.snp.bottom).offset(Layout.topOffset)
            $0.left.equalTo(Layout.left)
        }

        exposureLabel.snp.makeConstraints {
            $0.top.equalTo(modelLabel.snp.bottom).offset(Layout.topOffset)
            $0.left.equalTo(Layout.left)
        }

        apertureLabel.snp.makeConstraints {
            $0.top.equalTo(exposureLabel.snp.bottom).offset(Layout.topOffset)
            $0.left.equalTo(Layout.left)
        }

        focalLabel.snp.makeConstraints {
            $0.top.equalTo(apertureLabel.snp.bottom).offset(Layout.topOffset)
            $0.left.equalTo(Layout.left)
        }

        isoLabel.snp.makeConstraints {
            $0.top.equalTo(focalLabel.snp.bottom).offset(Layout.topOffset)
            $0.left.equalTo(Layout.left)
        }
    }

    // MARK: - Data Setup
    private func setupData() {
        makeLabel.text = "Make: \(viewModel.photoData.exif?.make ?? "--")"
        modelLabel.text = "Model: \(viewModel.photoData.exif?.model ?? "--")"
        exposureLabel.text = "Shutter Speed: \(viewModel.photoData.exif?.exposureTime ?? "--")"
        apertureLabel.text = "Aperture: \(viewModel.photoData.exif?.aperture ?? "--")"
        focalLabel.text = "Focal Length: \(viewModel.photoData.exif?.focalLength ?? "--")"
        isoLabel.text = "ISO: \(viewModel.photoData.exif?.iso ?? 0)"
    }

    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        guard translation.y >= 0 else { return }

        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)

        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}

extension ModalViewController {
    enum Layout {
        static let top: CGFloat = 10.0
        static let left: CGFloat = 15.0
        static let topOffset: CGFloat = 20.0
        static let largeTopOffset: CGFloat = 35.0
    }
}
