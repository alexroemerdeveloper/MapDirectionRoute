//
//  DirectionsEnvironment.swift
//  MapDirectionRoute
//
//  Created by Alexander Römer on 18.01.20.
//  Copyright © 2020 Alexander Römer. All rights reserved.
//

import Foundation
import Combine
import MapKit

class DirectionsEnvironment: ObservableObject {
    
    @Published var isCalculatingDirections      = false
    @Published var isSelectingSource            = false
    @Published var isSelectingDestination       = false
    @Published var sourceMapItem                : MKMapItem?
    @Published var destinationMapItem           : MKMapItem?
    @Published var route                        : MKRoute?
    
    var cancellable: AnyCancellable?
    
    init() {
        cancellable = Publishers.CombineLatest($sourceMapItem, $destinationMapItem).sink { [weak self] (items) in
            let request = MKDirections.Request()
            request.source = items.0
            request.destination = items.1
            let directions = MKDirections(request: request)
            
            self?.isCalculatingDirections = true
            self?.route = nil
            
            directions.calculate { [weak self] (resp, err) in
                self?.isCalculatingDirections = false
                if let err = err {
                    print("Failed to calculate directions:", err)
                    return
                }
                self?.route = resp?.routes.first
            }
        }
    }
}
