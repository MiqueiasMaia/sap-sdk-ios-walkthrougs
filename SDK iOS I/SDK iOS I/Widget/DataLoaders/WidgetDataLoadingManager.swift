//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import Foundation
import SAPCommon
import SAPOData
import SharedFmwk

public class WidgetDataLoadingManager {
    private let logger = Logger.shared(named: "WidgetDataLoadingManager")
    private let widgetDataLoaders: [String: WidgetDataLoading]

    init(widgetDataLoaders: [String: WidgetDataLoading]) {
        self.widgetDataLoaders = widgetDataLoaders
    }

    func loadEntitySet(from destinationName: String, entityName: String, completionHandler: @escaping (Bool) -> Void) {
        guard !destinationName.isEmpty, !entityName.isEmpty, !widgetDataLoaders.isEmpty else {
            logger.info("Cannot load empty values!")
            completionHandler(false)
            return
        }

        if let dataProvider = widgetDataLoaders[destinationName] {
            dataProvider.loadEntitySet(for: entityName) { result in
                switch result {
                case true:
                    self.logger.info("EntitySet \(entityName) loaded successfully")
                case false:
                    self.logger.info("EntitySet \(entityName) load failed")
                }
                completionHandler(result)
            }
        } else {
            logger.info("No widget data loader found for: \(destinationName)")
            completionHandler(false)
        }
    }

    func loadAllEntitySets(completionHandler: @escaping (Bool) -> Void) {
        guard !widgetDataLoaders.isEmpty else {
            logger.info("Cannot load empty values!")
            completionHandler(false)
            return
        }

        let workerQ = DispatchQueue(label: "com.sap.WidgetDataLoadingManager-getAllDataQueue")
        workerQ.async {
            print("Starting fetch for all WidgetDataProviders")
            for (_, dataLoader) in self.widgetDataLoaders {
                dataLoader.loadAllEntitySets { result in
                    switch result {
                    case true:
                        print("leave called for: \(dataLoader)")
                    case false:
                        // Do nothing, since we're not passing failure from widget data loaders
                        break
                    }
                }
            }
            completionHandler(true)
        }
    }
}
