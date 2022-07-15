//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import SAPFoundation

public protocol ODataControlling {
    func configureOData(sapURLSession: SAPURLSession, serviceRoot: URL) throws
    func configureOData(sapURLSession: SAPURLSession, serviceRoot: URL, onboardingID: UUID) throws
    func openOfflineStore(synchronize: Bool, completionHandler: @escaping (Error?) -> Void)
}

public extension ODataControlling {
    func configureOData(sapURLSession _: SAPURLSession, serviceRoot _: URL) throws {
        // OnlineODataController will override this default implementation.
    }

    func configureOData(sapURLSession _: SAPURLSession, serviceRoot _: URL, onboardingID _: UUID) throws {
        // OfflineODataController will override this default implementation.
    }

    func openOfflineStore(synchronize _: Bool, completionHandler _: @escaping (Error?) -> Void) {
        // OfflineODataController will override this default implementation.
    }
}
