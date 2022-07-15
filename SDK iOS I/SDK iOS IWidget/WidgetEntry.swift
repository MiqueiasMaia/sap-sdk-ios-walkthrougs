//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import Foundation
import UIKit
import WidgetKit

struct WidgetEntry: TimelineEntry {
    var date: Date
    let values: [WidgetRowViewModel]
    var title: String
    var listPath = ""

    init(date: Date = Date(),
         title: String,
         values: [WidgetRowViewModel])
    {
        self.date = date
        self.values = values
        self.title = title
    }
}
