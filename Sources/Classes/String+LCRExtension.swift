//
//  String+LCRExtension.swift
//  LCRCategoryKit
//
//  Created by LinChengRain on 11/10/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//
#if canImport(UIKit)
import UIKit
import CommonCrypto

extension String {
    /*
     *去掉首尾空格
     */
    public var removeHeadAndTailSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉首尾空格 包括后面的换行 \n
     */
    public var removeHeadAndTailSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉所有空格
     */
    public var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    /*
     *去掉首尾空格 后 指定开头空格数
     */
    public func beginSpaceNum(num: Int) -> String {
        var beginSpace = ""
        for _ in 0..<num {
            beginSpace += " "
        }
        return beginSpace + self.removeHeadAndTailSpacePro
    }
    
    /// 字符URL格式化,中文路径encoding
    ///
    /// - Returns: 格式化的 url
    public  func stringEncoding() -> String {
        let url = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        return url!
    }
    
    //1, 截取规定下标之后的字符串
    public func subStringFrom(index: Int)-> String {
        
        let temporaryString: String = self
        
        let temporaryIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        
        return String(temporaryString[temporaryIndex...])
        
    }
    
    //2, 截取规定下标之前的字符串
    public func subStringTo(index: Int) -> String {
        let temporaryString = self
        let temporaryIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        return String(temporaryString[...temporaryIndex])
        
    }
    
    /// 替换手机号中间四位
    ///
    /// - Returns: 替换后的值
    public func replacePhone() -> String {
        let start = self.index(self.startIndex, offsetBy: 3)
        let end = self.index(self.startIndex, offsetBy: 7)
        let range = Range(uncheckedBounds: (lower: start, upper: end))
        return self.replacingCharacters(in: range, with: "****")
    }
    
    /// 修改段落样式
    /// - Parameters:
    ///   - text: 文本
    /// - Returns: 内容
    public func changeParagraphStyle( _ headIndent:CGFloat = 0,
                               _ tailIndent:CGFloat = 0,
                               _ firstLineHeadIndent:CGFloat = 0) -> NSMutableAttributedString {
        
        let attributeStr = NSMutableAttributedString(string: self)
        
        let descStyle = NSMutableParagraphStyle()
        descStyle.headIndent = headIndent
        descStyle.tailIndent = tailIndent
        descStyle.allowsDefaultTighteningForTruncation = true
    //        descStyle.lineSpacing = 8.0;  //设置行间距
        ///  文本对齐方式
        descStyle.alignment = .justified
        /// 段落后面的间距
//        descStyle.paragraphSpacing = 11.0//段首行空白空间
        /// 设置段与段之间的距离
//        descStyle.paragraphSpacingBefore = 10.0
        /// 首行文本缩进
        descStyle.firstLineHeadIndent = firstLineHeadIndent
        
        attributeStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: descStyle, range: NSRange(location: 0, length: length))

        return attributeStr
    }
}

extension String {
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func endIndex(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    func indexes(of string: String, options: CompareOptions = .literal) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.upperBound
        }
        return result
    }
    func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.upperBound
        }
        return result
    }
}
extension String{
    /**
     将当前字符串拼接到cache目录后面
     */
    public func cacheDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        return (path as NSString).appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到doc目录后面
     */
    public func docDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
        return (path as NSString).appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到tmp目录后面
     */
    public func tmpDir() -> String{
        let path = NSTemporaryDirectory() as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
}
// 给String添加各种类型转换.
extension String {
    public var length: Int {
        ///更改成其他的影响含有emoji协议的签名
        return self.utf16.count
    }
    public var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    public var intValue: Int32 {
        return (self as NSString).intValue
    }
    public var floatValue: Float {
        return (self as NSString).floatValue
    }
    public var integerValue: Int {
        return (self as NSString).integerValue
    }
    public var longLongValue: Int64 {
        return (self as NSString).longLongValue
    }
    public var boolValue: Bool {
        return (self as NSString).boolValue
    }
}

//MARK: - 时间分类
extension String {
    
    /// 获取当前时间
    public static func getCurrentTime() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeZone = NSTimeZone(name: "Asia/Beijing")
        formatter.timeZone = timeZone as TimeZone?
        let dateTime = formatter.string(from: Date())
        
        return dateTime
    }
    
