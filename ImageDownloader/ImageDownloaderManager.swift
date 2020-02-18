//
//  ImageDownloaderManager.swift
//  ImageDownloader
//
//  Created by Priya Chopra on 6/2/2020.
//  Copyright © 2020 Priya Chopra. All rights reserved.
//

import UIKit

final class ImageDownloaderManager {
    /// shared instacne of ImageDownloaderManager class
   static var shared = ImageDownloaderManager()
    
   private let downloadQueue = OperationQueue.init()
    
    /// this variable is used to cache image with correspinding its url string
   let imageCache: NSCache = NSCache<NSString, UIImage>()
    
    /// Operations dictionary is to keep track ongoing operation with its corresponding url string
   private var ongoingOperations = [String:Operation]()
    
    /**
       This function is used to download image
       - Parameter urlString: URL corresponding to the image
       - Parameter completionBlock: Returns an image when network operation gets completed
    */
    func downloadImage(with urlString: String, completionBlock: @escaping (UIImage?) -> Void) {
        let networkOperation = NetworkImageOperation.init(urlString: urlString)
        self.ongoingOperations[urlString] = networkOperation
        
        networkOperation.completionBlock = { [weak self] in
            self?.ongoingOperations.removeValue(forKey: urlString)
            DispatchQueue.main.async {
                completionBlock(networkOperation.image)
            }
            if let imageCache = networkOperation.image {
                self?.imageCache.setObject(imageCache, forKey:(urlString as NSString))
            }
        }
        self.downloadQueue.addOperation(networkOperation)
    }
    
    /**
       This function is used to cancel image operation
       - Parameter urlString: URL corresponding to the image
    */
    func cancelImageOperation(urlString: String) {
        if let operation = ongoingOperations[urlString] {
            operation.cancel()
            self.ongoingOperations.removeValue(forKey: urlString)
        }
    }
}
