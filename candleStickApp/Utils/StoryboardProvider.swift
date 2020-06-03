//
//  StoryboardProvider.swift
//  candleStickApp
//
//  Created by Pavel Terziyski on 31.05.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import UIKit

enum StoryboardType: Int {
   case main
}

private extension StoryboardType {
    var id: String {
        switch self {
        case .main:
            return "Main"
        }
    }
}

 public class StoryboardProvider: NSObject {
    static func getStoryboard(of type: StoryboardType) -> UIStoryboard {
        return UIStoryboard(name: type.id, bundle: Bundle(for: self))
    }
}

