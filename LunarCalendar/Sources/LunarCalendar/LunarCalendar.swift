
import SwiftUI

struct LunarCalendar : View{
    @Environment(\.calendar) var calendar
    @Environment(\.presentationMode) var mode
    
    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }
    
    var body: some View {
        
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
                    }
            }
        })
        .padding([.leading, .trailing], 10.0)
        
    }
}

struct LunarCalendar_Previews: PreviewProvider {
    static var previews: some View {
        LunarCalendar()
    }
}
