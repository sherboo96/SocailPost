//
//  CommentViewModel.swift
//  SocailPost
//
//  Created by Mahmoud Sherbeny on 11/05/2021.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class CommentViewModel {
    private var commentsPublishSubject = PublishSubject<[CommentModel]>()
    var postID = BehaviorRelay<Int>(value: 0)
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    var isTableViewHiden = BehaviorRelay<Bool>(value: true)
    
    var getAllComment: Observable<[CommentModel]> {
        return commentsPublishSubject
    }
    
    func getPostFromTheServer() {
        loadingBehavior.accept(true)
        APIServices.instance.getData(url: "\(EndPoints.post.url)/\(postID.value)/comments", method: .get) { [weak self] (comment: [CommentModel]?, modelError: String?, error) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = error {
                print(error.localizedDescription)
            } else if let modelError = modelError {
                print(modelError)
            } else {
                guard let comment = comment else { return }
                if !comment.isEmpty {
                    self.commentsPublishSubject.onNext(comment)
                    self.isTableViewHiden.accept(false)
                } else {
                    self.isTableViewHiden.accept(true)
                }
            }
        }
    }
}
