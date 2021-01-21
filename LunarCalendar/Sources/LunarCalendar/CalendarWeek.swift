//
//  CalendarWeek.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/19.
//

import SwiftUI

struct CalendarWeek: View {
    var body: some View {
        HStack{
            ForEach(1...7, id: \.self) { count in
                Text(Tool.getWeek(week: count))
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct CalendarWeek_Previews: PreviewProvider {
    static var previews: some View {
        CalendarWeek()
    }
}
