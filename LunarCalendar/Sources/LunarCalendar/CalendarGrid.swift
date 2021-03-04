//
//  CalendarView.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/18.
//

import SwiftUI

public struct CalendarGrid<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let interval: DateInterval
    let showHeaders: Bool
    let content: (Date) -> DateView
    
    public init(interval: DateInterval, showHeaders: Bool = true, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self.showHeaders = showHeaders
        self.content = content
    }
    
    public var body: some View {
        ///添加到可以滚动
        ScrollView(.vertical, showsIndicators: false){
            ///添加滚动监听
            ScrollViewReader { (proxy: ScrollViewProxy) in
                ///生成网格
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 2, alignment: .center), count: 7)) {
                    ///枚举每个月
                    ForEach(months, id: \.self) { month in
                        ///以每月为一个Section,添加月份
                        Section(header: header(for: month)) {
                            ///添加日
                            ForEach(days(for: month), id: \.self) { date in
                                ///如果不在当月就隐藏
                                if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                                    content(date).id(date)
                                } else {
                                    content(date).hidden()
                                }
                            }
                        }
                        .id(sectionID(for: month))///给每个月创建ID,方便进行滚动标记
                    }
                }
                .onAppear(){
                    ///当View展示的时候直接滚动到标记好的月份
                    proxy.scrollTo(scroolSectionID() )
                }
            }
        }
        
    }
    ///获取当前是几月,并进行滚动到那里
    private func scroolSectionID() -> Int {
        let component = calendar.component(.month, from: Date())
        return component
    }
    ///根据月份生成SectionID
    private func sectionID(for month: Date) -> Int {
        let component = calendar.component(.month, from: month)
        return component
    }
    ///获得年间距的月份日期的第一天,生成数组
    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }
    ///创建一个简单的SectionHeader
    private func header(for month: Date) -> some View {
        let component = calendar.component(.month, from: month)
        let formatter = component == 1 ? DateFormatter.monthAndYear : .month
        
        return Group {
            if showHeaders {
                Text(formatter.string(from: month))
                    .font(.title)
                    .padding()
            }
        }
    }
    ///获取每个月,网格范围内的起始结束日期数组
    private func days(for month: Date) -> [Date] {
        ///重点讲解
        ///先拿到月份间距,例如1号--31号
        guard let monthInterval = calendar.dateInterval(of: .month, for: month) else { return [] }
        ///先获取第一天所在周的周一到周日
        let monthFirstWeek = monthInterval.start.getWeekStartAndEnd(isEnd: false)
        ///获取月最后一天所在周的周一到周日
        let monthLastWeek = monthInterval.end.getWeekStartAndEnd(isEnd: true)
        ///然后根据月初所在周的周一为0号row 到月末所在周的周日为最后一个row生成数组
        return calendar.generateDates(
            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarGrid(interval: .init()) { _ in
            Text("30")
                .padding(8)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}


extension Date {
    
    func getWeekDay() -> Int{
        let calendar = Calendar.current
        ///拿到现在的week数字
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday!
    }
    
    ///获取当前Date所在周的周一到周日
    func getWeekStartAndEnd(isEnd: Bool) -> DateInterval{
        var date = self
        ///因为一周的起始日是周日,周日已经算是下一周了
        ///如果是周日就到退回去两天
        if isEnd {
            if date.getWeekDay() <= 2 {
                date = date.addingTimeInterval(-60 * 60 * 24 * 2)
            }
        }else{
            if date.getWeekDay() == 1 {
                date = date.addingTimeInterval(-60 * 60 * 24 * 2)
            }
        }
        ///使用处理后的日期拿到这一周的间距: 周日到周六
        let week = Calendar.current.dateInterval(of: .weekOfMonth, for: date)!
        ///处理一下周日加一天到周一
        let monday = week.start.addingTimeInterval(60 * 60 * 24)
        ///周六加一天到周日
        let sunday = week.end.addingTimeInterval(60 * 60 * 24)
        ///生成新的周一到周日的间距
        let interval = DateInterval(start: monday, end: sunday)
        return interval
    }
}

extension DateFormatter {
    
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M月"
        return formatter
    }
    
    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月"
        return formatter
    }
}

extension Calendar {
    func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates: [Date] = []
        
        dates.append(interval.start)
        
        enumerateDates(startingAfter: interval.start, matching: components, matchingPolicy: .nextTime) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        return dates
    }
}
