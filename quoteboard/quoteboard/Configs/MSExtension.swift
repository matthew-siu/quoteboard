//
//  Extension.swift
//  Available for all projects.
//
//  Created by Matthew Siu on 17/7/2019.
//  Copyright © 2019 Matthew Siu. All rights reserved.
//
import Foundation
import UIKit
import Speech

extension UIViewController{
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    // hide Keyboard by touching anywhere
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
// check String can convert to Double / Float / Int
extension StringProtocol {
    var double: Double? {
        return Double(self)
    }
    var float: Float? {
        return Float(self)
    }
    var integer: Int? {
        return Int(self)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...].range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    
}

// UILabel inline support multiple colors
extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}

extension UIButton {
    
    private func imageWithColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(imageWithColor(color: color), for: state)
        
    }
    
    func underlineButton(text: String) {
        let titleString = NSMutableAttributedString(string: text)
        titleString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, text.count))
        self.setAttributedTitle(titleString, for: .normal)
    }
    
    // you better call this function inside viewDidLayoutSubviews()
    func alignVertical(spacing: CGFloat = 6.0) {
        let imageSize = self.imageView!.frame.size
        let titleSize = self.titleLabel!.frame.size
        let totalHeight = imageSize.height + titleSize.height + spacing
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: 0,
            bottom: 0,
            right: -titleSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageSize.width,
            bottom: -(totalHeight - titleSize.height),
            right: 0
        )
    }
    
    func flash(color: UIColor){
        
        let flash = CABasicAnimation(keyPath: "borderColor")
        flash.duration = 1
        flash.fromValue = UIColor.white.withAlphaComponent(0).cgColor
        flash.toValue = UIColor.white.withAlphaComponent(1).cgColor
        flash.timingFunction = CAMediaTimingFunction(name:  CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = .greatestFiniteMagnitude
        layer.add(flash, forKey: nil)
    }
    
}

// resize image
extension UIImage{
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func resized(toHeight height: CGFloat) -> UIImage? {
//        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let canvasSize = CGSize(width: CGFloat(ceil(height/size.height * size.width)), height: height)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
    
    // set color gradient
    static func gradientImage(with bounds: CGRect,
                              colors: [CGColor],
                              locations: [NSNumber]?) -> UIImage? {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        // This makes it horizontal
        gradientLayer.startPoint = CGPoint(x: 1,
                                           y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0,
                                         y: 0.5)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
    
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
    
    func rotate(radians: CGFloat) -> UIImage{
        
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }

        return self
    }
}

extension UILabel{
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.font = Utils.changeFont(font: self.font)
    }
    
    func roundedTopLeft(_ radius: CGFloat){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft],
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }
    
    public var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}

extension UIView{
    
    var globalFrame :CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
    
    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }

        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }

        return nil
    }
    
    func roundedTop(_ radius: CGFloat){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft, .topRight],
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    func roundedBottom(_ radius: CGFloat){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.bottomLeft, .bottomRight],
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    func roundedAll(_ radius: CGFloat){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    func fade(_ show: Bool, _ duration : Double? = 0.1){
        /*
         fadein = true
         fadeout = false
         */
        self.isHidden = false
        if (show) { self.alpha = 0 }
        UIView.animate(withDuration: duration!, animations: {
            self.alpha = (show) ? 1 : 0
        }) { (val: Bool) in
            if (!show) { self.isHidden = !show}
        }
    }
    
    func fade(_ show: Bool, completion: @escaping () -> ()){
        /*
         fadein = true
         fadeout = false
         */
        self.isHidden = false
        if (show) { self.alpha = 0 }
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = (show) ? 1 : 0
        }) { (val: Bool) in
            if (!show) { self.isHidden = !show}
            completion()
        }
    }
    
    // horizontal gone
    func gone(_ gone: Bool){
        self.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 0)
        self.addConstraints([heightConstraint])
    }
    
    func visiblity(gone: Bool, dimension: CGFloat = 0.0, attribute: NSLayoutConstraint.Attribute = .height) -> Void {
        if let constraint = (self.constraints.filter{$0.firstAttribute == attribute}.first) {
            constraint.constant = gone ? 0.0 : dimension
            self.layoutIfNeeded()
            self.isHidden = gone
        }
    }
    
    
    func addShadow(opacity: Float? = 0.7, offset: CGSize? = CGSize(width: 1, height: 1), color: CGColor? = UIColor.darkGray.cgColor){
        if let opacity = opacity, let offset = offset, let color = color {
            self.layer.shadowOpacity = opacity
            self.layer.shadowOffset = offset
            self.layer.shadowColor = color
        }
    }
    
}

