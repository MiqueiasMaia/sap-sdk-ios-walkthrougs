//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import Foundation

public enum ESPMContainerCollectionType: CaseIterable {
    case purchaseOrderItems
    case salesOrderHeaders
    case products
    case salesOrderItems
    case customers
    case suppliers
    case stock
    case productCategories
    case productTexts
    case purchaseOrderHeaders

    public init?(rawValue: String) {
        guard let type = ESPMContainerCollectionType.allCases.first(where: { rawValue == $0.description }) else {
            return nil
        }
        self = type
    }

    public var description: String {
        switch self {
        case .purchaseOrderItems: return "PurchaseOrderItems"
        case .salesOrderHeaders: return "SalesOrderHeaders"
        case .products: return "Products"
        case .salesOrderItems: return "SalesOrderItems"
        case .customers: return "Customers"
        case .suppliers: return "Suppliers"
        case .stock: return "Stock"
        case .productCategories: return "ProductCategories"
        case .productTexts: return "ProductTexts"
        case .purchaseOrderHeaders: return "PurchaseOrderHeaders"
        }
    }
}
