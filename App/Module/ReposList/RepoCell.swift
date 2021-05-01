//
//  RepositoryCell.swift
//  GithubClient
//
//  Created by Yousef on 4/7/21.
//

import UIKit
import NetworkingFramework

class RepoCell: UITableViewCell {

    @IBOutlet private weak var avatarImgView: UIImageView!
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var ownerLbl: UILabel!
    
    override func prepareForReuse() {
        avatarImgView.image = nil
        avatarImgView.cancelImageLoad()
    }
    
    func configureCell(imgURL: String, name: String?, owner: String?) {
        avatarImgView.loadImage(fromUrl: URL(string:imgURL))
        nameLbl.text = name
        ownerLbl.text = owner
    }
    
}
