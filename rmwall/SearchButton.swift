//
//  SearchButton.swift
//  rmwall
//
//  Created by Esmaeel Nabil Mohamed Moustafa on 18.01.23.
//

import Foundation
import SwiftUI

struct SearchButton : View {
    var color : Color = .blue
    var onAction : OnAction
    
    
    var body: some View {
        Button(action: {onAction()}) {
            Image(systemName:"magnifyingglass.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(color)
        }
    }
}
