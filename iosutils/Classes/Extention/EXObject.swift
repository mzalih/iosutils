
import UIKit
extension NSObject{
    static func getVCName(_ vc:UIViewController? = getTopView())->String{
        if let obj = vc{
            return obj.getName()
        }
        return "App"
    }
    func getName()->String{
        return String(describing: self)
    }
    static func getClassName()->String{
           return String(describing: type(of: self))
    }
}
