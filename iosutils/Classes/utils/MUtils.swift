import UIKit
public typealias Response = (_ status: Bool, _ data: Any? ) -> Void

/**
 *SetDelay
 */
func delay(_ seconds: Double, f: @escaping () -> Void) {
    let delay = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delay) {
        f()
    }
}
func mainQ(f: @escaping () -> Void){
    DispatchQueue.main.async {
        f()
    }
}
func isDebug()->Bool{
    #if DEBUG
    // debug only code
        return  true
    #else
    // release only code
        return false
    #endif
}
