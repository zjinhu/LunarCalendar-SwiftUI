//
//  ContentView.swift
//  LunarCalendar
//
//  Created by iOS on 2021/1/21.
//

import SwiftUI

struct ContentView: View {
    @State var isPresented = false
    var body: some View {
        
        Button(action: {
            isPresented.toggle()
        }) {
            Text("弹出日历")
        }
        .padding(20.0)
        .sheet(isPresented: $isPresented) {
            LunarCalendar(select: { date in
                print("\(date)")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
