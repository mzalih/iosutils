
import Foundation
class Observable<T>{
    typealias Observer = (T) -> ()
    var observeres:[Observer] = []
    var value:T {
        didSet{
            observeres.forEach{
                $0(value)
            }
        }
    }
    init(_ value:T) {
        self.value = value
    }
    func observe(_ listener: @escaping Observer){
        self.observeres.append(listener)
         listener(value)
    }
    func observeOnlyFor(_ listener: @escaping Observer){
        self.observeres.removeAll()
        self.observeres.append(listener)
        listener(value)
    }
}

