
import Foundation
var userDefaults = UserDefaults()
public  class Defaults: NSObject {
    
    
  public   static func setString(value:String?,key:String){
       userDefaults.set(value, forKey: key)
       userDefaults.synchronize()
    }
    
    public static func removeString(key:String)
    {
        userDefaults.removeObject(forKey: key)
        //  Save to disk
        userDefaults.synchronize()
    
    }
    public static func setArray(value:Array<Any>,key:String){
        userDefaults.set(value, forKey: key)
        //  Save to disk
        userDefaults.synchronize()
    }

   public  static func getArray(key:String)->Array<Any>?{
        if userDefaults.object(forKey: key) == nil {
            //  Doesn't exist
            return nil;
        } else {
            let currentLevel = userDefaults.array(forKey: key)
            if(currentLevel != nil){
                return currentLevel!;
            }
            return nil;
        }
    }
    
    
  public   static func getString(key:String)->String?{
        if userDefaults.object(forKey: key) == nil {
            //  Doesn't exist
            return nil;
        } else {
            let currentLevel = userDefaults.string(forKey: key)
            return currentLevel!;
        }
    }
    public static func setData(value:Data ,key:String){
        userDefaults.set(value,forKey: key)
        //  Save to disk
        userDefaults.synchronize()
    }
    
    public static func getData(key:String)->Data?{
        if userDefaults.object(forKey: key) == nil {
            //  Doesn't exist
            return nil;
        } else {
            let currentLevel = userDefaults.data(forKey: key)
            if(currentLevel != nil){
            return currentLevel!;
            }
            return nil;
        }
    }
   public  static func setBool(value:Bool?,key:String){
        userDefaults.set(value, forKey: key)
        //  Save to disk
        userDefaults.synchronize()
    }
    
   public  static func getBool(key:String)->Bool{
        if userDefaults.object(forKey: key) == nil {
            //  Doesn't exist
            return false;
        } else {
            let currentLevel = userDefaults.bool(forKey: key)
            return currentLevel;
        }
    }
}
public extension UserDefaults{
    static func clear(){
        if let bundleID = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: bundleID)
                    }
    }
}
