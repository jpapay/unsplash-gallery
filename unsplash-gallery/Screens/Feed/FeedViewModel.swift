//
//  FeedViewModel.swift
//  unsplash-gallery
//
//  Created by Jeremy Papay on 04/05/2021.
//

import Foundation

class FeedViewModel {

    // MARK: - Properties
    var photos: Dynamic<[Photo]> = Dynamic([])

    func getPhotos() {
        ApiService.getFeedPhotos { [weak self] photosData in
            self?.photos.value = photosData
        }
    }
}
