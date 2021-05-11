//
//  PostRealmObject.swift
//  SocailPost
//
//  Created by Mahmoud Sherbeny on 11/05/2021.
//

import Foundation
import RealmSwift

class PostRealmObject: Object {
    @objc dynamic var postID = 0
    @objc dynamic var userId = 0
    @objc dynamic var title = ""
    @objc dynamic var body = ""
    
    override static func primaryKey() -> String? {
        return "postID"
    }
}

class RealmSevices {
    
    public static var instance = RealmSevices()
    public static let realm = try! Realm()
    
    class func removeOldData() {
        RealmSevices.realm.beginWrite()
        RealmSevices.realm.delete(realm.objects(PostRealmObject.self))
        try! RealmSevices.realm.commitWrite()
    }
    
    class func saveData(postModel: [PostModel]) {
        for item in postModel{
            let post = PostRealmObject()
            post.postID = item.id ?? 0
            post.userId = item.userId ?? 0
            post.title = item.title ?? ""
            post.body = item.body ?? ""
            realm.beginWrite()
            realm.add(post)
            try! realm.commitWrite()
        }
    }
    
    class func getData() -> [PostModel] {
        var postModel = [PostModel]()
        let realm = try! Realm()
        let posts = realm.objects(PostRealmObject.self)
        for item in posts {
            postModel.append(PostModel(userId: item.userId, id: item.postID, title: item.title, body: item.body))
        }
        return postModel
    }
}
