//
//  PhotoDetailViewModel.swift
//  unsplash-gallery
//
//  Created by Jeremy Papay on 05/05/2021.
//

import Foundation
import UIKit

class PhotoDetailViewModel {

    // MARK: - Properties
    var photoData: Photo
    var photo: UIImage
    var hasLocation: Bool

    init(photoData: Photo, photo: UIImage) {
        self.photoData = photoData
        self.photo = photo
        self.hasLocation = (photoData.location != nil) ? true : false
    }

    func getExif(with id: String) {
        ApiService.getExifForPhoto(with: id) { [weak self] data in
            self?.photoData.exif = data.exif
        }
    }
}
