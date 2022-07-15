//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import Foundation
import SharedFmwk

public extension DynamicDestinationSelectionIntent {
    var selectedDestination: String {
        switch destination {
        case .eSPMContainer:
            return ODataContainerType.eSPMContainer.description
        default:
            return "NA"
        }
    }

    var selectedEntity: String {
        switch destination {
        case .eSPMContainer:
            if let validDestination = ESPMContainer,
               let value = ESPMContainerCollectionType(rawValue: validDestination.displayString)
            {
                return value.description
            } else {
                return "NA"
            }
        case .unknown:
            return "NA"
        }
    }
}
