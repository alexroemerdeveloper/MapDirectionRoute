//
//  DirectionsSearchView.swift
//  MapDirectionRoute
//
//  Created by Alexander Römer on 18.01.20.
//  Copyright © 2020 Alexander Römer. All rights reserved.
//

import SwiftUI
import MapKit
import Combine

struct DirectionsSearchView: View {
    
    @EnvironmentObject var env                  : DirectionsEnvironment
    @State private var isPresentingRouteModal   = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    VStack(spacing: 12) {
                        
                        MapItemView(selectingBool: $env.isSelectingSource, title: env.sourceMapItem != nil ? (env.sourceMapItem?.name ?? "") : "Source", image: #imageLiteral(resourceName: "start_location_circles"))
                        
                        MapItemView(selectingBool: $env.isSelectingDestination, title: env.destinationMapItem != nil ? (env.destinationMapItem?.name ?? "") : "Destination", image: #imageLiteral(resourceName: "annotation_icon"))
                    }
                    .padding()
                    .background(Color.blue)
                    
                    DirectionsMapView().edgesIgnoringSafeArea(.bottom)
                }
                
                StatusBarCover()
                
                VStack {
                    Spacer()
                    Button(action: {
                        self.isPresentingRouteModal.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("SHOW ROUTE")
                                .foregroundColor(.white)
                                .padding()
                            Spacer()
                        }
                        .background(Color.black)
                        .cornerRadius(5)
                        .padding()
                    })
                }
                .sheet(isPresented: $isPresentingRouteModal, content: {
                    RouteInfoView(route: self.env.route)
                })
                
                if env.isCalculatingDirections {
                    VStack {
                        Spacer()
                        VStack {
                            LoadingHUD()
                            Text("Loading...")
                                .font(.headline)
                                .foregroundColor(.white)
                        }.padding()
                            .background(Color.black)
                            .cornerRadius(5)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("DIRECTIONS")
            .navigationBarHidden(true)
        }
    }
}

struct DirectionsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsSearchView()
    }
}
