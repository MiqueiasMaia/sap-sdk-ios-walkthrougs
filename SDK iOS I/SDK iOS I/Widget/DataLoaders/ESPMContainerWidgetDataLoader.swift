//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import Foundation
import SAPCommon
import SAPOData

import ESPMContainerFmwk
import SAPOfflineOData
import SharedFmwk

class ESPMContainerWidgetDataLoader: WidgetDataLoading {
    private let dataService: ESPMContainer<OfflineODataProvider>!
    private let widgetController: ESPMContainerWidgetController
    private let logger = Logger.shared(named: "ESPMContainerWidgetDataLoader")

    required init?(controller: ODataControlling, with cipher: Ciphering) {
        dataService = (controller as! ESPMContainerOfflineODataController).dataService
        widgetController = ESPMContainerWidgetController()
        do {
            try widgetController.configure(with: cipher)
            logger.info("ESPMContainerWidgetDataLoader initialised successfully!")
        } catch {
            logger.info("ESPMContainerWidgetDataLoader initialisation failed due to error: \(error)")
            return nil
        }
    }

    func loadAllEntitySets(completionHandler: @escaping (Bool) -> Void) {
        ESPMContainerCollectionType.allCases.forEach { entity in
            loadEntitySet(for: entity.description) { result in
                switch result {
                case true:
                    self.logger.info("EntitySet \(entity) loaded successfully")
                case false:
                    self.logger.info("EntitySet \(entity) load failed")
                }
            }
        }
        completionHandler(true)
    }