    /// 获取指定时间间隔
    /// - Parameter aDate: 当前时间
    /// - Parameter timeSpace: 时间间隔
    public static func getAppointedDay(_ aDate: Date? = Date(),timeSpace:Int = 1) -> String? {
        let gregorian = Calendar(identifier: .gregorian)
        var components: DateComponents? = nil
        if let aDate = aDate {
            components = gregorian.dateComponents([.weekday, .year, .month, .day,.hour,.minute,.second], from: aDate)
            components!.day = (components!.day!) + timeSpace
        }
        
        var beginningOfWeek: Date? = nil
        if let components = components {
            beginningOfWeek = gregorian.date(from: components)
        }
        let dateday = DateFormatter()
        dateday.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let beginningOfWeek = beginningOfWeek {
            return dateday.string(from: beginningOfWeek)
        }
        return nil
    }
    
    /// 获取指定时间起始时间
    /// - Parameter aDate: 当前时间
    /// - Parameter timeSpace: 时间间隔
    public static func getMorningDate(_ aDate: Date? = Date(),timeSpace:Int = 1) -> String? {
        let gregorian = Calendar(identifier: .gregorian)
        var components: DateComponents? = nil
        if let aDate = aDate {
            components = gregorian.dateComponents([.weekday, .year, .month, .day], from: aDate)
            components!.day = (components!.day!) + timeSpace
        }
        
        var beginningOfWeek: Date? = nil
        if let components = components {
            beginningOfWeek = gregorian.date(from: components)
        }
        let dateday = DateFormatter()
        dateday.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let beginningOfWeek = beginningOfWeek {
            return dateday.string(from: beginningOfWeek)
        }
        return nil
    }
    
    /// 日期字符串转化为Date类型
    ///
    /// - Parameters:
    ///   dateString: 日期字符串
    ///   dateFormat: 格式化样式，默认为“yyyy-MM-dd HH:mm:ss”
    /// - Returns: Date类型
    public static func dateFromString(_ dateString:String,dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = dateFormat
        let destDate = dateFormatter.date(from: dateString )
        return destDate!
    }
    
    /// Date类型转化为日期字符串
    ///
    /// - Parameters:
    ///   date: Date类型
    ///   dateFormat: 格式化样式默认“yyyy-MM-dd”
    /// - Returns: 日期字符串
    public static func dateToString(_ date:Date, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> String {
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date.components(separatedBy: " ").first!
        
    }
    
    /// 指定时间距离当前时间秒数（指定时间在当前时间之后）
    /// - Parameter startDate: 结束时间
    public static func compareNowDateToEndDate(forSecound endDate: String) -> String? {
        let nowDateStr = self.getCurrentTime()
        let startDate = self.dateFromString(nowDateStr!, dateFormat: "yyyy-MM-dd HH:mm:ss")
        let toDate = self.dateFromString(endDate, dateFormat: "yyyy-MM-dd HH:mm:ss")
        //利用NSCalendar比较日期的差异
        let calendar = Calendar.current
        //比较的结果是NSDateComponents类对象
        let delta: DateComponents = calendar.dateComponents([.second], from: startDate, to: toDate)
        return String(format: "%ld", delta.second ?? 0)
    }
    
    /// 指定时间距离当前时间秒数（指定时间在当前时间之前）
    /// - Parameter startDate: 开始时间
    public static func compareNowDateToStartDate(forSecound startDate: String) -> String? {
        let nowDateStr = self.getCurrentTime()
        let endDate = self.dateFromString(nowDateStr!, dateFormat: "yyyy-MM-dd HH:mm:ss")
        let fromDate = self.dateFromString(startDate, dateFormat: "yyyy-MM-dd HH:mm:ss")
        //利用NSCalendar比较日期的差异
        let calendar = Calendar.current
        //比较的结果是NSDateComponents类对象
        let delta: DateComponents = calendar.dateComponents([.second], from: fromDate, to: endDate)
        return String(format: "%ld", delta.second ?? 0)
    }
    
    /// 字符串转时间戳
    /// - Parameter stringTime: 字符串时间戳
    public static func stringToTimeStamp(stringTime:String)->String {

        let dateday = DateFormatter()
        dateday.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateday.date(from: stringTime)
        
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        return String(dateSt)
        
    }
    
    /// 时间转换
    /// - Parameter timeStamp: 时间戳字符串
    public static func compareCurrntTime(timeStamp:String) ->String{
        
        //计算出时间戳距离现在时间的一个秒数(..s)
        let interval:TimeInterval=TimeInterval.init(timeStamp)!
        let date = Date(timeIntervalSince1970: interval)
        
        var timeInterval = date.timeIntervalSinceNow
        //得到的是一个负值 (加' - ' 得正以便后面计算)
        timeInterval = -timeInterval
        //根据时间差 做所对应的文字描述 (作为返回文字描述)
        var result:String
        //一分钟以内
        if timeInterval < 60{
            result = "刚刚"
            return result
        } else if Int(timeInterval/60) < 60 {
            //一小时以内
            result = String.init(format:"%@分钟前",String(Int(timeInterval/60)))
            return result
        }else if Int((timeInterval/60)/60) < 24 {
            //一天以内
            result = String.init(format:"%@小时前",String(Int((timeInterval/60)/60)))
            return result
        }
//        else if Int((timeInterval/60)/60/24) < 30 {
//            result = String.init(format:"%@天前",String(Int((timeInterval/60)/60/24)))
//            return result
//        }
        else {
            //超过一天的
            let dateformatter = DateFormatter()
            //自定义日期格式
            dateformatter.dateFormat="yyyy-MM-dd日 HH:mm"
            result = dateformatter.string(from: date as Date)
            return  result
        }
    }
    
    /// 时间转换
    /// - Parameter timeStamp: 时间戳字符串
    public static func dateStyleTransform(dateString:String?) ->String{
        
        guard let str = dateString else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let curDate = formatter.date(from: str)
        formatter.dateFormat = "YYYY.MM.dd HH:mm:ss"
        guard let date = curDate else { return "" }
        
        return formatter.string(from: date)
        
    }
    
    /// 日期转换
    /// - Parameter dateStr: “yyyy-mm-dd hh:mm:ss”
    /// - Parameter format: 格式
    public static func dateTransform(dateString:String?,format:String?) ->String{
        
        guard let str = dateString else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let curDate = formatter.date(from: str)
        if format != nil {
            formatter.dateFormat = format
        } else {
            formatter.dateFormat = "yyyy年MM月dd日"
        }
        guard let date = curDate else { return "" }
        return formatter.string(from: date)
    }
}

//MARK: - 银行卡分类
extension String {
    