// String
extension String {
    
    func checkRegex(regexStr: String) -> Bool{
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try! NSRegularExpression(pattern: regexStr)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
    
    // String -> HEX String
    func str2Hex() -> String{
        let data = Data(self.utf8)
        let hex = data.map{ String(format:"%02x", $0) }.joined()
//        print("convert \(self) to hex -> \(hex)")
        return hex
    }
    
    // HEX String -> String
    func hex2Str() -> String {
        let regex = try! NSRegularExpression(pattern: "(0x)?([0-9A-Fa-f]{2})", options: .caseInsensitive)
        let textNS = self as NSString
        let matchesArray = regex.matches(in: textNS as String, options: [], range: NSMakeRange(0, textNS.length))
        let characters = matchesArray.map {
            Character(UnicodeScalar(UInt32(textNS.substring(with: $0.range(at: 2)), radix: 16)!)!)
        }
        return String(characters)
    }
    
    func base64ToStr() -> String{
        guard let decodedData = Data(base64Encoded: self), let decodedString = String(data: decodedData, encoding: .utf8) else{
            return ""
        }
        return decodedString
    }
    
    func decode() -> String {
        let data = self.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII) ?? self
    }
    
    func encode() -> String {
        let data = self.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
    
    func urlencode() -> String{
        let mstring = self.replacingOccurrences(of: " ", with: "+")
        let set = CharacterSet(charactersIn: "!*'\"();:@&=+$,/?%#[]% ")
        return mstring.addingPercentEncoding(withAllowedCharacters: set) ?? ""
    }
    
    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let passed = self.unicodeScalars.filter { !forbiddenChars.contains($0) }
        return String(String.UnicodeScalarView(passed))
    }
    
    // remove array of characters
    func removeCharacters(from: String) -> String {
        return removeCharacters(from: CharacterSet(charactersIn: from))
    }
    
    func toIntArr() -> [Int]{
        let str = self.removeCharacters(from: "[\"]") // remove "[", "]", "\""
        let strArr = str.toStrArr()
        if (str.count > 0){
            return strArr.map({Int($0)!})
        }else{
            return [Int]()
        }
    }
    
    func toStrArr() -> [String]{
        let str = self.removeCharacters(from: "[\"]") // remove "[", "]", "\""
        let strArr = str.components(separatedBy: ",")
        return strArr
    }
    
    func trim() -> String?{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    
    func split(usingRegex pattern: String) -> [String] {
        //### Crashes when you pass invalid `pattern`
        let regex = try! NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: self, range: NSRange(0..<utf16.count))
        let ranges = [startIndex..<startIndex] + matches.map{Range($0.range, in: self)!} + [endIndex..<endIndex]
        return (0...matches.count).map {String(self[ranges[$0].upperBound..<ranges[$0+1].lowerBound])}
    }
    
    var bytes: [UInt8] {
        return [UInt8](self.utf8)
    }
    
    func stringToBytes() -> [UInt8]? {
        let length = self.count
        if length & 1 != 0 {
            return nil
        }
        var bytes = [UInt8]()
        bytes.reserveCapacity(length/2)
        var index = self.startIndex
        for _ in 0..<length/2 {
            let nextIndex = self.index(index, offsetBy: 2)
            if let b = UInt8(self[index..<nextIndex], radix: 16) {
                bytes.append(b)
            } else {
                return nil
            }
            index = nextIndex
        }
        return bytes
    }
    
