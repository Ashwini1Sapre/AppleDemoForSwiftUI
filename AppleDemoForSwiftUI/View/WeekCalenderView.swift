//
//  WeekCalenderView.swift
//  AppleDemoForSwiftUI
//
//  Created by Knoxpo MacBook Pro on 08/04/21.
//

import SwiftUI

struct WeekCalenderView: View {
    
    private var days = [23, 24, 25, 26, 27, 28, 29]
    private var daysofTheWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    @State private var selectedDay = 24
    
    var body: some View {
        HStack {
            
            ForEach(0..<days.count, id: \.self) { day in
                
                Button(action: {
                    self.selectedDay = days[day]
                    
               
                })
                {
                    VStack {
                        Circle()
                     
                            
                            .fill(days[day] == self.selectedDay ? Color.orange : Color.gray)
                            .aspectRatio(contentMode: .fit)
                         
                            
                            .overlay(
                               Text("\(days[day])")
                                .fontWeight(.semibold).fixedSize()
                                .foregroundColor(days[day] == self.selectedDay ? Color.black : Color.white)
                            
                            )
                            
                            .padding(.vertical, 6)
                            .frame(maxWidth: .infinity)
                            
                            
                        Text(daysofTheWeek[day])
                            .fontWeight(.light)
                            .font(.caption)
                        
                       
                        
                        
                    }
                    
                    
                    
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            
            
            
            
        }
    }
}

struct WeekCalenderView_Previews: PreviewProvider {
    static var previews: some View {
        WeekCalenderView()
    }
}
