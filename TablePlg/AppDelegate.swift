import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = ViewController()
        let mainVC = UINavigationController(rootViewController: vc)

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()

        // Override point for customization after application launch.
        return true
    }
}

