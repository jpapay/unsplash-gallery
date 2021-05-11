//
//  AnnotationView.swift
//  unsplash-gallery
//
//  Created by Jeremy Papay on 11/05/2021.
//

import Foundation
import MapKit

class AnnotationView: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let coordinate: CLLocationCoordinate2D

  init(title: String?, locationName: String?, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.locationName = locationName
    self.coordinate = coordinate

    super.init()
  }

  var subtitle: String? {
    return locationName
  }
}
