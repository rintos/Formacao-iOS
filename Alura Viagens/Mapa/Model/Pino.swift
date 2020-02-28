//
//  Pino.swift
//  Alura Viagens
//
//  Created by Victor Soares de Almeida on 28/02/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import MapKit

class Pino: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var icon: UIImage?
    var color:  UIColor?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
