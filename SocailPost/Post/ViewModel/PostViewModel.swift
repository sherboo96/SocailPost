//
//  PostViewModel.swift
//  SocailPost
//
//  Created by Mahmoud Sherbeny on 11/05/2021.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class PostViewModel {
    private var postsPublishSubject = PublishSubject<[PostModel]>()
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    var isTableViewHiden = BehaviorRelay<Bool>(value: true)
    
    var getAllPost: Observable<[PostModel]> {
        return postsPublishSubject
    }
    
    func getPostFromTheServer() {
        loadingBehavior.accept(true)
        APIServices.instance.getData(url: EndPoints.post.url, method: .get) { [weak self] (post: [PostModel]?, modelError: String?, error) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = error {
                print(error.localizedDescription)
                if RealmSevices.getData().count > 0 {
                    self.isTableViewHiden.accept(false)
                    self.postsPublishSubject.onNext(RealmSevices.getData())
                } else {
                    self.isTableViewHiden.accept(true)
                }
            } else if let modelError = modelError {
                print(modelError)
                if RealmSevices.getData().count > 0 {
                    self.isTableViewHiden.accept(false)
                    self.postsPublishSubject.onNext(RealmSevices.getData())
                } else {
                    self.isTableViewHiden.accept(true)
                }
            } else {
                guard let post = post else { return }
                if !post.isEmpty {
                    self.isTableViewHiden.accept(false)
                    RealmSevices.removeOldData()
                    RealmSevices.saveData(postModel: post)
                    self.postsPublishSubject.onNext(RealmSevices.getData())
                } else {
                    if RealmSevices.getData().count > 0 {
                        self.isTableViewHiden.accept(false)
                    } else {
                        self.isTableViewHiden.accept(true)
                    }
                }
            }
        }
    }
}