    func loadEntitySet(for entity: String, completionHandler: @escaping (Bool) -> Void) {
        guard let entityEnum = ESPMContainerCollectionType(rawValue: entity) else {
            logger.info("Cannot convert \(entity) to ESPMContainerCollectionType type")
            completionHandler(false)
            return
        }

        switch entityEnum {
        case .purchaseOrderItems:
            let query = DataQuery().selectAll().top(AuxiliaryConfiguration.numberOfRecords)
            dataService.fetchPurchaseOrderItems(matching: query) { res, err in
                guard err == nil else {
                    self.logger.error("EntitySet \(entityEnum.description) retrieval failed with error : \(err!)")
                    completionHandler(false)
                    return
                }

                guard let result = res else {
                    self.logger.error("No result obtained for entitySet \(entityEnum.description)")
                    completionHandler(false)
                    return
                }

                if (try? self.widgetController.put(list: result, forKey: entityEnum.description)) != nil {
                    self.logger.info("EntitySet \(entityEnum.description) loaded successfully")
                    completionHandler(true)
                } else {
                    self.logger.error("EntitySet \(entityEnum.description) storing failed")
                    completionHandler(false)
                }
            }

        case .salesOrderHeaders:
            let query = DataQuery().selectAll().top(AuxiliaryConfiguration.numberOfRecords)
            dataService.fetchSalesOrderHeaders(matching: query) { res, err in
                guard err == nil else {
                    self.logger.error("EntitySet \(entityEnum.description) retrieval failed with error : \(err!)")
                    completionHandler(false)
                    return
                }

                guard let result = res else {
                    self.logger.error("No result obtained for entitySet \(entityEnum.description)")
                    completionHandler(false)
                    return
                }

                if (try? self.widgetController.put(list: result, forKey: entityEnum.description)) != nil {
                    self.logger.info("EntitySet \(entityEnum.description) loaded successfully")
                    completionHandler(true)
                } else {
                    self.logger.error("EntitySet \(entityEnum.description) storing failed")
                    completionHandler(false)
                }
            }

        case .products:
            let query = DataQuery().selectAll().top(AuxiliaryConfiguration.numberOfRecords)
            dataService.fetchProducts(matching: query) { res, err in
                guard err == nil else {
                    self.logger.error("EntitySet \(entityEnum.description) retrieval failed with error : \(err!)")
                    completionHandler(false)
                    return
                }

                guard let result = res else {
                    self.logger.error("No result obtained for entitySet \(entityEnum.description)")
                    completionHandler(false)
                    return
                }

                if (try? self.widgetController.put(list: result, forKey: entityEnum.description)) != nil {
                    self.logger.info("EntitySet \(entityEnum.description) loaded successfully")
                    completionHandler(true)
                } else {
                    self.logger.error("EntitySet \(entityEnum.description) storing failed")
                    completionHandler(false)
                }
            }

        case .salesOrderItems:
            let query = DataQuery().selectAll().top(AuxiliaryConfiguration.numberOfRecords)
            dataService.fetchSalesOrderItems(matching: query) { res, err in
                guard err == nil else {
                    self.logger.error("EntitySet \(entityEnum.description) retrieval failed with error : \(err!)")
                    completionHandler(false)
                    return
                }

                guard let result = res else {
                    self.logger.error("No result obtained for entitySet \(entityEnum.description)")
                    completionHandler(false)
                    return
                }

                if (try? self.widgetController.put(list: result, forKey: entityEnum.description)) != nil {
                    self.logger.info("EntitySet \(entityEnum.description) loaded successfully")
                    completionHandler(true)
                } else {
                    self.logger.error("EntitySet \(entityEnum.description) storing failed")
                    completionHandler(false)
                }
            }

        case .customers:
            let query = DataQuery().selectAll().top(AuxiliaryConfiguration.numberOfRecords)
            dataService.fetchCustomers(matching: query) { res, err in
                guard err == nil else {
                    self.logger.error("EntitySet \(entityEnum.description) retrieval failed with error : \(err!)")
                    completionHandler(false)
                    return
                }

                guard let result = res else {
                    self.logger.error("No result obtained for entitySet \(entityEnum.description)")
                    completionHandler(false)
                    return
                }

                if (try? self.widgetController.put(list: result, forKey: entityEnum.description)) != nil {
                    self.logger.info("EntitySet \(entityEnum.description) loaded successfully")
                    completionHandler(true)
                } else {
                    self.logger.error("EntitySet \(entityEnum.description) storing failed")
                    completionHandler(false)
                }
            }

        case .suppliers:
            let query = DataQuery().selectAll().top(AuxiliaryConfiguration.numberOfRecords)
            dataService.fetchSuppliers(matching: query) { res, err in
                guard err == nil else {
                    self.logger.error("EntitySet \(entityEnum.description) retrieval failed with error : \(err!)")
                    completionHandler(false)
                    return
                }

                guard let result = res else {
                    self.logger.error("No result obtained for entitySet \(entityEnum.description)")
                    completionHandler(false)
                    return
                }

                if (try? self.widgetController.put(list: result, forKey: entityEnum.description)) != nil {
                    self.logger.info("EntitySet \(entityEnum.description) loaded successfully")
                    completionHandler(true)
                } else {
                    self.logger.error("EntitySet \(entityEnum.description) storing failed")
                    completionHandler(false)
                }
            }

        case .stock:
            let query = DataQuery().selectAll().top(AuxiliaryConfiguration.numberOfRecords)
            dataService.fetchStock(matching: query) { res, err in
                guard err == nil else {
                    self.logger.error("EntitySet \(entityEnum.description) retrieval failed with error : \(err!)")
                    completionHandler(false)
                    return
                }

                guard let result = res else {
                    self.logger.error("No result obtained for entitySet \(entityEnum.description)")
                    completionHandler(false)
                    return
                }

                if (try? self.widgetController.put(list: result, forKey: entityEnum.description)) != nil {
                    self.logger.info("EntitySet \(entityEnum.description) loaded successfully")
                    completionHandler(true)
                } else {
                    self.logger.error("EntitySet \(entityEnum.description) storing failed")
                    completionHandler(false)
                }
            }

        case .productCategories:
            let query = DataQuery().selectAll().top(AuxiliaryConfiguration.numberOfRecords)
            dataService.fetchProductCategories(matching: query) { res, err in
                guard err == nil else {
                    self.logger.error("EntitySet \(entityEnum.description) retrieval failed with error : \(err!)")
                    completionHandler(false)
                    return
                }

                guard let result = res else {
                    self.logger.error("No result obtained for entitySet \(entityEnum.description)")
                    completionHandler(false)
                    return
                }

                if (try? self.widgetController.put(list: result, forKey: entityEnum.description)) != nil {
                    self.logger.info("EntitySet \(entityEnum.description) loaded successfully")
                    completionHandler(true)
                } else {
                    self.logger.error("EntitySet \(entityEnum.description) storing failed")
                    completionHandler(false)
                }
            }

        case .productTexts:
            let query = DataQuery().selectAll().top(AuxiliaryConfiguration.numberOfRecords)
            dataService.fetchProductTexts(matching: query) { res, err in
                guard err == nil else {
                    self.logger.error("EntitySet \(entityEnum.description) retrieval failed with error : \(err!)")
                    completionHandler(false)
                    return
                }

                guard let result = res else {
                    self.logger.error("No result obtained for entitySet \(entityEnum.description)")
                    completionHandler(false)
                    return
                }

                if (try? self.widgetController.put(list: result, forKey: entityEnum.description)) != nil {
                    self.logger.info("EntitySet \(entityEnum.description) loaded successfully")
                    completionHandler(true)
                } else {
                    self.logger.error("EntitySet \(entityEnum.description) storing failed")
                    completionHandler(false)
                }
            }

        case .purchaseOrderHeaders:
            let query = DataQuery().selectAll().top(AuxiliaryConfiguration.numberOfRecords)
            dataService.fetchPurchaseOrderHeaders(matching: query) { res, err in
                guard err == nil else {
                    self.logger.error("EntitySet \(entityEnum.description) retrieval failed with error : \(err!)")
                    completionHandler(false)
                    return
                }

                guard let result = res else {
                    self.logger.error("No result obtained for entitySet \(entityEnum.description)")
                    completionHandler(false)
                    return
                }

                if (try? self.widgetController.put(list: result, forKey: entityEnum.description)) != nil {
                    self.logger.info("EntitySet \(entityEnum.description) loaded successfully")
                    completionHandler(true)
                } else {
                    self.logger.error("EntitySet \(entityEnum.description) storing failed")
                    completionHandler(false)
                }
            }

        default:
            completionHandler(false)
        }
    }
}
