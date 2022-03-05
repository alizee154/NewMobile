//
//  ShareView.swift
//  ProjetAWI
//
//  Created by m1 on 01/03/2022.
//

import Foundation
import SwiftUI

struct ShareView: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareView>) ->
    UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems,
                                        applicationActivities: applicationActivities)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ShareView>) {
        // empty
    }
}
