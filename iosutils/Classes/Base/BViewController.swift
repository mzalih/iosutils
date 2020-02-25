
import UIKit

public class BViewController: UIViewController {

      var refreshControl:UIRefreshControl? = nil;
    override public func viewDidLoad() {
          super.viewDidLoad()
          setupHideKeyboardOnTap()
          MLog.track(self);
          limitIpadWidth()
      }
        override func getTrackName() -> String {
            return super.getTrackName().camelCaseToWords()
        }
}
extension BViewController{

        @objc  public func refreshMessage()->NSMutableAttributedString{
            return "Pull to refresh ".toNSMutableAttributedString()
        }
        
       public func addRefresh(scrollView:UIScrollView?) {
            if let scrollView = scrollView{
            if (self.refreshControl == nil){
               self.refreshControl = UIRefreshControl()
            }
            self.refreshControl?.attributedTitle = refreshMessage()
            refreshControl?.addTarget(self, action: #selector(self.refresh), for: UIControl.Event.valueChanged)
            
            scrollView.addSubview(refreshControl!)
            
            if #available(iOS 10.0, *) {
              //  scrollView.refreshControl = refreshControl
            } else {
              //  scrollView.backgroundView = refreshControl
            }
            }
        }
        @objc func refresh(){
            self.refreshControl?.endRefreshing()
            if let scrollview =  self.refreshControl?.superview as?  UIScrollView{
                scrollview.contentOffset = CGPoint.zero
            }
            reload()
        }
        @objc public func reload(){
            
        }
       public static  func show(vc:UIViewController,_ storyBoard:String ,_ viewName:String? = nil){
            let nvc = getVC(storyBoard,viewName)
            vc.rootPushViewController(nvc, animated: true);
            
        }
   public static func setRootView(_ vc:UIViewController){
         UIApplication.shared.keyWindow?.rootViewController = vc
    }
}
