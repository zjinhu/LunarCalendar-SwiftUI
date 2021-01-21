//
//  CalenderDay.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/20.
//

import SwiftUI

struct CalenderDay: View {
    
    let day: String
    let lunar: String
    let isToday: Bool
    let isWeekDay: Bool
    
    var body: some View {
        ZStack{
            VStack{
                
                Text(day)
                    .frame(width: 40, height: 40, alignment: .center)
                    .font(.title)
                    .foregroundColor(isWeekDay ? Color.red : Color.black)
                
                Text(lunar)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: true, vertical: false)
                    .foregroundColor(isWeekDay ? Color.red : Color.gray)
            }
            .padding(.bottom, 5.0)
            .overlay(
                RoundedRectangle(cornerRadius: 5).stroke( isToday ? Color.orange : Color.clear, lineWidth: 2)
            )
            
//                VStack{
//                    HStack{
//                        Spacer()
//                        ZStack{
//                            Circle()
//                                .frame(width: 15.0, height: 15.0)
//                                .foregroundColor(Color.red)
//
//                            Text("休")
//                                .font(.system(size: 10))
//                                .fontWeight(.medium)
//                                .padding(.all, 2.0)
//                                .foregroundColor(.white)
//                        }
//                    }
//                    Spacer()
//                }

        }
        
    }
    
}

struct CalenderDay_Previews: PreviewProvider {
    static var previews: some View {
        CalenderDay(day: "15", lunar: "腊八腊八", isToday: true, isWeekDay: true)
    }
}
