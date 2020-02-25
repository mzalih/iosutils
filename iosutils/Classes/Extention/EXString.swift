
import UIKit
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG
import Photos
import SDWebImage

extension String{
    func replace(target: String, with: String) -> String {
        return self.replacingOccurrences(of: target, with: with, options: .literal, range: nil)
    }
    func getPlist()->NSDictionary{
        var nsDictionary: NSDictionary = NSDictionary();
        if let path = Bundle.main.path(forResource: self, ofType: "plist") {
            if let data  = NSDictionary(contentsOfFile: path) {
                nsDictionary = data;
            }
        }
        return nsDictionary
    }
    func getNSDictionary()->NSDictionary{
        do {
            if let responseObject = try JSONSerialization.jsonObject(with: Data(self.utf8) , options: []) as? [String:AnyObject]{
                return responseObject as NSDictionary
            }
             return  NSDictionary() ;
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
        return  NSDictionary();
    
    }
    var dictionary:[String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    var data:Data?{
        if let data = self.data(using: .utf8) {
            return data;
        }
        return self.data;
    }
    func price(_ prefix:String = "",_ postfix:String = "") -> String {
        
        if let value  = Double(self){
            if(value  == 0){
                 return String(format: "%@0%@", prefix ,postfix)
            }
            return String(format: "%@%.2f%@", prefix,value,postfix)
        }
        return "" ;
    }
    func oneDecimal(_ prefix:String = "",_ postfix:String = "") -> String {
           
           if let value  = Double(self){
               if(value  == 0){
                    return String(format: "%@0%@", prefix ,postfix)
               }
               return String(format: "%@%.1f%@", prefix,value,postfix)
           }
           return "" ;
       }
    func rounded(_ append:String = "") -> String {
        if let value  = Double(self){
            return String(format: "%@%.0f", append,value)
        }
        return "" ;
    }

    func currencyValue() -> Double {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let  regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return 0.0
        }
        
        return Double(truncating: number!)
    }
    func date(_ format:String = DateFormat.FULL)->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date ;
    }
    public func toUrl() -> URL?{
        if let url = URL(string: self){
           return url
        }
        return nil;
    }
    func heightInView(font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.height
    }
    func widthInView(font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.width
    }
    //FirstUpperCased
    var upperCasedFirst: String {
        
        guard let first = self.lowercased().first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    //FirstUpperCased
    var lowerCasedFirst: String {
        guard let first = first else { return "" }
        return String(first).lowercased() + dropFirst()
    }
    func trim() -> String
    {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var isFbCdn:Bool{
        return (self.contains(".fb") || self.contains("cdn.fb") )
    }
    //Cleaner YoutubeLink
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, options: [], range: range) else {
            return nil
        }
        let ytID = (self as NSString).substring(with: result.range)
        if(ytID.count < 9){
            return nil ;
        }
        return ytID
    }
    func printableJSON()->String{
        var newstring =  self.replacingOccurrences(of: "\\n", with: "", options: .regularExpression)
         newstring =  newstring.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range:nil)
        return newstring;
    }
    
    func MD5() -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        let md5Hex =  digestData.map { String(format: "%02hhx", $0) }.joined()
       //  let md5Base64 = digestData.base64EncodedString()
        return md5Hex
    }
    func camelCaseToWords() -> String {

            return unicodeScalars.reduce("") {

                if CharacterSet.uppercaseLetters.contains($1) {

                    return ($0 + " " + String($1))
                }
                else {

                    return $0 + String($1)
                }
            }
        }
    
    func fileName()->String{
        return (self as NSString).lastPathComponent;
    }
    
    func extractAll(type: NSTextCheckingResult.CheckingType) -> [NSTextCheckingResult] {
        var result = [NSTextCheckingResult]()
        do {
            let detector = try NSDataDetector(types: type.rawValue)
            result = detector.matches(in: self, range: NSRange(startIndex..., in: self))
        } catch { print("ERROR: \(error)") }
        return result
    }
    
    func to(type: NSTextCheckingResult.CheckingType) -> String? {
        let phones = extractAll(type: type).compactMap { $0.phoneNumber }
        switch phones.count {
        case 0: return nil
        case 1: return phones.first
        default: print("ERROR: Detected several phone numbers"); return nil
        }
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func makeACall() {
        guard   let number = to(type: .phoneNumber),
            let url = URL(string: "tel://\(number.onlyDigits())"),
            UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    //Mobile number format Convertion
    public func toPhoneNumber() -> String {
         return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2 $3", options: .regularExpression, range: nil)
    }
    
    
    func saveToPhone(video:Bool = false){
        if let url = self.toUrl(){
            if(video){
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
                }) { saved, error in
                    if saved {
                        Toast.snakbar("Media added to Library")
                    }
                }
            }else{
           
                SDWebImageManager.shared.loadImage(with: url, options: SDWebImageOptions.init(), progress: nil) { (image, data, error, type, status, url) in
                    if let snap  = image {
                        PHPhotoLibrary.shared().performChanges({
                            PHAssetChangeRequest.creationRequestForAsset(from: snap)
                        }, completionHandler: { success, error in
                            if success {
                                // Saved successfully!
                                DispatchQueue.main.async() {
                                    // your UI update code
                                   Toast.snakbar("Photo Saved")
                                }
                              
                            }
                           
                        })
                    }
                    
                }
            }
            
        }
    }
    
     func toNSMutableAttributedString() -> NSMutableAttributedString{
        return NSMutableAttributedString.init(string: self)
     }
    
    func isValidEmail() -> Bool {
        return  MValidate.isValidEmail(testStr: self)
    }
    func isValidPhone() -> Bool {
            return  MValidate.isValidPhone(value: self)
    }
    func isValid(_ minSize:Int) ->Bool{
        return MValidate.isString(value: self, minSize: minSize)
    }

}
