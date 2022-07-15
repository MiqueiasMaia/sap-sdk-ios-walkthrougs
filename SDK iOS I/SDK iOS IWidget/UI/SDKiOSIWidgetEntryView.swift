//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import Foundation
import SwiftUI

struct SDKiOSIWidgetEntryView: View {
    var entry: WidgetIntentTimelineProvider.Entry
    var body: some View {
        ZStack {
            Color("bgColor")
            VStack {
                WidgetEntryView(data: entry.values,
                                title: entry.title,
                                listPath: entry.listPath)
            }
        }
    }
}
