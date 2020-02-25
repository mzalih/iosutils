
import UIKit
public extension NSDictionary{
    
    static  func getStringValue(_ data:Any,_ key:String)->String{
        if let dic  = data as? NSDictionary{
            if let value  =  dic[key] as? String{
                return value;
            }
            
        }
        return ""
    }
    
    static func getDicValue(_ data:Any,_ key:String)->NSDictionary{
        if let dic  = data as? NSDictionary{
            if let value  =  dic[key] as? NSDictionary{
                return value;
            }
            
        }
        return NSDictionary()
    }
    
    func toString()->String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)
        }
        catch ( _){
            return nil;
        }
    }
    func json()->String?{
        return toString()?.printableJSON()
    }
    
    
}
