//
//  ContentView.swift
//  MileStone1_3_RockPaperScissor
//
//  Created by Michael Kahlbacher on 10.12.20.
//

import SwiftUI


struct ContentView: View {
    
    @State private var possibleMoves = ["Rock", "Paper", "Scissor"]
    @State private var computersChoice: Int = Int.random(in: 0...2)
    @State private var userShouldWin = Bool.random()
    @State private var score = 0
    @State private var round = 0
    @State private var showScore = false
    
    
    var body: some View {
        VStack(spacing:30){
            VStack(spacing: 10) {
                Text("Computers choice: \(possibleMoves[computersChoice])")
                Text( "You will \(userShouldWin ? "win" : "loose")")
            }
            VStack(spacing:20){
                ForEach( 0 ..< possibleMoves.count) { number in
                    Button(action: {
                        userTapped(number)
                    }, label: {
                        Text("\(possibleMoves[number])")
                    })
                }
            }
        }.alert(isPresented: $showScore, content: {
            Alert(title: Text("Score"), message: Text("\(score)"), dismissButton: .default(Text("Continue")){
                reStart()
                score = 0
            })
        })
    }
    
    
    
    func reStart(){
        computersChoice = Int.random(in: 0...2)
        userShouldWin.toggle()
        round += 1
        
    }
    
    func userTapped(_ number: Int) {
        
        if round == 10 {
            showScore = true
            round = 0
            reStart()
        } else {
            switch number {
            case 0:
                if userShouldWin && computersChoice == 2 {
                    score += 1
                } else if !userShouldWin && computersChoice == 1 {
                    score += 1
                } else {
                    score -= 1
                }
            case 1:
                if userShouldWin && computersChoice == 0 {
                    score += 1
                } else if !userShouldWin && computersChoice == 2 {
                    score += 1
                } else {
                    score -= 1
                }
            case 2:
                if userShouldWin && computersChoice == 1 {
                    score += 1
                } else if !userShouldWin && computersChoice == 0 {
                    score += 1
                } else {
                    score -= 1
                }
            default:
                return
            }
            reStart()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