    func URLEncodedString() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }

}

// UITableView
extension UITableView{
    // listen onReloadDataFinished
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData()})
        {_ in completion() }
    }
}

// Dictionary
extension Dictionary {
    // append dictionary into dictionary
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
    
    func jsonStr() -> String?{
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed) else{ return nil }
        return String(data: jsonData, encoding: .ascii)
    }
}

// UITextField
extension UITextField {
    func setBottomBorder(){ setBottomBorder(color: .white) }
    
    func setBottomBorder(color: UIColor) {
        self.borderStyle = .none
        self.layer.backgroundColor = color.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func removeBottomBorder(){
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}

// UInt
extension UInt{
    var toInt: Int {return Int(self)}
}

// UIDatePicker
extension UIDatePicker{
    func getTime(pattern: String) -> String{
        let timeData = DateFormatter()
        timeData.dateFormat = pattern
        return timeData.string(from: self.date)
    }
}

// Date
extension Date {
    /*
     1-7, 1->Sun, 7->Sat
     */
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

extension Error {
    var code: Int { return (self as NSError).code }
    var userInfo: [String: Any] { return (self as NSError).userInfo }
}

// Array
extension Array where Element: Comparable {
    
    //e.g [1,2,3].containSameElements(as: [3,1,2]) -> true
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}


// Textfield
extension UIScrollView {

    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y - 50, width: 1,height: self.frame.height), animated: animated)
        }
    }

    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }

    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }

}

// tap a part of label
extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}

extension Collection {
    func unfoldSubSequences(limitedTo maxLength: Int) -> UnfoldSequence<SubSequence,Index> {
        sequence(state: startIndex) { start in
            guard start < self.endIndex else { return nil }
            let end = self.index(start, offsetBy: maxLength, limitedBy: self.endIndex) ?? self.endIndex
            defer { start = end }
            return self[start..<end]
        }
    }

    func every(n: Int) -> UnfoldSequence<Element,Index> {
        sequence(state: startIndex) { index in
            guard index < endIndex else { return nil }
            defer { index = self.index(index, offsetBy: n, limitedBy: endIndex) ?? endIndex }
            return self[index]
        }
    }

    var pairs: [SubSequence] { .init(unfoldSubSequences(limitedTo: 2)) }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    mutating func insert<S: StringProtocol>(separator: S, every n: Int) {
        for index in indices.every(n: n).dropFirst().reversed() {
            insert(contentsOf: separator, at: index)
        }
    }
    func inserting<S: StringProtocol>(separator: S, every n: Int) -> Self {
        .init(unfoldSubSequences(limitedTo: n).joined(separator: separator))
    }
}

extension Data {
    var bytes: [UInt8] {
        return [UInt8](self)
    }
    
    func toJson() -> Dictionary<String, Any>?{
        guard let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) else{ return nil }
        if let json = json as? Dictionary<String, Any>{
            return json
        }else{
            return nil
        }
    }
}

extension Array where Element == UInt8 {
    var hexString: String {
        return self.reduce(""){$0 + String(format: "%02x", $1)}
    }
    
    var base64String: String {
        return self.data.base64EncodedString(options: Data.Base64EncodingOptions.lineLength76Characters)
    }
    
    var data: Data {
        return Data(self)
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

extension Encodable{
    func toJsonStr() -> String?{
        do{
            let jsonData = try JSONEncoder().encode(self)
            return String(data: jsonData, encoding: .utf8)!
        }catch{
            return nil
        }
        
    }
}


extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        if #available(iOS 14.0, *) {
            addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
        } else {
            // Fallback on earlier versions
            
            @objc class ClosureSleeve: NSObject {
                let closure:()->()
                init(_ closure: @escaping()->()) { self.closure = closure }
                @objc func invoke() { closure() }
            }
            let sleeve = ClosureSleeve(closure)
            addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
            objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
}
