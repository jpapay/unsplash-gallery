//
//  Photo.swift
//  unsplash-gallery
//
//  Created by Jeremy Papay on 04/05/2021.
//

struct Photo: Codable {
    let id: String?
    let width, height: Int?
    let color, blurHash: String?
    let photoDescription: String?
    let altDescription: String?
    let urls: Urls?
    let user: User?
    var exif: Exif?
    let location: Location?

    enum CodingKeys: String, CodingKey {
        case id
        case width, height, color
        case blurHash = "blur_hash"
        case photoDescription = "description"
        case altDescription = "alt_description"
        case urls
        case user, exif, location
    }
}

// MARK: - Exif
struct ExifData: Codable {
    let exif: Exif?
}

struct Exif: Codable {
    let make, model, exposureTime, aperture: String?
    let focalLength: String?
    let iso: Int?

    enum CodingKeys: String, CodingKey {
        case make, model
        case exposureTime = "exposure_time"
        case aperture
        case focalLength = "focal_length"
        case iso
    }
}

// MARK: - Location
struct Location: Codable {
    let title, name, city, country: String?
    let position: Position?
}

// MARK: - Position
struct Position: Codable {
    let latitude, longitude: Double?
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String?
    let thumb: String?
}

// MARK: - User
struct User: Codable {
    let id: String?
    let username: String?
    let profileImage: ProfileImage?

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case profileImage = "profile_image"
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: String?
}
