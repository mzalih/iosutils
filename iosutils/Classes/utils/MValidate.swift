
import UIKit
class MValidate: NSObject {
    static func isString(value:Any?, minSize:Int)->Bool{
        if let str:String = value as? String {
            if( str.count >= minSize){
                return true ;
            }
        }
        return false;
    }
    static func isValidUrl (urlString: String?) -> Bool {
        
        guard let urlString = urlString else {return false}
        guard let url = URL(string: urlString) else {return false}
        if urlString == "http://" || urlString == "https://" || !UIApplication.shared.canOpenURL(url) {return false}
        return true
    }
    static func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    static func isValidPhone(value: String) -> Bool {
        if(MValidate.validExp("^\\d{3}-\\d{3}-\\d{4}$",value)){
            return true
        }
        if(MValidate.validExp("^\\d{10}$",value)){
            return true
        }
        if(MValidate.validExp("^\\(\\d{3}\\)\\-\\d{3}\\-\\d{4}$",value)){
            return true
        }
        if(MValidate.validExp("^\\(\\d{3}\\) \\d{3}-\\d{4}$",value)){
            return true
        }
        if(MValidate.validExp("^\\+[1-9]{1} \\(\\d{3}\\) \\d{3}-\\d{4}$",value)){// validate "+1 (632) 646-5465"
            return true
        }
        
        if(MValidate.validExp("^\\(\\d{3}\\) \\d{3} \\d{4}$",value)){
            return true
        }
        if(MValidate.validExp("^\\(\\d{3}\\) \\d{3}-\\d{4}$",value)){
            return true
        }
        if(MValidate.validExp("^\\d{3} \\d{3} \\d{4}$",value)){
            return true
        }
        
        return  false;
    }
    static func validExp(_ PHONE_REGEX:String , _ value:String)->Bool{
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result;
        
    }
}
