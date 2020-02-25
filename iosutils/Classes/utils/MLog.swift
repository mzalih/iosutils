import UIKit
class MLog: NSObject {
    
    
    public static func add(_ event:String, _ message:String ,_ orgin:String  = MLog.getVCName()){
        let params =  ["orgin":orgin ,"message":message];
        track(event, data:params);
    }
    public static func track(_ event:String,data:[AnyHashable : Any]?){

    }
    
    private static func getTrackData(_ page:String?, _ data:String?)->[AnyHashable : Any]?{
        return ["email":"Unknown" ,
                "message":  data ?? "" ,
                "page"   :  page ?? "Unknown",
                "Role"   : "Unknown"
        ]
    }
    private static func track(_ item:String , _ inView:String? ,  _ ofPage :String?){
        
         track("Open Page",data: getTrackData(ofPage,"Tracking click of  \(item) in \(inView ?? "a view") of \(ofPage ?? "a page")"))
        
        #if DEBUG
          print("Tracking click of  \(item) in \(inView ?? "a view") of \(ofPage ?? "a page")" )
        #endif
    }

    
    public static func  track(_ vc :UIViewController){
        let page = vc.getTrackName()
        track("Open Page",data: getTrackData(page,"Opening Page \(page)"))
 
        #if DEBUG
            print("Tracking Opening of page \(page)")
        #endif
    }
    public static func  track(_ view :UIView){
        
            if let btn =  view as? UIButton{
                track(btn.getTrackName(),nil, btn.findViewController()?.getTrackName())
            }
            else if let btn = view.findTableViewCell(){
               track(btn.getTrackName(), btn.findTableView()?.getTrackName() ,btn.findViewController()?.getTrackName());
            }
           else if let btn = view.findCollectionViewCell(){
                track(btn.getTrackName() , btn.findCollectionView()?.getTrackName() , btn.findViewController()?.getTrackName());
            }
        
    }

}
extension UIView {
    
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    func findTableView() -> UITableView? {
        if let nextResponder = self.next as? UITableView {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findTableView()
        } else {
            return nil
        }
    }
    func findTableViewCell() -> UITableViewCell? {
        if let nextResponder = self.next as? UITableViewCell {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findTableViewCell()
        } else {
            return nil
        }
    }
    func findCollectionView() -> UICollectionView? {
        if let nextResponder = self.next as? UICollectionView {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findCollectionView()
        } else {
            return nil
        }
    }
    
    func findCollectionViewCell() -> UICollectionViewCell? {
        if let nextResponder = self.next as? UICollectionViewCell {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findCollectionViewCell()
        } else {
            return nil
        }
    }
}
extension NSObject{
   @objc func getTrackName()->String{
        return self.getName()
     }
}
class TrackButton:UIButton{
    
      @IBInspectable open var trackName: String = ""
       override func getTrackName()->String{
            if(trackName.trim() == ""){
                return super.getTrackName()
            }
            return trackName
        }
}
extension UIButton{
    override func getTrackName()->String{
        if let label  = self.titleLabel?.text , label.trim() != ""{
                return  label
        }
        return getName()
    }
    
}


