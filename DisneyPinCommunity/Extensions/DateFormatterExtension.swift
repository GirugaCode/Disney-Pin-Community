//
//  DateFormatterExtension.swift
//  DisneyPinCommunity
//
//  Created by Ryan Nguyen on 3/22/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

extension Date {
    public func getFormattedDate(dateString: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date? = dateFormatterGet.date(from: dateString)
        print("Date",dateFormatterPrint.string(from: date!))
        return dateFormatterPrint.string(from: date!);
    }
}
