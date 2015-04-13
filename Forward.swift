//
//  Forward.swift
//  ASForward
//
//  Created by Andrzej Spiess on 12/04/15.
//  Copyright (c) 2015 Sweaty Fingers. All rights reserved.
//

import Foundation

// MARK: Base forwardable protocol which enforces forward_base subclasses to be able to forward
//       a given task using their own behaviours.

protocol forwardable {
    func forward(task : Void -> Void)
}

class forward_base {
    
    private let queue : dispatch_queue_t
    
    init(onQueue forwardQueue : dispatch_queue_t) {
        queue = forwardQueue;
    }
}

// MARK: Forward classes that encapsulate specific dispatch actions.

/* forward_async == dispatch_async */
class forward_async : forward_base, forwardable {
    
    func forward(task : Void -> Void) {
        dispatch_async(queue) {
            task()
        }
    }
}

/* forward_sync == dispatch_sync */
class forward_sync : forward_base, forwardable {
    
    func forward(task: Void -> Void) {
        dispatch_sync(queue) {
            task()
        }
    }
}

/* forward_after === dispatch_after */
class forward_after : forward_base, forwardable {
    
    private let delay : Double
    
    init(delay : Double, onQueue : dispatch_queue_t) {
        self.delay = delay
        super.init(onQueue: onQueue)
    }
    
    func forward(task: Void -> Void) {
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        
        dispatch_after(time, queue) {
            task()
        }
    }
}

/* forward_once === dispatch_once */
class forward_once : forward_base, forwardable {
    
    private let token : UnsafeMutablePointer<dispatch_once_t>
    
    init(token : UnsafeMutablePointer<dispatch_once_t>, onQueue : dispatch_queue_t) {
        self.token = token
        super.init(onQueue: onQueue)
    }
    
    func forward(task: Void -> Void) {
        dispatch_once(self.token) {
            task()
        }
    }
}

infix operator >>> {}

func >>> (forwardTask : Void -> Void, forwardOperation : forwardable) -> Void {
    forwardOperation.forward(forwardTask)
}


