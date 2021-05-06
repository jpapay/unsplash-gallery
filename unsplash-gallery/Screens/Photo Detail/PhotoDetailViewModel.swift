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

    init(photoData: Photo, photo: UIImage) {
        self.photoData = photoData
        self.photo = photo
    }
}
