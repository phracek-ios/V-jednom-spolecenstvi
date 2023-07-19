//
//  DateManager.swift
//  Svati
//
//  Created by Petr Hracek on 18.07.2023.
//

import Foundation
import UIKit

func get_month() -> Int {
    let date = Date()
    let calendar = Calendar.current
    return calendar.component(.month, from: date)
}

func get_day() -> Int {
    let date = Date()
    let calendar = Calendar.current
    return calendar.component(.day, from: date)
}
