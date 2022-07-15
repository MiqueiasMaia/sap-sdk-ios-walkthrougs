//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import Foundation

public class WidgetDataKey: Codable & Hashable {
    private var _destinationName: String
    private var _entityName: String

    public init(destinationName: String, entityName: String) {
        _entityName = entityName
        _destinationName = destinationName
    }

    public var destinationName: String {
        return _destinationName
    }

    public var entityName: String {
        return _entityName
    }

    public func getPrimaryKey() -> String {
        return destinationName + ":" + entityName
    }

    public static func == (lhs: WidgetDataKey, rhs: WidgetDataKey) -> Bool {
        if lhs.getPrimaryKey() == rhs.getPrimaryKey() {
            return true
        } else {
            return false
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(getPrimaryKey())
    }
}
