//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import Foundation
import SAPCommon
import SAPFoundation

public class AuxiliaryOnboardingUtil {
    let logger = Logger.shared(named: "SAP.Widget.Onboarding")

    /// The key for storing the onboarding status
    public static let defaultStoringKey = "OnboardingStatus"

    public init() {}

    public func isWidgetInitialized() -> Bool {
        if UserDefaults.standard.bool(forKey: AuxiliaryOnboardingUtil.defaultStoringKey) {
            return true
        }

        let store = try! AuxiliaryConfiguration.getSharedStore()
        let communicationProvider = AuxiliaryCommunicationProvider(using: store)

        let onboardingStatus = try? communicationProvider.get(for: AuxiliaryConfiguration.onboardingStatusName)

        if onboardingStatus == nil {
            logger.info("App is not onboarded.")
            // remove data from store
            removeData()
            return false
        }
        try? communicationProvider.delete(for: AuxiliaryConfiguration.onboardingStatusName)
        UserDefaults.standard.set(true, forKey: AuxiliaryOnboardingUtil.defaultStoringKey)
        return true
    }

    public func removeData() {
        do {
            let store: KeychainStorage = try AuxiliaryConfiguration.getSharedStore() as! KeychainStorage
            try store.removeAllData()
        } catch {
            logger.error("Failed to remove data. Error: \(error)")
        }
    }
}
