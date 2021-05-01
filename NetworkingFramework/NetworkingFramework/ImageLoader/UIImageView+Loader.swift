//
//  UIImageView+Loader.swift
//  GithubClient
//
//  Created by Yousef on 4/7/21.
//

import UIKit

public extension UIImageView {
    
    ///Sets image for given url from cache, if not found image will be downloaded
    func loadImage(fromUrl url: URL?, defaultImage: UIImage? = nil) {
        guard let urlObject = url else {
            print("Error fetching Image from URL: \(url!)")
            self.image = defaultImage
            return
        }
      UIImageLoader.loader.load(urlObject, for: self)
    }

    ///Cancels current loading task
    func cancelImageLoad() {
      UIImageLoader.loader.cancel(for: self)
    }

}
