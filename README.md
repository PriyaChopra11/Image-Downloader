# Image Downloaded Library

**Image Downloaded Library** is a cocoa framework which provides an functions to download image from server. User can use this library to download image from with minimum lines of code.

## Features
-  Thread Safe
-  Async Image Download
-  In Memory Cache
-  Easy Implementation via downloadImage function provided through UIImageView Extension
-  Easily cancel the operation

## Usage

1. Import the ImageDownloader Library

```swift

import ImageDownloader 
 
```
2.  To download Image 

```swift

 imageView.downloadImage(with: urlString) 

```
3. To cancel download

```swift

  imageView.cancelDownloadImage(with: urlString) 

```

