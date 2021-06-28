//
//  Task.swift
//  TryFirestore
//
//  Created by Ramzy on 27/06/2021.
//

import Foundation

protocol Identifiable {
    var id: String? { get set }
}

struct Task: Codable, Identifiable {
    var id: String? = nil
    var title: String
    var description: String
    
    init(taskTitle: String,taskDescription: String) {
        self.title = taskTitle
        self.description = taskDescription
    }
}
