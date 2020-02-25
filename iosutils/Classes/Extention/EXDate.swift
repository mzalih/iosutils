
import Foundation
public extension Date{
    func formatDate(_ format:String ,_ gmt:Bool = false) -> String {
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        if(gmt){
            dateFormatterPrint.timeZone = NSTimeZone(name: "GMT")! as TimeZone;
        }
        return dateFormatterPrint.string(from: self)
    }
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    func timeAgo(_ numericDates:Bool = true ,_ prefix:String = " ago") -> String {
        
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(self)
        let latest = (earliest == now) ? self : now
        let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
        if (components.year! >= 2) {
            return "\(components.year!)y\(prefix)"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1y\(prefix)"
            } else {
                return "Last year"
            }
                    } else if (components.month! >= 2) {
                        return "\(components.month! * 4)w\(prefix)"
                    } else if (components.month! >= 1){
                        if (numericDates){
                            return "4w\(prefix)"
                        } else {
                            return "Last month"
                        }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!)w\(prefix)"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1w\(prefix)"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!)d\(prefix)"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1d\(prefix)"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!)h\(prefix)"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1h\(prefix)"
            } else {
                return "An hour\(prefix)"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!)m\(prefix)"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1m\(prefix)"
            } else {
                return "A minute\(prefix)"
            }
        } else {
            return "Just now"
        }
    }
    func timeFullAgo(_ numericDates:Bool = true ,_ prefix:String = " ago") -> String {
        
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(self)
        let latest = (earliest == now) ? self : now
        let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
        if (components.year! >= 2) {
            return "\(components.year!) year\(prefix)"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year\(prefix)"
            } else {
                return "Last year"
            }
                    } else if (components.month! >= 2) {
                        return "\(components.month!) months\(prefix)"
                    } else if (components.month! >= 1){
                        if (numericDates){
                            return "1 month\(prefix)"
                        } else {
                            return "Last month"
                        }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks\(prefix)"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week\(prefix)"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days\(prefix)"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day\(prefix)"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours\(prefix)"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour\(prefix)"
            } else {
                return "An hour\(prefix)"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes\(prefix)"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute\(prefix)"
            } else {
                return "A minute\(prefix)"
            }
        } else {
            return "Just now"
        }
    }
}
public struct DateFormat{
    public static let FULL = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    public static let DATE_WEEKDAY = "EEEE, MMM d"
    public static let DATE_TIME = "MMM d, yyyy h:mm a"
    public static let DATE_DISPLAY = "MMM d, yyyy"
    public static let DATE_MMDDYYYY = "MM/dd/yyyy"
    public static let DATE_MONTH_DAY = "MMM dd"
    public static let DATE_YYYYMMDD = "yyyy-MM-dd"
    public static let TIME = "hh:mm a"
    public static let TIME_EXCEPT_MERIDIAN = "hh:mm"
    public static let TIME_MERIDIEM = "a"
    public static let TIME_24_FORMAT = "HH:mm"
    public static let CARD_EXPIRY = "MM/YY"
    public static let NUMERIC_DDMMYY = "ddMMyy"
    public static let NUMERIC_YYMMDD = "yyMMdd"
}
