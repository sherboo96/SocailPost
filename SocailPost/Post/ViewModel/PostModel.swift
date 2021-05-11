//
//  PostModel.swift
//  SocailPost
//
//  Created by Mahmoud Sherbeny on 11/05/2021.
//

import Foundation

struct PostModel: Codable {
    let userId : Int?
    let id : Int?
    let title : String?
    let body : String?

    enum CodingKeys: String, CodingKey {

        case userId = "userId"
        case id = "id"
        case title = "title"
        case body = "body"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        body = try values.decodeIfPresent(String.self, forKey: .body)
    }

    init(userId : Int, id : Int, title : String, body : String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}
