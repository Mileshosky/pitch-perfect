//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Britt Mileshosky on 5/11/15.
//  Copyright (c) 2015 Britt Mileshosky. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(path filePath: NSURL, title t: String) {
        filePathUrl = filePath
        title = t
    }
    
}