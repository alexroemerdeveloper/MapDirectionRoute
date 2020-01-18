//
//  RouteInfoView.swift
//  MapDirectionRoute
//
//  Created by Alexander Römer on 18.01.20.
//  Copyright © 2020 Alexander Römer. All rights reserved.
//

import SwiftUI
import MapKit
import Combine

struct RouteInfoView: View {
    var route: MKRoute?
    
    var body: some View {
        ScrollView {
            VStack {
                if route != nil {
                    Text("\(route?.name ?? "")")
                        .font(.system(size: 16, weight: .bold))
                        .padding()
                    
                    ForEach(route!.steps, id: \.self) { step in
                        
                        VStack {
                            if !step.instructions.isEmpty {
                                HStack {
                                    Text(step.instructions)
                                    Spacer()
                                    Text("\(String(format: "%.2f mi", step.distance * 0.00062137))")
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct RouteInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RouteInfoView()
    }
}
