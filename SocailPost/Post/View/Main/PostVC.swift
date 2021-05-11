//
//  PostVC.swift
//  SocailPost
//
//  Created by Mahmoud Sherbeny on 11/05/2021.
//

import UIKit
import RxSwift
import RxCocoa
import KRProgressHUD

class PostVC: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var postTableView: UITableView! {
        didSet {
            self.postTableView.isHidden = true
        }
    }
    
    //MARK: - Variables
    let disposeBag = DisposeBag()
    let viewModel = PostViewModel()
    
    //MARK: - VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Posts"
        self.subscripationOnViewIndecator()
        self.registerNibCell()
        self.bindHideTableView()
        self.bindToGetAllPostVariable()
        self.fireGetPostRequest()
        self.subscribeOnCellTap()
    }

    private func registerNibCell() {
        let nib = UINib(nibName: PostCell.identifier, bundle: nil)
        postTableView.register(nib, forCellReuseIdentifier: PostCell.identifier)
    }

    //MARK: - Helper Function
    
    private func subscripationOnViewIndecator() {
        self.viewModel.loadingBehavior.subscribe(onNext: { isLoading in
            if isLoading {
                KRProgressHUD.show(withMessage: "Loading...")
            } else {
                KRProgressHUD.dismiss()
            }
        }).disposed(by: disposeBag)
    }
    
    private func bindHideTableView() {
        self.viewModel.isTableViewHiden.bind(to: self.postTableView.rx.isHidden).disposed(by: disposeBag)
    }
    
    private func bindToGetAllPostVariable() {
        viewModel.getAllPost.bind(to: self.postTableView.rx.items(cellIdentifier: PostCell.identifier, cellType: PostCell.self)) { row, post, cell in
            cell.lblUserNumber.text = "\(post.id ?? 0)"
            cell.lblPostTitle.text = post.title
            cell.lblPost.text = post.body
        }.disposed(by: disposeBag)
    }
    
    private func subscribeOnCellTap() {
        Observable.zip(postTableView.rx.itemSelected, postTableView.rx.modelSelected(PostModel.self)).bind { _, post in
            let VC = CommentVC()
            VC.viewModel.postID.accept(post.id ?? 0)
            self.navigationController?.pushViewController(VC, animated: true)
        }.disposed(by: disposeBag)
    }
    
    private func fireGetPostRequest() {
        viewModel.getPostFromTheServer()
    }
}
