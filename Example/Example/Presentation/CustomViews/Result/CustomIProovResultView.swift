//
//  CustomIProovResultView.swift
//  OitiSDKExample
//
//  Created by Vitor Souza on 17/06/25.
//

import OitiSDK
import UIKit

final class CustomIProovResultView: UIView, IProovCustomResultView {
    func display(for resultType: IProovResultLayoutType) {
        switch resultType {
        case .success:
            backgroundColor = .green
        case .error:
            backgroundColor = .red
        @unknown default:
            backgroundColor = .white
        }
    }
}
