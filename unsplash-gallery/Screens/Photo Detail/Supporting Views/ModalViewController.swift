//
//  ModalViewController.swift
//  unsplash-gallery
//
//  Created by Jeremy Papay on 06/05/2021.
//

import UIKit

class ModalViewController: UIViewController {

    // MARK: - Properties
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?

    // MARK: - UI Elements
    private var containerView = UIView()
    private var label = UILabel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
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
        containerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.addSubview(containerView)

        // User Name
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.text = "Label"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 0
        containerView.addSubview(label)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
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
