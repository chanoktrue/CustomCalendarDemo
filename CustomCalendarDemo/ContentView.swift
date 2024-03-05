//
//  ContentView.swift
//  CustomCalendarDemo
//
//  Created by Thongchai Subsaidee on 5/3/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var color: Color = .blue
    @State private var date = Date.now
    
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
//    let days = 1..<32
    @State private var days: [Date] = []
    
    var body: some View {
        VStack {
            LabeledContent("Calendar Color") {
                ColorPicker("", selection: $color, supportsOpacity: false)
            }
            LabeledContent("Date/Time") {
                DatePicker("", selection: $date)
            }
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .fontWeight(.black)
                        .foregroundStyle(color)
                        .frame(maxWidth: .infinity)
                }
            }
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != date.monthInt {
                        Text("")
                    }else {
                        Text("\(day.formatted(.dateTime.day()))")
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                Circle()
                                    .foregroundColor(color.opacity(0.3))
                            )
                    }
                }
            }
//            Spacer()
        }
        .padding()
        .onAppear {
            days = date.calendarDiplayDays
        }
        .onChange(of: date) {
            days = date.calendarDiplayDays
        }
        
    }
}

#Preview {
    ContentView()
}
