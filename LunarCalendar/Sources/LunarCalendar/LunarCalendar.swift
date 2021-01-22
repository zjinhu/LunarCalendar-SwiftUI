
import SwiftUI

public struct LunarCalendar : View{
    @Environment(\.calendar) var calendar
    @Environment(\.presentationMode) var mode
    
    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }
    
    private let onSelect: (Date) -> Void
    
    public init(select: @escaping (Date) -> Void) {
      self.onSelect = select
    }
    
    public var body: some View {
        
        VStack(alignment: .center, spacing: 0, content: {
            CalendarWeek()
                .frame(height: 30.0)
            
            CalendarGrid(interval: year) { date in
                
                CalenderDay(day: Tool.getDay(date: date),
                            lunar: Tool.getInfo(date: date),
                            isToday: calendar.isDateInToday(date),
                            isWeekDay: Tool.isWeekDay(date: date))
                    .onTapGesture {
                        mode.wrappedValue.dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.onSelect(date)
                        }
                    }
            }
        })
        .padding([.leading, .trailing], 10.0)
        
    }
}

struct LunarCalendar_Previews: PreviewProvider {
    static var previews: some View {
        LunarCalendar(select: {_ in
            
        })
    }
}
