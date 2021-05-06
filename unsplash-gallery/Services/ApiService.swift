//
//  ApiService.swift
//  unsplash-gallery
//
//  Created by Jeremy Papay on 04/05/2021.
//

import Foundation

class ApiService {

    private static let photosUrl = "https://api.unsplash.com/photos"
    private static let clientId = "Client-ID 86a58c98b5095e4e069222d9caaf57e27a4c0028772b5a76e4f42ff9a53ab563"

    static func getFeedPhotos(completion: @escaping ([Photo]) -> Void) {
        var request = URLRequest(url: URL(string: photosUrl)!)
        request.httpMethod = "GET"
        request.setValue(clientId, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let photosData = try jsonDecoder.decode([Photo].self, from: data)
                    completion(photosData)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }

    static func getExifForPhoto(with id: String, completion: @escaping (ExifData) -> Void) {
        var request = URLRequest(url: URL(string: "\(photosUrl)/\(id)")!)
        request.httpMethod = "GET"
        request.setValue(clientId, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let exifData = try jsonDecoder.decode(ExifData.self, from: data)
                    completion(exifData)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
