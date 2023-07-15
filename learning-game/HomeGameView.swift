//
//  HomeGameView.swift
//  learning-game
//
//  Created by Vandit Jindal on 7/6/23.
//

import SwiftUI

struct Question {
    let question: String
    let options: [String]
    let correctAnswerIndex: Int
}

struct HomeGameView: View {
    let maxAttemptsPerQuestion = 2
    let questions: [Question] = [
        Question(question: "What is the house number?", options: ["1234", "5678", "9101", "1213"], correctAnswerIndex: 0),
        Question(question: "What is the street name?", options: ["Home", "Street", "Avenue", "Lane"], correctAnswerIndex: 0),
        Question(question: "What is the street type?", options: ["Dr", "Rd", "St", "Ave"], correctAnswerIndex: 0),
        Question(question: "What is the city?", options: ["Frisco", "Dallas", "Plano", "Austin"], correctAnswerIndex: 0),
        Question(question: "What is the state?", options: ["TX", "CA", "NY", "FL"], correctAnswerIndex: 0),
        Question(question: "What is the ZIP code?", options: ["54321", "12345", "98765", "67890"], correctAnswerIndex: 0)
    ]
    
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var showAlert = false
    @State private var currentAttempt = 1
    @State private var isGameFinished = false
    
    var body: some View {
        VStack {
            Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                .font(.headline)
                .padding()
            
            Text(questions[currentQuestionIndex].question)
                .font(.title)
                .padding()
            
            ForEach(0..<questions[currentQuestionIndex].options.count, id: \.self) { index in
                Button(action: {
                    checkAnswer(index)
                }) {
                    Text(questions[currentQuestionIndex].options[index])
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            
            Text("Score: \(score)")
                .font(.headline)
                .padding()
        }
        .alert(isPresented: $showAlert) {
            if isGameFinished{
                return createResultAlert()
            }else {
                return createQuitConfirmationAlert()
            }

            
        }
        Button(action: {
            isGameFinished = true
            showAlert = true
        }){
            Text("Quit")
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
        
    }
        
    
    private func createResultAlert() -> Alert {
        Alert(
            title: Text("Result"),
            message: Text("Your score is \(score) out of \(questions.count)"),
            dismissButton: .default(Text("OK")) {
                resetGame()
            }
        )
    }

    private func createQuitConfirmationAlert() -> Alert {
        Alert(
            title: Text("Quit"),
            message: Text("Are you sure you want to quit the game?"),
            primaryButton: .destructive(Text("Quit")) {
                resetGame()
            },
            secondaryButton: .cancel()
        )
    }

    
    func checkAnswer(_ selectedAnswerIndex: Int) {
        if selectedAnswerIndex == questions[currentQuestionIndex].correctAnswerIndex {
            score += 1
            currentQuestionIndex += 1
            currentAttempt = 1
        } else{
            if currentAttempt < maxAttemptsPerQuestion{
                currentAttempt += 1
            }else{
               currentQuestionIndex += 1
                currentAttempt = 1
            }
        }
        if currentQuestionIndex >= questions.count {
            showAlert = true
        }
    }
    
    func resetGame() {
        currentQuestionIndex = 0
        score = 0
        currentAttempt = 1
        isGameFinished = false
    }
}

struct HomeGameView_Previews: PreviewProvider {
    static var previews: some View {
        HomeGameView()
    }
}
