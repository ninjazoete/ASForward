//
//  ViewController.swift
//  ForwardExample
//
//  Created by Andrzej Spiess on 13/04/15.
//  Copyright (c) 2015 Sweaty Fingers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct Tokens {
        static var aToken : dispatch_once_t = 0;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = {print("After message\n")}
        let b = {print("Once message\n")}
        let c = {print("Async message\n")}
        
        a>>>forward_after(delay: 5, onQueue: dispatch_get_main_queue())
        b>>>forward_once(token: &Tokens.aToken, onQueue: dispatch_get_main_queue())
        b>>>forward_once(token: &Tokens.aToken, onQueue: dispatch_get_main_queue())
        c>>>forward_async(onQueue : dispatch_get_main_queue())
        
        // Inline closures
        ({print("inline with parenthesis\n")})>>>forward_async(onQueue: dispatch_get_main_queue());
        
        // Notice: the simicolor above is required if you want an inline closure without ().
        {print("inline without parenthesis\n")}>>>forward_async(onQueue: dispatch_get_main_queue())
    }
}

