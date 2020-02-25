
import UIKit
extension UIView {
    func clickDelay(delayTime:Double){
        self.isUserInteractionEnabled = false
        delay(delayTime) {
            self.isUserInteractionEnabled = true
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
           get {
               return layer.cornerRadius
           }
           set {
               layer.cornerRadius = newValue
               layer.masksToBounds = newValue > 0
           }
       }
       
       @IBInspectable var borderWidth: CGFloat {
           get {
               return layer.borderWidth
           }
           set {
               layer.borderWidth = newValue
           }
       }
       
       @IBInspectable var borderColor: UIColor? {
           get {
               return UIColor(cgColor: layer.borderColor!)
           }
           set {
               layer.borderColor = newValue?.cgColor
           }
       }
    @IBInspectable var rotateAngle: CGFloat {
        get {
            return 0.0
        }
        set {
            rotate(newValue)
        }
    }


}
extension UIView {

      func rotate(_ angle: CGFloat) {
          let radians = angle / 180.0 * CGFloat.pi
          let rotation = self.transform.rotated(by: radians);
          self.transform = rotation
      }
    func rotate(_ angle: CGFloat , speed:TimeInterval) {
        UIView.animate(withDuration: speed, animations: {
            let radians = angle / 180.0 * CGFloat.pi
                   let rotation = self.transform.rotated(by: radians);
                   self.transform = rotation
        })

    }
    func addDashedBorder(_ lineWidth:CGFloat = 2 , _ lineDashPattern:[NSNumber] = [6,3]) {
        if(lineWidth == 0){
            return
        }
   

    let shapeLayer:CAShapeLayer = CAShapeLayer()
    let frameSize = self.frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = layer.borderColor
    shapeLayer.lineWidth = lineWidth
    shapeLayer.lineDashPattern = lineDashPattern
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath

    self.layer.addSublayer(shapeLayer)
    }
}
