//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by karma on 5/6/22.
//

import SwiftUI

struct ContentView: View {
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var score = 0
    @State private var tappedCountryIndex = 0
    @State private var completed = false
    @State private var questionCount = 0
    
    @State private var countries = ["Estonia","France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US" ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.mint
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    Text("Guess the flag")
                        .font(.largeTitle.weight(.semibold))
                    VStack(spacing:20){
                        VStack{
                            Text("Tap the flag of")
                                .font(.subheadline.weight(.semibold))
                            Text(countries[correctAnswer])
                                .font(.largeTitle.weight(.semibold))
                        }
                        ForEach(0..<3){number in
                            Button{
                                //flag tapped
                                flagTapped(number)
                                
                            }label: {
                                Image(countries[number])
                                    .clipShape(Capsule())
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity).padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    Spacer()
                    Spacer()
                    Text("Score: \(score)")
                        .font(.subheadline.weight(.semibold))
                    Spacer()
                }
                .padding(30)
                
            }
            .alert(scoreTitle, isPresented: $showingScore){
                Button("Continue", action: askQuestion)
            }message: {
                if scoreTitle == "Correct"{
                    Text("Your score is \(score)")
                }else {
                    Text("That's the flag of \(countries[tappedCountryIndex])!")
                }
                
            }
            .navigationTitle("FlagGame")
            
            .alert("Completed", isPresented: $completed) {
                Button("Play Again", action: resetGame)
            }message: {
                Text("Congrats you completed the game with score of \(score) points")
            }
            
            
            //            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func flagTapped(_ number: Int){
        tappedCountryIndex = number
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        }else {
            scoreTitle = "Wrong"
        }
        if questionCount == 7 {
            completed = true
            return
        }
        showingScore = true
        questionCount += 1
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame(){
        scoreTitle = ""
        showingScore = false
        score = 0
        tappedCountryIndex = 0
        completed = false
        questionCount = 0
        countries.shuffle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
