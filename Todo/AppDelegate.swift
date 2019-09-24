//
//  AppDelegate.swift
//  Todo
//
//  Created by Esteban Ordonez on 9/11/19.
//  Copyright © 2019 Esteban Ordonez. All rights reserved.
//

import UIKit

import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //print(Realm.Configuration.defaultConfiguration.fileURL)//location of realm database is.
        
       
        
        do{
            _ = try Realm()
        }catch{
            print("Error initialising Realm \(error)")
        }
        
       
        return true
    }

 
    


}

