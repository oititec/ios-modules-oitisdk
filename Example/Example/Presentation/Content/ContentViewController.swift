//
//  ContentViewController.swift
//  Example
//

import OitiSDK
import UIKit

final class ContentViewController: UIViewController {
    var appKey = "APP_KEY"

    private let customView = ContentView()

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        configureElements()
    }

    private func configureElements() {
        customView.defaultButton.addTarget(self, action: #selector(defaultJourney), for: .touchUpInside)
        customView.customAppearanceButton.addTarget(self, action: #selector(customAppearanceJourney), for: .touchUpInside)
        customView.customViewsButton.addTarget(self, action: #selector(customViewsJourney), for: .touchUpInside)
    }

    @objc
    private func defaultJourney() {
        createJourney(with: IProovCustomization.builder().build())
    }

    @objc
    private func customAppearanceJourney() {
        let customization = IProovCustomization.builder()
            .setInstructionCustomization { instructionBuilder in
                instructionBuilder
                    .setBackgroundColor(.purple)
                    .setBackButtonIcon(UIImage(systemName: "trash") ?? UIImage())
                    .setBackButtonColor(forContent: .red, background: .green, border: .white)
                    .setContextImage(UIImage(systemName: "person") ?? UIImage())
                    .setBottomSheetColor(.cyan)
                    .setBottomSheetCornerRadius(10)
                    .setTitleText(
                        "Titulo aqui",
                        color: .brown
                    )
                    .setCaptionText(
                        "Subtitulo aqui",
                        color: .systemPink
                    )
                    .setFirstInstructionIcon(UIImage(systemName: "star") ?? UIImage())
                    .setFirstInstructionTitleText(
                        "Descrição do ambiente",
                        color: .darkGray
                    )
                    .setSecondInstructionIcon(UIImage(systemName: "house") ?? UIImage())
                    .setSecondInstructionTitleText(
                        "Descrição para uso de accessórios",
                        color: .magenta
                    )
                    .setContinueButtonText("Iniciar")
                    .setContinueButtonColor(forContent: .lightGray, background: .systemPink, border: .white)
            }
            .setCameraPermissionCustomization { cameraPermissionBuilder in
                cameraPermissionBuilder
                    .setCameraPermissionBackgroundColor(.systemPink)
                    .setCameraPermissionBackButtonIcon(UIImage(systemName: "pencil") ?? UIImage())
                    .setCameraPermissionBackButtonColors(forIcon: .white, background: .black, border: .blue)
                    .setCameraPermissionImage(UIImage(systemName: "person.fill"), color: .cyan)
                    .setCameraPermissionTitle(
                        withText: "Permissão de câmera customizada",
                        color: .white
                    )
                    .setCameraPermissionCaption(
                        withText: "Descrição da permissão de câmera",
                        color: .purple
                    )
                    .setCameraPermissionCheckPermissionButton(withText: "Averiguar")
                    .setCameraPermissionCheckPermissionButtonNormalStateColors(
                        forText: .red,
                        background: .blue,
                        border: .white
                    )
                    .setCameraPermissionBottomSheetShape(withColor: .green, cornerRadius: 0)
                    .setCameraPermissionBottomSheetTitle(
                        withText: "Hora de ir para os ajustes",
                        color: .blue
                    )
                    .setCameraPermissionBottomSheetCaption(
                        withText: "Ou será que não?",
                        color: .orange
                    )
                    .setCameraPermissionOpenSettingsButton(withText: "Pular para ajustes")
                    .setCameraPermissionOpenSettingsButtonNormalStateColors(
                        forText: .orange,
                        background: .darkGray,
                        border: .blue
                    )
                    .setCameraPermissionCloseButton(withText: "Fechar tudo")
                    .setCameraPermissionCloseButtonNormalStateColors(
                        forText: .magenta,
                        background: .cyan,
                        border: .red
                    )
            }
            .setLivenessCustomization { livenessBuilder in
                livenessBuilder
                    .setBackgroundColor(.red)
                    .setPromptColors(forText: .green, backgroundColor: .white)
                    .setHeader(withText: "HEADER", textColor: .yellow, backgroundColor: .blue)
                    .setPromptRoundedCorners(enabled: false)
                    .setLAOvalStrokeColors(forCapturing: .cyan, completed: .systemPink)
                    .setGPAOvalStrokeColors(forNotReady: .yellow, completed: .blue)
                    .setFilter(withStyle: .vibrant, color: .purple, backgroundColor: .orange)
            }
            .setLoadingCustomization { loadingBuilder in
                loadingBuilder
                    .setLoadingBackgroundColor(.brown)
                    .setLoadingSpinner(withColor: .red, width: 10.7, scaleFactor: 5)
            }
            .setResultCustomization { resulBuilder in
                resulBuilder
                    .setResultBackgroundColor(.red, forResultType: .success)
                    .setResultImage(nil, forResultType: .success)
                    .setResultMessage("SUCCESS", forResultType: .success)
                    .setResultMessageColor(.blue, forResultType: .success)
                    .setResultBackgroundColor(.blue, forResultType: .error)
                    .setResultImage(nil, forResultType: .error)
                    .setResultMessage("ERROR", forResultType: .error)
                    .setResultMessageColor(.red, forResultType: .error)
            }
            .build()

        createJourney(with: customization)
    }

    @objc
    private func customViewsJourney() {
        let customization = IProovCustomization.builder()
            .setCustomInstructionView(CustomInstructionView())
            .setCustomCameraPermissionView(CustomCameraPermissionViewImpl())
            .setLoadingView(CustomIProovLoadingView())
            .setResultView(CustomIProovResultView())
            .build()

        createJourney(with: customization)
    }

    private func createJourney(with customization: IProovCustomization) {
        let options = LivenessManagerOptions
            .builder(appKey: appKey, environment: .hml)
            .setIProovCustomization(customization)
            .build()

        let manager = OitiSDKFactory.createLivenessManager(for: .iproov)
        manager.start(at: self, options: options, callback: self)
    }
}

// MARK: - LivenessCallback

extension ContentViewController: LivenessCallback {
    func onSuccess(_ result: LivenessResult) {
        let message = """
        Valid: \(String(describing: result.valid))
        CodId: \(String(describing: result.codId))
        Protocol: \(String(describing: result.protocol))
        """

        showAlert(title: "Resultado LivenessIProov", message: message)
    }

    func onError(_ error: LivenessError) {
        showAlert(
            title: "Resultado LivenessIProov",
            message: "[\(error.code)]: \(error.message)"
        )
    }

    private func showAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
