//
//  Helper.swift
//  Week1_Flicks
//
//  Created by Edwin Wong on 10/17/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import Foundation
import AFNetworking

class Helper{
    static func loadImageHelper(imageView: UIImageView, imageUrl:URL){
        let imageRequest = URLRequest(url: imageUrl)
        
        imageView.setImageWith(
            imageRequest,
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) -> Void in
                
                // imageResponse will be nil if the image is cached
                if imageResponse != nil {
                    // Image was NOT cached, fade in image
                    imageView.alpha = 0.0
                    imageView.image = image
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        imageView.alpha = 1.0
                    })
                } else {
                    // Image was cached so just update the image"
                    imageView.image = image
                }
            },
            failure: { (imageRequest, imageResponse, error) -> Void in
                // do something for the failure condition
        })
    }
}
