//
//  ContentView.swift
//  WordScramble
//
//  Created by Derek Santolo on 10/14/20.
//

import SwiftUI

struct StartGameButton: View
{
    var action: () -> Void
    var body: some View
    {
        Button(action: action, label: {
        Text("Start Game").foregroundColor(.black)
        }).background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
    }
}

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    
    @State private var usedWordsMaxLength = 0
    
    var body: some View {
        NavigationView
        {
            VStack
            {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
    
                
                List(usedWords, id: \.self)
                {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                
                Text("Score: \(score)")
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading: StartGameButton(action: startGame))
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func addNewWord()
    {
        let answer = newWord.lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else
        {
            score-=1
            return
        }
        
        guard isNotOriginal(word: answer) else {
            wordError(title: "Word is the same as starting word", message: "Your word cannot match the starting word.")
            score-=1
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original.")
            return
        }
        
        guard isPossible(word: answer)
        else
        {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            score-=1
            return
        }
        
        guard isReal(word: answer)
        else
        {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            score-=1
            return
        }
        
        usedWords.insert(answer, at : 0)
        if (answer.count>usedWordsMaxLength)
        {
            usedWordsMaxLength = answer.count
        }
        calculateScore()
        newWord = ""
    }
    
    func startGame()
    {
        score = 0
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt")
        {
            if let startWords = try?
                String(contentsOf: startWordsURL)
            {
                let allWords = startWords
                    .components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool
    {
        !usedWords.contains(word)
    }
    
    func isNotOriginal(word: String) -> Bool
    {
        !(word==rootWord)
    }
    
    func isPossible(word: String) -> Bool
    {
        var tempWord = rootWord.lowercased()
        
        for letter in word
        {
            if let pos = tempWord.firstIndex(of: letter)
            {
                tempWord.remove(at: pos)
            }
            else
            {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool
    {
        if word.count<3 { return false }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String)
    {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func calculateScore()
    {
        score += usedWords.count * (usedWordsMaxLength/2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
