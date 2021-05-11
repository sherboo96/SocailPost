//
//  PostCell.swift
//  SocailPost
//
//  Created by Mahmoud Sherbeny on 11/05/2021.
//

import UIKit

class PostCell: UITableViewCell {

    static let identifier = "PostCell"
    
    @IBOutlet weak var lblPostTitle: UILabel!
    @IBOutlet weak var lblPost: UILabel!
    @IBOutlet weak var lblUserNumber: UILabel!
    @IBOutlet weak var viewUserImage: UIView! {
        didSet {
            self.viewUserImage.layer.cornerRadius = self.viewUserImage.frame.height / 2
        }
    }
    
}