    /// 根据卡号判断银行
    /// - Parameter cardName: 银行卡code
    public static func returnBankName(_ cardName: String?) -> String? {
        let filePath = Bundle.main.path(forResource: "bank", ofType: "plist")
        let resultDic = NSDictionary(contentsOfFile: filePath ?? "") as? Dictionary<String,String>
        let bankBin = resultDic?.keys
        if (cardName?.count ?? 0) < 6 {
            return ""
        }
        var cardbin_6 = ""
        if (cardName?.count ?? 0) >= 6 {
            cardbin_6 = (cardName as NSString?)?.substring(with: NSRange(location: 0, length: 6)) ?? ""
        }
        var cardbin_8: String? = nil
        if (cardName?.count ?? 0) >= 8 {
            //8位
            cardbin_8 = (cardName as NSString?)?.substring(with: NSRange(location: 0, length: 8))
        }
        if bankBin?.contains(cardbin_6) ?? false {
            return resultDic?[cardbin_6]
        } else if bankBin?.contains(cardbin_8 ?? "") ?? false {
            return resultDic?[cardbin_8 ?? ""]
        } else {
            return ""
        }
    }
    
    
}
///MARK: - 正则
extension String {
    
    //MARK: - 非中文或英文
    /// 非中文或英文
    public static func isIncludeSpecialCharacters(in string: String) -> Bool {
        let pattern = "[^A-Za-z\\u4E00-\\u9FA5\\d]"
        let expression = try! NSRegularExpression(pattern: pattern, options: .allowCommentsAndWhitespace)
        let numberOfCharacters = expression.numberOfMatches(in: string, options: .reportProgress, range: NSMakeRange(0, (string as NSString).length))
        
        return numberOfCharacters == 0 ? false : true
    }
    
    //MARK:- 正则匹配用户密码6-18位数字和字母组合
    public static func checkPassword(password:NSString) ->Bool {
        let pattern = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: password)
        return isMatch;
    }
    
    //MARK:- 正则匹配用户姓名,20位的中文或英文
    public static func checkUserName(userName:NSString) ->Bool {
        let pattern = "^[a-zA-Z\\u4E00-\\u9FA5]{1,20}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: userName)
        return isMatch;
    }
    
    //MARK: - 浮点形判断(整形/浮点型等数字均会返回YES,其他为no):
    public static func isPurnFloat(string: String) -> Bool {
        let scan: Scanner = Scanner(string: string)
        var val:Float = 0
        return scan.scanFloat(&val) && scan.isAtEnd
    }
    //MARK: - 是否是整数
    public static func isPurnInt(string: String) -> Bool {
        let scan: Scanner = Scanner(string: string)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
}

//MARK: - emoji
extension String {
    
