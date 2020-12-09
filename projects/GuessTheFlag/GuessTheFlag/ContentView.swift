//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Michael Kahlbacher on 07.12.20.
//

import SwiftUI


struct ImageView: View {
    var image  : String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 2))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitel = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        flagTapped(number)
                    }, label: {
                        ImageView(image:countries[number])
 
                    })
                }
                Text("Score \(score)")
                    .foregroundColor(.white)
                
                Spacer()
            }
            .alert(isPresented: $showingScore, content: {
                Alert(title: Text(scoreTitel), message: Text("Your Score is \(score)"), dismissButton: .default(Text("Continue")){
                    askQuestion()
                })
            })
        }
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitel = "Correct"
            score += 1
        } else {
            scoreTitel = "Wrong, this was the Flag of \(countries[number])"
        }
        showingScore = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
