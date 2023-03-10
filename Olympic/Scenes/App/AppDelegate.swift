//
//  AppDelegate.swift
//  Olympic
//
//  Created by MacBook on 09/03/2023.
//

import Foundation
import UIKit
import SwiftUI
import SDWebImage
import SDWebImageWebPCoder

class AppDelegate: NSObject, UIApplicationDelegate {
    

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        self.configWebImage()
        
        return true
    }
    
    func configWebImage(){
        SDImageCodersManager.shared.addCoder(SDImageWebPCoder.shared)
        //SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        //SDImageCodersManager.shared.addCoder(SDImagePDFCoder.shared)
        // Dynamic check to support vector format for both WebImage/AnimatedImage
        SDWebImageManager.shared.optionsProcessor = SDWebImageOptionsProcessor { url, options, context in
            var options = options
            if let _ = context?[.animatedImageClass] as? SDAnimatedImage.Type {
                // AnimatedImage supports vector rendering, should not force decode
                options.insert(.avoidDecodeImage)
            }
            return SDWebImageOptionsResult(options: options, context: context)
        }
    }
}
