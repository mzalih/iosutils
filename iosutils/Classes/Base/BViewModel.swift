
import UIKit

public class BViewModel: NSObject {
    public var netWorkError = false;
    public var limit = 100
    public var loading = true;
    public var error   = true;
    public var loadCompletd = false;
    
    public func startLoading(){
        self.loadCompletd = false;
        self.loading = true;
        self.error = false;
    }
    public func endLoading( loadCompleted:Bool = false ,error:Bool = false){
        self.loadCompletd = loadCompleted;
        self.loading = false;
        self.error = error;
    }

}
