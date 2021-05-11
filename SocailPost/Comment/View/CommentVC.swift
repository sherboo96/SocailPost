//
//  CommentVC.swift
//  SocailPost
//
//  Created by Mahmoud Sherbeny on 11/05/2021.
//

import UIKit
import RxSwift
import RxCocoa

class CommentVC: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var btnlike: UIButton!
    @IBOutlet weak var commentTableView: UITableView!
    
    
    //MARK: - Variables
    let disposeBag = DisposeBag()
    let viewModel = CommentViewModel()
    
    //MARK: - VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Comments"
        self.subscripationOnViewIndecator()
        self.registerNibCell()
        self.bindHideTableView()
        self.bindToGetAllPostVariable()
        self.fireGetPostRequest()
    }

    private func registerNibCell() {
        let nib = UINib(nibName: PostCell.identifier, bundle: nil)
        commentTableView.register(nib, forCellReuseIdentifier: PostCell.identifier)
    }

    //MARK: - Helper Function
    
    private func subscripationOnViewIndecator() {
        self.viewModel.loadingBehavior.subscribe(onNext: { isLoading in
            if isLoading {
                
            } else {
                
            }
        }).disposed(by: disposeBag)
    }
    
    private func bindHideTableView() {
        self.viewModel.isTableViewHiden.bind(to: self.commentTableView.rx.isHidden).disposed(by: disposeBag)
    }
    
    private func bindToGetAllPostVariable() {
        viewModel.getAllComment.bind(to: self.commentTableView.rx.items(cellIdentifier: PostCell.identifier, cellType: PostCell.self)) { row, comment, cell in
            cell.lblUserNumber.text = "\(comment.id ?? 0)"
            cell.viewUserImage.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.lblPostTitle.text = comment.name
            cell.lblPost.text = comment.body
        }.disposed(by: disposeBag)
    }
    
    private func fireGetPostRequest() {
        viewModel.getPostFromTheServer()
    }

}
