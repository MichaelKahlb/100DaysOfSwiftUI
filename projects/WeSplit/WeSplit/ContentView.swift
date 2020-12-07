//
//  ContentView.swift
//  WeSplit
//
//  Created by Michael Kahlbacher on 29.11.20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(Int(numberOfPeople) ?? 1)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmout = Double(checkAmount) ?? 0
        let tipValue = orderAmout / 100 * tipSelection
        let grandTotal = orderAmout + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmout = Double(checkAmount) ?? 0
        let tipValue = orderAmout / 100 * tipSelection
        let grandTotal = orderAmout + tipValue
        return grandTotal
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.numberPad)
//                    Picker("Number of People", selection: $numberOfPeople) {
//                        ForEach(2 ..< 100) {
//                            Text("\($0) people")
//                        }
//                    }
                    //Challege: Add TExtfield instead of Picker.
                    
                }
                
                Section(header: Text("How much Tip do you want to leave")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach (0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per Person")) {
                    Text("$ \(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total Amount")) {
                    Text("$ \(totalAmount, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Wesplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
