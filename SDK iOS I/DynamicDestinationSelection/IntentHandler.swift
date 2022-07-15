//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        guard intent is DynamicDestinationSelectionIntent else {
            fatalError("Unhandled Intent error : \(intent)")
        }
        return DynamicDestinationSelectionIntentHandler()
    }
}
