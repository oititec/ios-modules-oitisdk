//
//  CustomCameraPermissionViewImpl.swift
//  OILivenessIProovExample
//
//  Created by Vitor Souza on 10/04/25.
//

import UIKit
import OitiSDK

final class CustomCameraPermissionViewImpl: UIView, CustomCameraPermissionView {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var checkPermissionButton: UIButton!
    @IBOutlet weak var openSettingsButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadFromNib()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadFromNib()
        setupViews()
    }
    
    private func loadFromNib() {
        let classType = type(of: self)
        let bundle = Bundle(for: classType)
        bundle.loadNibNamed("\(classType)", owner: self)
    }
    
    private func setupViews() {
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds
        
        hiddenBottomSheetButtons(true)
        
        addSubview(view)
    }
    
    func showBottomSheet(visibility: OitiSDK.Visibility) {
        switch visibility {
        case .displayed:
            hiddenBottomSheetButtons(false)
        case .hidden:
            hiddenBottomSheetButtons(true)
        @unknown default:
            hiddenBottomSheetButtons(true)
        }
    }
    
    private func hiddenBottomSheetButtons(_ hiddenValue: Bool) {
        openSettingsButton.isHidden = hiddenValue
        closeButton.isHidden = hiddenValue
    }
}
