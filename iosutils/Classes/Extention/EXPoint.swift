

import UIKit
extension CGPoint{
    func add(x :CGFloat = 0.0 , y :CGFloat  = 0.0) ->CGPoint{
        return CGPoint.init(x: self.x + x  , y: self.y + y);
    }
    func add(x :Double = 0.0 , y :Double  = 0.0) ->CGPoint{
        return CGPoint.init(x: self.x + CGFloat(x)  , y: self.y + CGFloat(y));
    }
}
extension CGPoint {
  var cgSize: CGSize {
    return CGSize(width: x, height: y)
  }

  func absolutePoint(in rect: CGRect) -> CGPoint {
    return CGPoint(x: x * rect.size.width, y: y * rect.size.height) + rect.origin
  }
}
func + (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (left: CGPoint, right: CGFloat) -> CGPoint {
  return CGPoint(x: left.x * right, y: left.y * right)
}
