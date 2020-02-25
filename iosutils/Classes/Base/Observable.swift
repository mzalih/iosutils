
import Foundation
public class Observable<T>{
    public typealias Observer = (T) -> ()
    var observeres:[Observer] = []
   public var value:T {
        didSet{
            observeres.forEach{
                $0(value)
            }
        }
    }
   public init(_ value:T) {
        self.value = value
    }
   public func observe(_ listener: @escaping Observer){
        self.observeres.append(listener)
         listener(value)
    }
   public func observeOnlyFor(_ listener: @escaping Observer){
        self.observeres.removeAll()
        self.observeres.append(listener)
        listener(value)
    }
}

