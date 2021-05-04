//
//  FeedViewModel.swift
//  unsplash-gallery
//
//  Created by Jeremy Papay on 04/05/2021.
//

import Foundation
import UIKit

class FeedViewModel {

    // MARK: - Properties
    var photos: Dynamic<[Photo]> = Dynamic([])

    let cachePhoto = NSCache<NSNumber, UIImage>()
    let cacheUserPhoto = NSCache<NSNumber, UIImage>()
    
    private let utilityQueue = DispatchQueue.global(qos: .utility)

    func loadImage(with photoUrl: String, completion: @escaping (UIImage?) -> Void) {
        utilityQueue.async {
            let url = URL(string: photoUrl)!

            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)

            DispatchQueue.main.async {
                completion(image)
            }
        }
    }

    func loadUserImage(with userUrl: String, completion: @escaping (UIImage?) -> Void) {
        utilityQueue.async {
            let url = URL(string: userUrl)!

            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)

            DispatchQueue.main.async {
                completion(image)
            }
        }
    }

    func getPhotos() {
        ApiService.getFeedPhotos { [weak self] photosData in
            self?.photos.value = photosData
        }
    }
}
