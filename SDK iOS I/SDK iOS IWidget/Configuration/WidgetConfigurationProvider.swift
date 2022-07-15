//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import Foundation
import SAPFoundation
import SharedFmwk
import WidgetKit

class WidgetConfigurationProvider: WidgetConfigurationProviding {
    let auxStoreName: String = "AuxiliaryDataStore"
    let auxAccessGroup: String = ""
    let obfuscatedAuxiliaryKey: [UInt8] = [21, 83, 21, 86, 22, 94, 65, 22, 20, 39, 69, 29, 7, 39, 74, 59, 33, 28, 22, 39, 88, 77, 85, 83, 31, 25, 4, 37, 32, 26, 23, 54, 2, 1, 7, 49, 3, 68, 5, 95, 3, 45, 57, 73]

    func configurationDisplayName() -> String {
        "SDK iOS I Widget"
    }

    func description() -> String {
        "Get quick access to your entities."
    }

    func kind() -> String {
        AuxiliaryConfiguration.widgetKind
    }

    var supportedFamilies: [WidgetFamily] {
        [.systemLarge]
    }
}
