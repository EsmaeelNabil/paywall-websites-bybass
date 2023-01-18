//
//  ContentView.swift
//  rmwall
//
//  Created by Esmaeel Nabil Mohamed Moustafa on 17.01.23.
//

import SwiftUI

typealias OnAction = ()  -> Void


struct ContentView: View {
    
    // ------------------   WebView -----------------------------------
    @State private var showWebView = false
    @State private var urlString: String = ""
    @State private var urlInput: String = ""
    // ------------------   History Sheet -----------------------------
    @State private var shouldShowMenu = false
    @State private var showHistorySheet = false
    // ------------------   history title input dialog -----------------------------
    @State private var titleInputText: String = ""
    @State private var showTitleInputDialog = false
    // ------------------   History Sheet -----------------------------
    
    
    var body: some View {
        
        
        
        handleUrlOnOpen.onAppear(){
            print(HistoryManager.getHistory() ?? [])
        }
        NavigationView {
            
            VStack {
                
                HStack {
       
                    
                    ClearButton(color: urlInput.isEmpty ? .black : .red) {
                        self.urlInput = ""
                        self.urlString = ""
                    }
                    
                    SearchInput
                    
                    SearchButton(
                        color: urlInput.isEmpty ? .black : .blue
                    ){
                        if !urlInput.isEmpty{
                            self.urlString = self.urlInput
                            showWebView = true
                        }else {
                            showWebView.toggle()
                        }
                    }
                    
                    MoreButton(
                        shouldShowContextMenu: shouldShowMenu,
                        onMoreIconLongPress: {
                            shouldShowMenu.toggle()
                        }, onSave: {
                            if !urlString.isEmpty {
                                self.showTitleInputDialog = true
                            }
                        }, onSavedList: {
                            showHistorySheet = true
                        }, onClearList: {
                            HistoryManager.clearHistory()
                        }, onClearCookiesAndRefresh: {
                            HistoryManager.clearCookies()
                        })
                    
                    Spacer(minLength: 16)
                    
                }.background(
                    RoundedRectangle(cornerRadius: 50).fill(Color(red: 0.9, green: 0.9, blue: 0.9))
                ).padding(.horizontal,24)
                
                
                
                if showWebView {
                    if !urlString.isEmpty {
                        WebView(url: URL(string: urlString)!)
                    }
                }
                
                //------------------------------------------------------------- history sheet -----------------------------------------------
            }.sheet(isPresented: $showHistorySheet) {
                List {
                    ForEach(HistoryManager.getHistory() ?? [], id: \.self) { item in
                        HStack {
                            Image(systemName: "globe")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .padding(.all, 10)
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.url)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }.contentShape(Rectangle())
                            .onTapGesture {
                                self.showHistorySheet = false
                                self.urlInput = item.url
                                self.urlString = item.url
                            }
                    }
                }
                
                //----------------------------------------------- title input sheet  -----------------------------------------------
            }.alert(Text("Enter a title for this website"), isPresented: $showTitleInputDialog, actions: {
                TextField("", text: self.$titleInputText)
                
                Button("Save", action: {
                    self.showTitleInputDialog = false
                    HistoryManager.appendHistory(item: HistoryItem(title: self.titleInputText, url: urlString))
                    self.titleInputText = ""
                })
                
                Button("Cancel",role: .cancel,action: {
                    self.showTitleInputDialog = false
                })
                               
            })
            
        }
    }
    
    
    var handleUrlOnOpen : some View {
        Spacer().onOpenURL{ url in
            urlString = url.absoluteString.replacingOccurrences(of: "ShareMedia://dataUrl=", with: "")
            showWebView = true
            print(urlString)
        }
    }
    
    
    var SearchInput : some View {
        TextField("Write OR Share URL from browser", text: $urlInput)
            .padding()
            .background(Color.accentColor.opacity(0))
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
