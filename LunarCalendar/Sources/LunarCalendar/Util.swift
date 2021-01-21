//
//  DateEx.swift
//  LunarCalendar
//
//  Created by iOS on 2021/1/21.
//

import Foundation

struct Tool {
    
    static func getWeek(week: Int) -> String{
        switch week {
        case 1:
            return "周一"
        case 2:
            return "周二"
        case 3:
            return "周三"
        case 4:
            return "周四"
        case 5:
            return "周五"
        case 6:
            return "周六"
        case 7:
            return "周日"
        default:
            return ""
        }
    }
    
    static let chineseHoliDay:[String:String] = ["1-1":"春节",
                                                 "1-15":"元宵节",
                                                 "2-2":"龙抬头",
                                                 "5-5":"端午",
                                                 "7-7":"七夕",
                                                 "7-15":"中元",
                                                 "8-15":"中秋",
                                                 "9-9":"重阳",
                                                 "12-8":"腊八",
                                                 "12-23":"小年(北)",
                                                 "12-24":"小年(南)",
                                                 "12-30":"除夕"]
    
    static let gregorianHoliDay:[String:String] = ["1-1":"元旦",
                                                   "2-14":"情人节",
                                                   "3-8":"妇女节",
                                                   "3-12":"植树节",
                                                   "4-4":"清明",
                                                   "5-1":"劳动节",
                                                   "5-4":"青年节",
                                                   "6-1":"儿童节",
                                                   "7-1":"建党节",
                                                   "8-1":"建军节",
                                                   "10-1":"国庆",
                                                   "12-24":"平安夜",
                                                   "12-25":"圣诞节"]
    
    ///得到今天日期
    static func getDay(date: Date) -> String{
        return String(Calendar.current.component(.day, from: date))
    }
    
    ///获取农历, 节假日名
    static func getInfo(date: Date) -> String{
        //初始化农历日历
        let lunarCalendar = Calendar.init(identifier: .chinese)
        
        ///获得农历月
        let lunarMonth = DateFormatter()
        lunarMonth.locale = Locale(identifier: "zh_CN")
        lunarMonth.dateStyle = .medium
        lunarMonth.calendar = lunarCalendar
        lunarMonth.dateFormat = "MMM"
        
        let month = lunarMonth.string(from: date)
        
        //获得农历日
        let lunarDay = DateFormatter()
        lunarDay.locale = Locale(identifier: "zh_CN")
        lunarDay.dateStyle = .medium
        lunarDay.calendar = lunarCalendar
        lunarDay.dateFormat = "d"
        
        let day = lunarDay.string(from: date)
        ///生成公历日历的Key 用于查询字典
        let gregorianFormatter = DateFormatter()
        gregorianFormatter.locale = Locale(identifier: "zh_CN")
        gregorianFormatter.dateFormat = "M-d"
        
        let gregorian = gregorianFormatter.string(from: date)
        
        ///生成农历的key
        let lunarFormatter = DateFormatter()
        lunarFormatter.locale = Locale(identifier: "zh_CN")
        lunarFormatter.dateStyle = .short
        lunarFormatter.calendar = lunarCalendar
        lunarFormatter.dateFormat = "M-d"
        
        let lunar = lunarFormatter.string(from: date)
        
        ///如果是节假日返回节假日名称
        if let holiday = getHoliday(lunarKey: lunar, gregorKey: gregorian) {
            return holiday
        }
        
        //返回农历月
        if day == "初一" {
            return month
        }
        
        //返回农历日期
        return day
        
    }
    
    static func getHoliday(lunarKey: String, gregorKey: String) -> String?{
        
        ///当前农历节日优先返回
        if let holiday = chineseHoliDay[lunarKey]{
            return holiday
        }
        
        ///当前公历历节日返回
        if let holiday = gregorianHoliDay[gregorKey]{
            return holiday
        }
        
        return nil
    }
    
    static func isWeekDay(date: Date) -> Bool{
        switch date.getWeekDay() {
        case 7, 1:
            return true
        default:
            return false
        }
    }
}


