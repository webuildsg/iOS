import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var vc: ListViewController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if let viewControllers = self.window?.rootViewController?.childViewControllers {
            for viewController in viewControllers {
                if viewController.isKindOfClass(ListViewController) {
                    vc = (viewController as? ListViewController)!
                }
            }
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    
    }

    func applicationDidEnterBackground(application: UIApplication) {
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        vc?.getData()
    }

    func applicationDidBecomeActive(application: UIApplication) {

    }

    func applicationWillTerminate(application: UIApplication) {

    }

}

