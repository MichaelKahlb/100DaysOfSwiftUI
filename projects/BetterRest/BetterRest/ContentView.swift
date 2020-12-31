//
//  ContentView.swift
//  BetterRest
//
//  Created by Michael Kahlbacher on 13.12.20.
//

import SwiftUI

struct ContentView: View {
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }

    var bedTime : String {
        
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: sleepTime)
            
        } catch {
            return "Error"
        }
    }
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
   

    
    var body: some View {
        NavigationView {
            Form {
                Text("When do you want to wake up")
                    .font(.headline)
                
                DatePicker("Please enter a Time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                   .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                
                //VStack(alignment: .leading, spacing: 10) {
                Section(header: Text("Desired amout of Sleep")) {
                    //Text("Desired amout of Sleep")
                    //    .font(.headline)
                    Stepper(value: $sleepAmount, in: 4...12 , step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                //Text("Daily Cofee intake")
                //    .font(.headline)
//                Stepper(value: $coffeeAmount, in: 1...20) {
//                    if coffeeAmount == 1 {
//                        Text("1 Cup")
//                    } else {
//                        Text("\(coffeeAmount) Cups")
//                    }
//                }
                Picker("Daily Coffee intake", selection: $coffeeAmount) {
                    ForEach (1 ..< 21) { amount in
                        if amount == 1 {
                             Text("1 Cup")
                        } else {
                             Text("\(amount) Cups")
                        }
                    }
                    
                }
                Section {
                    Text("Your Bedtime should be \(bedTime)")
                        .font(.headline)
                }
            }
            .navigationBarTitle("Better Rest")
            //.navigationBarItems(trailing:
                //Button(action: calculateBedTime){
                //   Text("Calculate")
                //}
            //)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func calculateBedTime() -> String {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short

            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is…"
            return alertMessage
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            return alertMessage
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
