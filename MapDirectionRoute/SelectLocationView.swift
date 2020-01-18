//
//  SelectLocationView.swift
//  MapDirectionRoute
//
//  Created by Alexander Römer on 18.01.20.
//  Copyright © 2020 Alexander Römer. All rights reserved.
//

import SwiftUI
import MapKit
import Combine

struct SelectLocationView: View {
    
    @EnvironmentObject var env     : DirectionsEnvironment
    @State private var mapItems    = [MKMapItem]()
    @State private var searchQuery = ""
    
    var body: some View {
        VStack {
            
            HStack (spacing: 16) {
                Button(action: {
                    self.env.isSelectingSource      = false
                    self.env.isSelectingDestination = false
                    
                }, label: {
                    Image(uiImage: #imageLiteral(resourceName: "back_arrow"))
                })
                    .foregroundColor(.black)
                
                TextField("Enter search term", text: $searchQuery)
                    .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification).debounce(for: .milliseconds(500), scheduler: RunLoop.main)) { _ in
                        
                        let request = MKLocalSearch.Request()
                        request.naturalLanguageQuery = self.searchQuery
                        let search = MKLocalSearch(request: request)
                        search.start { (resp, err) in
                            self.mapItems = resp?.mapItems ?? []
                        }
                }
            }
            .padding()
            
            if mapItems.count > 0 {
                ScrollView {
                    ForEach(mapItems, id: \.self) { item in
                        Button(action: {
                            if self.env.isSelectingSource {
                                self.env.isSelectingSource = false
                                self.env.sourceMapItem     = item
                            } else {
                                self.env.isSelectingDestination = false
                                self.env.destinationMapItem     = item
                            }
                        }) {
                            HStack {
                                VStack (alignment: .leading) {
                                    Text("\(item.name ?? "")")
                                        .font(.headline)
                                    Text("\(item.address())")
                                }
                                Spacer()
                            }
                            .padding()
                        }
                        .foregroundColor(.black)
                        
                    }
                }
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct SelectLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLocationView()
    }
}
