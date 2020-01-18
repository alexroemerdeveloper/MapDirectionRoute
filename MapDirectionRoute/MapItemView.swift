//
//  MapItemView.swift
//  MapDirectionRoute
//
//  Created by Alexander Römer on 18.01.20.
//  Copyright © 2020 Alexander Römer. All rights reserved.
//

import SwiftUI
import MapKit
import Combine

struct MapItemView: View {
    
    @EnvironmentObject var env : DirectionsEnvironment
    @Binding var selectingBool : Bool
    var title: String
    var image: UIImage
    
    var body: some View {
        HStack(spacing: 16) {
            Image(uiImage: image.withRenderingMode(.alwaysTemplate)).frame(width: 24).foregroundColor(.white)
            
            NavigationLink(destination: SelectLocationView(), isActive: $selectingBool) {
                
                HStack {
                    Text(title)
                    Spacer()
                }
                .padding() .background(Color.white).cornerRadius(3)
            }
        }
    }
}

struct MapItemView_Previews: PreviewProvider {
    static var previews: some View {
        MapItemView(selectingBool: .constant(false), title: "Source", image: UIImage(named: "annotation_icon")!)
    }
}
