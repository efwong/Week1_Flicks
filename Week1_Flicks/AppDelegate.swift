//
//  AppDelegate.swift
//  Week1_Flicks
//
//  Created by Edwin Wong on 10/14/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Get the storyboard
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        // fetch two instances of the MainNavigation Nav Controller
        if let nav1 = storyBoard.instantiateViewController(withIdentifier: "MainNavigation") as? UINavigationController,
            let nav2 = storyBoard.instantiateViewController(withIdentifier: "MainNavigation") as? UINavigationController{
            
            
            // Assign the NowPlaying enum to the first view controller
            if let vc1 = nav1.viewControllers[0] as? MovieListViewController{
                vc1.movieEnum = MovieEnum.nowPlaying
            }
            
            // Assign the TopRated enum to the second view controller
            if let vc2 = nav2.viewControllers[0] as? MovieListViewController{
                vc2.movieEnum = MovieEnum.topRated
            }
            // assign names and icons
            nav1.tabBarItem.title = "Now Playing"
            nav1.tabBarItem.image = UIImage(named: "now_playing")
            nav2.tabBarItem.title = "Top Rated"
            nav2.tabBarItem.image = UIImage(named: "top_rated")
            
            // Set up the Tab Bar Controller to have two tabs
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [nav1, nav2]
            
            // Make the Tab Bar Controller the root view controller
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

