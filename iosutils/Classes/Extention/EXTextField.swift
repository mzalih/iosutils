
import UIKit

public extension UITextField {

@IBInspectable var placeHolderColor : UIColor {
       get {
        return UIColor.black
       }
       set {
        attributedPlaceholder = NSAttributedString(string:placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: newValue])
       }
   }
}
