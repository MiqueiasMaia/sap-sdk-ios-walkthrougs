//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import Foundation
import WidgetKit

protocol WidgetConfigurationProviding {
    func kind() -> String
    func configurationDisplayName() -> String
    func description() -> String
    var supportedFamilies: [WidgetFamily] { get }
}
