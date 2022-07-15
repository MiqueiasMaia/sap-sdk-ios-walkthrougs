//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import SAPCommon
import SAPFiori
import SAPFioriFlows
import SAPFoundation
import WebKit

import SharedFmwk

public class OnboardingFlowProvider: OnboardingFlowProviding {
    // MARK: – Properties

    public static let modalUIViewControllerPresenter = ModalUIViewControllerPresenter()
    public var runSynchingFlow = false

    // MARK: – Init

    public init() {}

    // MARK: – OnboardingFlowProvider

    public func flow(for _: OnboardingControlling, flowType: OnboardingFlow.FlowType, completionHandler: @escaping (OnboardingFlow?, Error?) -> Void) {
        switch flowType {
        case .onboard:
            completionHandler(onboardingFlow(), nil)
        case let .restore(onboardingID):
            completionHandler(restoringFlow(for: onboardingID), nil)
        case let .background(onboardingID):
            completionHandler(backgroundFlow(for: onboardingID), nil)
        case let .reset(onboardingID):
            completionHandler(resettingFlow(for: onboardingID), nil)
        case .resetPasscode:
            completionHandler(nil, nil)
        @unknown default:
            break
        }
    }

    // MARK: – Internal

    func onboardingFlow() -> OnboardingFlow {
        let steps = onboardingSteps
        let context = OnboardingContext(presentationDelegate: OnboardingFlowProvider.modalUIViewControllerPresenter)
        let flow = OnboardingFlow(flowType: .onboard, context: context, steps: steps)
        return flow
    }

    func restoringFlow(for onboardingID: UUID) -> OnboardingFlow {
        var steps = [OnboardingStep]()
        if runSynchingFlow {
            steps = offlineSyncingSteps
            runSynchingFlow = false
        } else {
            steps = restoringSteps
        }
        var context = OnboardingContext(onboardingID: onboardingID, presentationDelegate: OnboardingFlowProvider.modalUIViewControllerPresenter)
        context.onboardingID = onboardingID
        let flow = OnboardingFlow(flowType: .restore(onboardingID: onboardingID), context: context, steps: steps)
        return flow
    }

    func backgroundFlow(for onboardingID: UUID) -> OnboardingFlow {
        let steps = backgroundSteps
        var context = OnboardingContext(onboardingID: onboardingID, presentationDelegate: OnboardingFlowProvider.modalUIViewControllerPresenter)
        context.onboardingID = onboardingID
        let flow = OnboardingFlow(flowType: .background(onboardingID: onboardingID), context: context, steps: steps)
        return flow
    }

    func resettingFlow(for onboardingID: UUID) -> OnboardingFlow {
        let steps = resettingSteps
        var context = OnboardingContext(onboardingID: onboardingID, presentationDelegate: OnboardingFlowProvider.modalUIViewControllerPresenter)
        context.onboardingID = onboardingID
        let flow = OnboardingFlow(flowType: .reset(onboardingID: onboardingID), context: context, steps: steps)
        return flow
    }

    func getAPIKeyAuthenticationConfig() -> APIKeyAuthenticationConfig? {
        let obfuscator: Obfuscating = Obfuscator()
        let key = obfuscator.deobfuscate([80, 80, 4, 0, 77, 90, 21, 55, 76, 9, 69, 84, 82, 75, 85, 66, 8, 21, 126, 88, 9, 17, 87, 72, 0, 86, 23, 88, 69, 53, 2, 84, 23, 85, 83, 94])
        return APIKeyAuthenticationConfig(apikeys: [key], isAPIKeyAccessOnly: false, allowAnonymousAccessFlag: true)
    }

    // MARK: - Steps

    public var onboardingSteps: [OnboardingStep] {
        return [
            configuredWelcomeScreenStep(),
            CompositeStep(steps: SAPcpmsDefaultSteps.configuration),
            OAuth2AuthenticationStep(presenter: FioriWKWebViewPresenter(webViewDelegate: self)),
            CompositeStep(steps: SAPcpmsDefaultSteps.settingsDownload),
            CompositeStep(steps: SAPcpmsDefaultSteps.applyDuringOnboard),
            configuredUserConsentStep(),
            configuredDataCollectionConsentStep(),
            configuredStoreManagerStep(),

            ODataOnboardingStep(),
            AuxiliaryCommunicationStep(),
        ]
    }

    public var restoringSteps: [OnboardingStep] {
        return [
            configuredStoreManagerStep(),
            configuredWelcomeScreenStep(),
            CompositeStep(steps: SAPcpmsDefaultSteps.configuration),
            OAuth2AuthenticationStep(presenter: FioriWKWebViewPresenter(webViewDelegate: self)),
            CompositeStep(steps: SAPcpmsDefaultSteps.settingsDownload),
            CompositeStep(steps: SAPcpmsDefaultSteps.applyDuringRestore),
            configuredDataCollectionConsentStep(),
            ODataOnboardingStep(),
        ]
    }

    public var backgroundSteps: [OnboardingStep] {
        return [
            configuredStoreManagerStep(),
            configuredWelcomeScreenStep(),
            CompositeStep(steps: SAPcpmsDefaultSteps.configuration),
            OAuth2AuthenticationStep(presenter: FioriWKWebViewPresenter(webViewDelegate: self)),
            AuxiliaryCommunicationStep(),
        ]
    }

