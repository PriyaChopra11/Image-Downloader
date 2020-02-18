//
//  NetworkImageOperation.swift
//  ImageDownloader
//
//  Created by Priya Chopra on 5/2/2020.
//  Copyright © 2020 Priya Chopra. All rights reserved.
//

import UIKit

final class NetworkImageOperation: AsyncOperation {
    
   private var dataTask: URLSessionDataTask?
    /// This variable returns downloaded Image
   var image: UIImage?
    /// URL corresponding to the image
   private var urlString: String
    
    init(urlString:String) {
        self.urlString = urlString
    }
    
    override func main() {
        imageDownloadRequest()
    }
    /// This function is to cancel ongoing the data task.
    override func cancel() {
           super.cancel()
           dataTask?.cancel()
   }
    /**
      This function is  to download image from server
    */
    private func imageDownloadRequest() {
        
        guard let url = URL.init(string: urlString) else {
            return
        }
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            
            defer {
                self?.state = .finished
            }
            if self!.isCancelled {
                return
            }
            
            guard error == nil, let data = data else {
                return
            }
            
            self?.image = UIImage.init(data: data)
        })
        dataTask?.resume()
    }
}

