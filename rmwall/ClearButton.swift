//
//  ClearButton.swift
//  rmwall
//
//  Created by Esmaeel Nabil Mohamed Moustafa on 18.01.23.
//

import Foundation
import SwiftUI

struct ClearButton : View {
    var color : Color = .blue
    var onAction : OnAction
    
    var body: some View {
        Button(action: {
            onAction()
           
        }) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(color)
        }.padding(.leading,16)
    }
}

