//
//  Network.swift
//  SocailPost
//
//  Created by Mahmoud Sherbeny on 11/05/2021.
//

import Foundation

enum EndPoints: String {
    case post = "posts"
    
    var url: String {
        return "https://jsonplaceholder.typicode.com/\(self.rawValue)"
    }
}

