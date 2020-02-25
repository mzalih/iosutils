

import UIKit

public extension NSMutableAttributedString{
    func setColorForText(_ textToFind: String?, with color: UIColor) {

        let range:NSRange?
        if let text = textToFind{
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        }else{
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range!)
        }
    }
    func setUnderlineWith(_ textToFind:String?, with color: UIColor,style:Any){
        //NSUnderlineStyle.styleThick.rawValue
        let range:NSRange?
        if let text = textToFind{
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        }else{
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.underlineStyle, value:style, range: range!)
            addAttribute(NSAttributedString.Key.underlineColor, value:color , range: range!)
        }
    }
    func setHighlightColorForText(_ textToFind:String?,with color:UIColor){

        let range:NSRange?
        if let text = textToFind{
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        }else{
            range = NSMakeRange(0, self.length)
        }

        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.backgroundColor, value: color, range: range!)
        }
    }
    func setFont(_ textToFind:String?,withFont:UIFont){

        let range:NSRange?
        if let text = textToFind{
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        }else{
            range = NSMakeRange(0, self.length)
        }

        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.font , value: withFont, range: range!);
        }
    }
}

