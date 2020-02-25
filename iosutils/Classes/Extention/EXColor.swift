

import UIKit

public enum ColorValues{
    case RED
    case GREEN
    case BLUE
    case ALPHA
}

public extension UIColor {
    /**
     Creates an UIColor from HEX String in "#363636" format
     
     - parameter hexString: HEX String in "#363636" format
     
     - returns: UIColor from HexString
     */
    public convenience init(hexString: String) {
        
        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner          = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
}
public extension UIColor {
      func toHexString() -> String {
          var r:CGFloat = 0
          var g:CGFloat = 0
          var b:CGFloat = 0
          var a:CGFloat = 0

          getRed(&r, green: &g, blue: &b, alpha: &a)

          let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

          return String(format:"#%06x", rgb)
      }
    func RGB(position:ColorValues) -> CGFloat  {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)
        var value = CGFloat(0)
        switch position{
        case .RED :
                value  = r*255
                 break
        case .GREEN:
             value  = g*255
                       break
        case .BLUE:
             value  = b*255
                       break
        case .ALPHA:
             value  = a*255
                       break
        }
        return value
      
    }
  }
