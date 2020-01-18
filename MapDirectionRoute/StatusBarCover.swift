//
//  StatusBarCover.swift
//  MapDirectionRoute
//
//  Created by Alexander Römer on 18.01.20.
//  Copyright © 2020 Alexander Römer. All rights reserved.
//
import SwiftUI
import MapKit
import Combine

struct StatusBarCover: View {
    var body: some View {
        Spacer().frame(width: UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.frame.width, height: UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top)
        .background(Color.blue)
        .edgesIgnoringSafeArea(.top)
    }
}