    public var offlineSyncingSteps: [OnboardingStep] {
        return [
            configuredWelcomeScreenStep(),
            CompositeStep(steps: SAPcpmsDefaultSteps.settingsDownload),
            CompositeStep(steps: SAPcpmsDefaultSteps.applyDuringRestore),
        ]
    }

    public var resettingSteps: [OnboardingStep] {
        return onboardingSteps
    }

    // MARK: – Step configuration

    private func configuredWelcomeScreenStep() -> WelcomeScreenStep {
        let appParameters = FileConfigurationProvider("AppParameters").provideConfiguration().configuration
        let destinations = appParameters["Destinations"] as! NSDictionary
        let discoveryConfigurationTransformer = DiscoveryServiceConfigurationTransformer(applicationID: appParameters["Application Identifier"] as? String, authenticationPath: destinations["ESPMContainer"] as? String)
        let welcomeScreenStep = WelcomeScreenStep(transformer: discoveryConfigurationTransformer, providers: [FileConfigurationProvider()])

        welcomeScreenStep.welcomeScreenCustomizationHandler = { welcomeStepUI in
            welcomeStepUI.headlineLabel.text = "SDK iOS I"
            welcomeStepUI.detailLabel.text = NSLocalizedString("keyWelcomeScreenMessage", value: "This application was generated by SAP BTP SDK Assistant for iOS" + " v7.0.7", comment: "XMSG: Message on WelcomeScreen")
            welcomeStepUI.primaryActionButton.titleLabel?.text = NSLocalizedString("keyWelcomeScreenStartButton", value: "Start", comment: "XBUT: Title of start button on WelcomeScreen")

            if let welcomeScreen = welcomeStepUI as? FUIWelcomeScreen {
                // Configuring WelcomeScreen to prefill the email domain

                welcomeScreen.emailTextField.text = "user@"
            }
        }

        return welcomeScreenStep
    }

    private func configuredUserConsentStep() -> UserConsentStep {
        let actionTitle = "Learn more about Data Privacy"
        let actionUrl = "https://www.sap.com/corporate/en/legal/privacy.html"
        let singlePageTitle = "Data Privacy"
        let singlePageText = "Detailed text about how data privacy pertains to this app and why it is important for the user to enable this functionality"

        var singlePageContent = UserConsentPageContent()
        singlePageContent.actionTitle = actionTitle
        singlePageContent.actionUrl = actionUrl
        singlePageContent.title = singlePageTitle
        singlePageContent.body = singlePageText
        let singlePageFormContent = UserConsentFormContent(version: "1.0", isRequired: true, pages: [singlePageContent])

        return UserConsentStep(userConsentFormsContent: [singlePageFormContent])
    }

    private func configuredDataCollectionConsentStep() -> DataCollectionConsentStep {
        return DataCollectionConsentStep()
    }

    private func configuredStoreManagerStep() -> StoreManagerStep {
        let step = StoreManagerStep()
        step.defaultPasscodePolicy = nil
        step.runRestoreIfStoreExists = true
        step.auxiliaryParameters = getAuxiliaryParameters()
        return step
    }

    func getAuxiliaryParameters() -> AuxiliaryParameters {
        let obfuscatedPrimaryKey: [UInt8] = [80, 14, 54, 48, 47, 27, 65, 17, 27, 39, 18, 5, 50, 94, 34, 24, 2, 0, 7, 41, 7, 95, 33, 80, 2, 41, 31, 28, 61, 33, 88, 13, 69, 83, 17, 94, 9, 23, 29, 67, 4, 34, 7, 73]
        let apiKeyAuthenticationConfig: APIKeyAuthenticationConfig? = getAPIKeyAuthenticationConfig()
        let dataStore = try! AuxiliaryConfiguration.getSharedStore()
        let auxDataRequestManager: AuxiliaryDataRequestManager? = try? AuxiliaryDataRequestManager(dataStore: dataStore)
        let dataContainer: AuxiliaryDataRequest<WidgetDataKey>? = try? auxDataRequestManager?.getDataRequest()
        let eSPAKAuxiliary: Data? = dataContainer?.eSPAKAuxiliary
        let onboardingStatusName: String = AuxiliaryConfiguration.onboardingStatusName
        return AuxiliaryParameters(sharedStoreName: AuxiliaryConfiguration.sharedStoreName, sharedAccessGroup: AuxiliaryConfiguration.sharedAccessGroup, obfuscatedPrimaryKey: obfuscatedPrimaryKey, eSPAKAuxiliary: eSPAKAuxiliary, apiKeyAuthenicationConfig: apiKeyAuthenticationConfig, onboardingStatusName: onboardingStatusName)
    }
}

// MARK: - SAPWKNavigationDelegate

// The WKWebView occasionally returns an NSURLErrorCancelled error if a redirect happens too fast.
// In case of OAuth with SAP's identity provider (IDP) we do not treat this as an error.
extension OnboardingFlowProvider: SAPWKNavigationDelegate {
    public func webView(_: WKWebView, handleFailed _: WKNavigation!, withError error: Error) -> Error? {
        if isCancelledError(error) {
            return nil
        }
        return error
    }

    public func webView(_: WKWebView, handleFailedProvisionalNavigation _: WKNavigation!, withError error: Error) -> Error? {
        if isCancelledError(error) {
            return nil
        }
        return error
    }

    private func isCancelledError(_ error: Error) -> Bool {
        let nsError = error as NSError
        return nsError.domain == NSURLErrorDomain &&
            nsError.code == NSURLErrorCancelled
    }
}
