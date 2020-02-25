
import UIKit
public  class MAlert: NSObject {

public static func alert(title:String? = nil,text:String?) {
    alert([
        UIAlertAction(title: "Close", style: .default, handler: { action in
    })
     ],title:title,message:text)
}
public static func alert(text:String,inView :UIViewController ,withResponse:@escaping Response) {
    alert([
        UIAlertAction(title: "Close", style: .default, handler: { action in
            withResponse(true,nil);
        })
    ],title:"",message:text,inView: inView)
}
public static func alert(text:String,yes:String,no:String,inView :UIViewController ,withResponse:@escaping Response) {

    alert([
            UIAlertAction(title: yes, style: .default, handler: { action in
            withResponse(true,nil);
            }),
            UIAlertAction(title: no, style: .default, handler: { action in
                withResponse(false,nil);
            })
    ],title:"",message:text,inView: inView)
    
}

public static func alert(text:String, withDismissPage:Bool, inView :UIViewController? ) {
    alert([UIAlertAction(title: "OK", style: .default, handler: { action in
            if(withDismissPage){
            inView?.navigationController?.popViewController(animated: true);
            }
    })],title:"",message:text,inView: inView)

}
public static func alert(_ actions: [UIAlertAction], title:String? = nil, message:String? = nil ,_ textFields:[((UITextField) -> Void)?]? = nil, inView:UIViewController? = getTopView()){
    if(inView == nil){
        return ;
    }
    let actionSheetController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    for tfds in textFields ?? []{
        actionSheetController.addTextField(configurationHandler: tfds);
    }
    for action in actions{
        actionSheetController.addAction(action)
    }
    
    inView?.present(actionSheetController, animated: true, completion: {
      
        UIView.animate(withDuration: 0.3, delay: 0.0, options:[], animations: {
            actionSheetController.view.superview?.backgroundColor = .black
        }, completion:nil)
    })
    
   
}
    
public static func sheet(_ actions: [UIAlertAction],_ title:String? = nil,_ message:String? = nil , inView:UIViewController? = getTopView()){
            if(inView == nil){
                return ;
            }
            let actionSheetController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
            for action in actions{
                 actionSheetController.addAction(action)
            }
          inView?.present(actionSheetController, animated: true, completion: nil)
        }
}