    /// 判断是不是九宫格
    ///
    /// - Returns: true false
    func isNineKeyBoard()->Bool{
        let other : NSString = "➋➌➍➎➏➐➑➒"
        let len = self.length
        for _ in 0 ..< len {
            if !(other.range(of: self).location != NSNotFound) {
                return false
            }
        }
        return true
    }
    /// 判断是不是Emoji
    ///
    /// - Returns: true false
    func hasEmoji() -> Bool {
        
        let pattern = "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"
        let pred = NSPredicate(format: "SELF MATCHES %@",pattern)
        return pred.evaluate(with: self)
    }
    
    /// 判断是不是Emoji
    ///
    /// - Returns: true false
    func containsEmoji()->Bool{
        for scalar in unicodeScalars {
            switch scalar.value {
                case 0x1F600...0x1F64F,
                     0x1F300...0x1F5FF,
                     0x1F680...0x1F6FF,
                     0x2600...0x26FF,
                     0x2700...0x27BF,
                     0xFE00...0xFE0F:
                    return true
                default:
                    continue
            }
        }
        return false
    }
    
    /// 过滤字符串中的emoji
    ///
    /// - Parameter str: 原始字符串
    /// - Returns: 无表情字符串
    static func disable_emoji(str:String) -> String {
        let regex = try!NSRegularExpression.init(pattern: "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]", options: .caseInsensitive)
        let modifiedString = regex.stringByReplacingMatches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange.init(location: 0, length: str.count), withTemplate: "")
        return modifiedString
    }
    
    /// 将中文字符串转换为拼音
    ///
    /// - Parameter hasBlank: 是否带空格（默认不带空格）
    public func lcr_transformToPinyin( hasBlank: Bool = false) -> String {
        
        let stringRef = NSMutableString(string: self) as CFMutableString
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false) // 转换为带音标的拼音
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false) // 去掉音标
        let pinyin = stringRef as String
        return hasBlank ? pinyin : pinyin.replacingOccurrences(of: " ", with: "")
    }
    
    /// 获取中文首字母
    ///
    /// - Parameter lowercased: 是否小写（默认大写）
    public func lcr_transformToPinyinHead(str:String, lowercased: Bool = false) -> String {
        let strPinYin = str.lcr_transformToPinyin(hasBlank: true).capitalized // 字符串转换为首字母大写
        // 截取大写首字母
        let firstString = strPinYin.substring(to: strPinYin.index(strPinYin.startIndex, offsetBy:1))
        // 判断姓名首位是否为大写字母
        let regexA = "^[A-Z]$"
        let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        return predA.evaluate(with: firstString) ? firstString : "#"
    }
    
    
    /// 数字 千分位显示
    /// - Parameter str: 需要修改的数据
    /// - Returns: "111,111,111"
    public static func countNumChangeformat(str:String) -> String {
        /// 是否是整数
        if !String.isPurnFloat(string: str) {
           return str
        }
        
        //原始值
        let number = NSNumber(value: Double(str)!)
        //创建一个NumberFormatter对象
        let numberFormatter = NumberFormatter()
        numberFormatter.positiveFormat = "###,###.##" //设置格式
        //格式化
        let format = numberFormatter.string(from: number)
        return format ?? str
    }
}

/// 加密
extension String {
    /**
     MD5加密
     - returns: 返回MD5加密字符串 32位小写加密
     */
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
    }
}
//MARK: -
extension String {
    
    public var convertHtmlToNSAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data,options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    public func convertHtmlToAttributedStringWithCSS(font: UIFont? , csscolor: String , lineheight: Int, csstextalign: String) -> NSAttributedString? {
        guard let font = font else {
            return convertHtmlToNSAttributedString
        }
        
        let modifiedString = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; color: \(csscolor); line-height: \(lineheight)px; text-align: \(csstextalign); }</style>\(self)";
        guard let data = modifiedString.data(using: .utf8) else {
            return nil
        }
        
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error)
            return nil
        }
    }
}

extension Float {
 
    /// 小数点后如果只是0，显示整数，如果不是，显示原来的值
    public var cleanZero : String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
}

extension Double {
 
    /// 小数点后如果只是0，显示整数，如果不是，显示原来的值
    public var cleanZero : String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
}
#endif
