//
//  AppDelegate.swift
//  Step Counter
//
//  Created by zhaoxin on 2021/10/18.
//

import UIKit
import IceCream
import CloudKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var syncEngine: SyncEngine?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        syncEngine = SyncEngine(objects: [
            SyncObject(type: Step.self)
            ])
        
        /// If you wanna test public Database, comment the above syncEngine code and uncomment the following one
        /// Besides, uncomment Line 26 to 28 in Person.swift file
//        syncEngine = SyncEngine(objects: [SyncObject<Person>()], databaseScope: .public)
      
        application.registerForRemoteNotifications()
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let dict = userInfo as? [String: NSObject], let notification = CKNotification(fromRemoteNotificationDictionary: dict), let subscriptionID = notification.subscriptionID, IceCreamSubscription.allIDs.contains(subscriptionID) {
            NotificationCenter.default.post(name: Notifications.cloudKitDataDidChangeRemotely.name, object: nil, userInfo: userInfo)
            completionHandler(.newData)
        }
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        // How about fetching changes here?
        
    }


}

