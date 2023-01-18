//
//  HistoryManager.swift
//  rmwall
//
//  Created by Esmaeel Nabil Mohamed Moustafa on 18.01.23.
//

import Foundation
import CoreData

struct HistoryItem: Hashable, Encodable, Decodable {
    var title: String
    var url: String
}

class HistoryManager {
    
    static func appendHistory(item: HistoryItem) {
        var items = getHistory() ?? []
        items.append(item)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "items")
        }
    }
    
    static func getHistory() -> [HistoryItem]? {
           let defaults = UserDefaults.standard
           if let data = defaults.data(forKey: "items"), let items = try? JSONDecoder().decode([HistoryItem].self, from: data) {
               return items
           }
           return nil
       }

    static func clearHistory() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "items")
        defaults.synchronize()
    }
}
