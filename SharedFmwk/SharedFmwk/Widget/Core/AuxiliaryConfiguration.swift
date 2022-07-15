//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import Foundation
import SAPCommon
import SAPFoundation

public enum AuxiliaryConfiguration {
    public static let scheme = "consulting.b2rise.SDK-iOS-I"
    public static let sharedStoreName = "SharedStoreName"
    public static let sharedAccessGroup = ""
    public static let widgetKind = "consulting.b2rise.SDK-iOS-I.widget"
    public static let backgroundStepsTaskId = "consulting.b2rise.SDK-iOS-I.backgroundstepsrefreshtask"
    public static let numberOfRecords = 4
    public static let onboardingStatusName = "OnboardingStatus"
    public static let cryptoProviderTag = Data("CryptoProviderTag".utf8)

    public static func getSharedStore(storeName: String = AuxiliaryConfiguration.sharedStoreName, accessGroup: String = AuxiliaryConfiguration.sharedAccessGroup) throws -> DataStoring {
        do {
            return try KeychainStorage.createStore(name: storeName, accessGroup: accessGroup)
        } catch KeychainStorageError.storeAlreadyExists {
            return try KeychainStorage.openStore(name: storeName, accessGroup: accessGroup)
        } catch {
            throw error
        }
    }

    public static func getConfiguredWidgetControllers() -> [String: WidgetControlling] {
        var widgetControllers: [String: WidgetControlling] = [:]

        widgetControllers[ODataContainerType.eSPMContainer.description] = ESPMContainerWidgetController()
        return widgetControllers
    }
}
