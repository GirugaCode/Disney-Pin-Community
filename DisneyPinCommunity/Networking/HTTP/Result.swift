//
//  Result.swift
//  DisneyPinCommunity
//
//  Created by Ryan Nguyen on 3/19/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

/*
Determines Sucess or Failure for URLSessions
 */

import Foundation

enum Result<T> {
    
    case success(T)
    case failure(Error)
    
}
