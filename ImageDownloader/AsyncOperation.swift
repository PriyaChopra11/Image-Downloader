//
//  AsyncOperation.swift
//  ImageDownloader
//
//  Created by Priya Chopra on 5/2/2020.
//  Copyright © 2020 Priya Chopra. All rights reserved.
//

import UIKit
/// Subclass of Operation
class AsyncOperation: Operation {
    /// Enum repersenting state of operation class
    enum State: String {
        case ready, executing, finished
        var keypath: String {
            return "is\(self.rawValue.capitalized)"
        }
    }
    /// State varibable is of type State ,its intial value is Ready .
    var state:State = .ready {
        willSet {
            willChangeValue(forKey: newValue.keypath)
            willChangeValue(forKey: state.keypath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keypath)
            didChangeValue(forKey: state.keypath)
        }
    }
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        main()
        state = .executing
    }
}
