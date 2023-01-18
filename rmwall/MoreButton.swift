//
//  MoreButton.swift
//  rmwall
//
//  Created by Esmaeel Nabil Mohamed Moustafa on 18.01.23.
//

import Foundation
import SwiftUI


struct MoreButton : View {
    var shouldShowContextMenu : Bool
    var onMoreIconLongPress : OnAction
    var onSave : OnAction
    var onSavedList : OnAction
    var onClearList : OnAction
    var onClearCookiesAndRefresh : OnAction
    
    var body: some View {
        Button(action: {
            onMoreIconLongPress()
        }) {
            Image(systemName:"ellipsis.circle")
                .resizable()
                .scaledToFit().rotationEffect(Angle(degrees: 90))
                .frame(width: 24, height: 24)
                .foregroundColor(.black)
        }.onTapGesture {onMoreIconLongPress()}
            .contextMenu(shouldShowContextMenu  ? ContextMenu {
                Button {
                    onSave()
                } label: {
                    Label("Save", systemImage: "square.and.arrow.down.on.square.fill")
                }
                Button {
                    onSavedList()
                } label: {
                    Label("Saved List", systemImage: "list.bullet.clipboard")
                }
                Button {
                    onClearList()
                } label: {
                    Label("Clear Bookmarks", systemImage: "list.bullet.clipboard")
                }
                
                Button {
                    onClearCookiesAndRefresh()
                } label: {
                    Label("Clear Cookies & refresh", systemImage: "list.bullet.clipboard")
                }
            } : nil)
    }
}


struct MoreButton_Previews: PreviewProvider {
    static var previews: some View {
        MoreButton(shouldShowContextMenu: true) {
            
        } onSave: {
            
        } onSavedList: {
            
        } onClearList: {
            
        } onClearCookiesAndRefresh: {
            
        }

    }
}

