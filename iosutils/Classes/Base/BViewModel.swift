
import UIKit

class BViewModel: NSObject {
    var netWorkError = false;
    var limit = 100
    var loading = true;
    var error   = true;
    var loadCompletd = false;
    
    func startLoading(){
        self.loadCompletd = false;
        self.loading = true;
        self.error = false;
    }
    func endLoading( loadCompleted:Bool = false ,error:Bool = false){
        self.loadCompletd = loadCompleted;
        self.loading = false;
        self.error = error;
    }

}
