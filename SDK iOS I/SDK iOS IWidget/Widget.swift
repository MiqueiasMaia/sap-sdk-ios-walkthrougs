//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import SwiftUI
import WidgetKit

@main
struct SDKiOSIWidget: Widget {
    var widgetConfig = WidgetConfigurationProvider()
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: widgetConfig.kind(), intent: DynamicDestinationSelectionIntent.self, provider: WidgetIntentTimelineProvider()) { entry in
            SDKiOSIWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(widgetConfig.configurationDisplayName())
        .description(widgetConfig.description())
        .supportedFamilies(widgetConfig.supportedFamilies)
    }
}
