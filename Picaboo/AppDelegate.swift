//
//  AppDelegate.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 27/07/2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // create the window, bypass the storyboard
        window = UIWindow(frame: UIScreen.main.bounds)
        // make this window visible
        window?.makeKeyAndVisible()
        
        window?.rootViewController = PhotosController()
        
        // looks better on old devices without the notch :)
        window?.makeCorner(withRadius: 5)
        
        return true
    }
}

