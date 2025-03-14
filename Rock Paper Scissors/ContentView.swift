//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by James Cao on 11/4/24.
//

import SwiftUI

struct ContentView: View {
    
    // opponent choice list order randomized, then choose the first item
    @State private var opponentChoice = ["Rock", "Paper", "Scissors"].shuffled()[0]
    
    @State private var playerChoice = ""
    // whether the player won, lost, or tied
    @State private var roundState = ""
    
    @State private var score = 0
    @State private var roundsCompleted = 0
    @State private var showingScore = false
    @State private var gameFinished = false
    
    var body: some View {
        VStack {
            
            Spacer()
            Spacer()
            Spacer()
            
            Text("Round \(roundsCompleted + 1)/10")
            Text("Current score: \(score)")
            Text("Rock, paper, scissors, shoot!")
                .padding()
            
            Spacer()
            
            Button {
                playerChoice = "Rock"
                choiceMade(playerChoice)
            } label: {
                Text("Rock")
            }
            .padding()
            
            Button {
                playerChoice = "Paper"
                choiceMade(playerChoice)
            } label: {
                Text("Paper")
            }
            .padding()
            
            Button {
                playerChoice = "Scissors"
                choiceMade(playerChoice)
            } label: {
                Text("Scissors")
            }
            .padding()
            
            Spacer()
            Spacer()
            Spacer()
            
        }
        .padding()
        .alert(roundState, isPresented: $showingScore) {
            Button("Continue", action: nextRound)
        } message: {
            Text("You chose \(playerChoice), your opponent chose \(opponentChoice)! Your score is now \(score).")
        }
        .alert("Game Over", isPresented: $gameFinished) {
            Button("Restart?", action: resetGame)
        } message: {
            Text("Your final score is \(score).")
        }
    }
    
    // rock paper scissors logic applied here
    func choiceMade(_ playerChoice: String) {
        switch opponentChoice {
        case "Rock":
            switch playerChoice {
            case "Paper":
                roundState = "Win"
                score += 1
            case "Scissors":
                roundState = "Lose"
                score -= 1
            default:
                roundState = "Tie"
            }
        case "Paper":
            switch playerChoice {
            case "Scissors":
                roundState = "Win"
                score += 1
            case "Rock":
                roundState = "Lose"
                score -= 1
            default:
                roundState = "Tie"
            }
        case "Scissors":
            switch playerChoice {
            case "Rock":
                roundState = "Win"
                score += 1
            case "Paper":
                roundState = "Lose"
                score -= 1
            default:
                roundState = "Tie"
            }
        default:
            roundState = "Something has gone horribly wrong"
        }
        
        showingScore = true
    }
    
    func nextRound() {
        roundsCompleted += 1
        if (roundsCompleted >= 10) {
            gameFinished = true
            roundsCompleted -= 1 // this is just to make the "Round" text not move on to round 11 at the end of the game
        }
        opponentChoice = ["Rock", "Paper", "Scissors"].shuffled()[0]
    }
    
    func resetGame() {
        opponentChoice = ["Rock", "Paper", "Scissors"].shuffled()[0]
        roundsCompleted = 0
        score = 0
        showingScore = false
        gameFinished = false
    }
}

#Preview {
    ContentView()
}
