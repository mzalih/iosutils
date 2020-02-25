
import UIKit

@objc(BaseApplication) class BaseApplication: UIApplication {
    
    
    func containsEndTouch(_ event: UIEvent)->Bool{
        for touch in event.allTouches ?? []{
            if(touch.phase == UITouch.Phase.ended){
                return true
            }
        }
        return false;
    }
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        
        if(event.type == .touches && containsEndTouch(event)){
            if let view = event.allTouches?.first?.view{
                MLog.track(view)
            }
        }
    
    }
}
