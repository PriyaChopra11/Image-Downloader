//
//  Extension+UIImageView.swift
//  ImageDownloader
//
//  Created by Priya Chopra on 6/2/2020.
//  Copyright © 2020 Priya Chopra. All rights reserved.
//

import UIKit

extension UIImageView {
    /**
        This function is used to download image
        - Parameter urlString: URL corresponding to the image
     */
  public func downloadImage(with urlString: String) {
        if !getImageFromCache(urlString: urlString) {
            ImageDownloaderManager.shared.downloadImage(with: urlString) {
                image in
                guard let downloadedImage = image else {
                    return
                }
                self.image = downloadedImage
            }
        }
    }
    
    /**
       This function is used to cancel the downloaded image
       - Parameter urlString: URL corresponding to the cancel image
       - Remark: This function is used to cancel the downloading of image that are not required at that time.
    */
   public func cancelDownloadImage(with urlString: String) {
        ImageDownloaderManager.shared.cancelImageOperation(urlString: urlString)
    }
    
    private func getImageFromCache(urlString: String) -> Bool {
        if let imageCache =  ImageDownloaderManager.shared.imageCache.object(forKey: urlString as NSString) {
            self.image = imageCache
            return true
        } else {
            return false
        }
    }
}
