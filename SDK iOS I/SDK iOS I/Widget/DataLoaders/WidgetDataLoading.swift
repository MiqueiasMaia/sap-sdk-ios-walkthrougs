//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import Foundation
import SAPCommon
import SharedFmwk

/// Types which can provide data for widget
protocol WidgetDataLoading {
    init?(controller: ODataControlling, with cipher: Ciphering)
    func loadAllEntitySets(completionHandler: @escaping (Bool) -> Void)
    func loadEntitySet(for entity: String, completionHandler: @escaping (Bool) -> Void)
}
