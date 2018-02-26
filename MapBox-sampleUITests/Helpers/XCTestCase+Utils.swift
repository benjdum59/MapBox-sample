//
//  File.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 26/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import XCTest

import Foundation

typealias ErrorCompletionHandler = (NSError) -> Void
var defaultTimeout = 30.0

extension XCTestCase {
    func waitForPredicate(_ predicate:NSPredicate, onObject:AnyObject, timeout:TimeInterval = defaultTimeout)->Bool {
        var noError = true
        self.expectation(for: predicate, evaluatedWith: onObject, handler: nil)
        self.waitForExpectations(timeout: timeout, handler: {(error) in
            noError = (error == nil)
        })
        return noError
    }
    
    func waitForObjectExists(_ object:AnyObject, timeout:TimeInterval = defaultTimeout)->Bool{
        let existPredicate = NSPredicate(format: "exists == 1")
        return self.waitForPredicate(existPredicate, onObject: object, timeout: timeout)
    }
    
    func wait(_ secs:Double = 4, reason:String? = nil){
        RunLoop.current.run(mode: RunLoopMode.defaultRunLoopMode, before: Date(timeIntervalSinceNow: secs))
    }
}
