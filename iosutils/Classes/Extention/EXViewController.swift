
import UIKit

func getTopView()->UIViewController?{
    if let window = UIApplication.shared.keyWindow {
        if let viewController = window.topViewController() {
            return viewController;
        }
    }
    return nil
}
func getRootView()->UIViewController?{
    if let window = UIApplication.shared.keyWindow {
        if let viewController = window.rootViewController{
            return viewController;
        }
    }
    return nil
}
func getVC(_ storyboard:String ,_ identifier :String? = nil)->UIViewController{
    if let usableIdentifier = identifier{
        return  UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: usableIdentifier);
    }
    return  UIStoryboard(name: storyboard, bundle: nil).instantiateInitialViewController() ?? UIViewController();
}
extension UIViewController{
    @IBAction func  dismiss(_ sender: Any? = nil) {
        self.dismiss(animated: true);
    }
    @IBAction func  back(_ sender: Any? = nil) {
        back(animated: true)
    }
    func  back(animated:Bool) {
        self.navigationController?.popViewController(animated:animated);
    }
    @IBAction func  backRoot(_ sender: Any? = nil ) {
        backRoot(animated: true)
    }
     func  backRoot(animated:Bool) {
        self.navigationController?.popToRootViewController(animated: animated)
    }
}
extension UIViewController{
    
    func rootNaviagation()->UINavigationController?{
       
        if let mUINavigationController = (UIApplication.shared.windows.filter {$0.isKeyWindow}.first)?.rootViewController as? UINavigationController{
                       return mUINavigationController;
            }
        
        return nil;
    }
    func rootPushViewController(_ vc:UIViewController,animated:Bool){
        if let nvc = rootNaviagation(){
            nvc.pushViewController(vc, animated: animated);
        }
    }
        func setupHideKeyboardOnTap() {
            self.view.addGestureRecognizer(self.endEditingRecognizer())
            self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
        }
        
        /// Dismisses the keyboard from self.view
        private func endEditingRecognizer() -> UIGestureRecognizer {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
           tap.cancelsTouchesInView = false
            return tap
        }
    
    @objc func dismissKeyboard(_ sender:UITapGestureRecognizer) {
        let view = sender.view
        let loc = sender.location(in: view)
        let subview = view?.hitTest(loc, with: nil)
        if (subview?.tag != 8682){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                       self.view.endEditing(true)
                   }
        }
        
       
    }
    func limitIpadWidth(){
        if ( UIDevice.current.userInterfaceIdiom == .pad )
               {
                   if let frame =   self.navigationController?.view.frame{
                   if(frame.width > 600){
    self.navigationController?.view.window?.backgroundColor = UIColor.init(hexString: "#E6EEFF")

                       if  let center =  self.navigationController?.view.center {
                       self.navigationController?.view.frame  = CGRect.init(x:  frame.origin.x, y: frame.origin.y, width: 600, height: frame.height)
                       self.navigationController?.view.center = center
                       }
                   }
                   }
               }
    }
}
