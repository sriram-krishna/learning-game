import SwiftUI

struct MainMenuView: View {
    @State private var showGameOptions = false
    @State private var showSettings = false
    @State private var showProgress = false
    
    var body: some View {
        ZStack { // Use ZStack to layer the background photo and the main content
            // Background photo
            Image("Image") // Replace "backgroundPhoto" with the name of your image asset
                //.scaledToFill()
                .resizable()
                .frame(height: nil)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                Text("Welcome to the Children's Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.yellow)
                                        
                Spacer()
                
                Button(action: {
                    showGameOptions = true
                }) {
                    Text("Start")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .sheet(isPresented: $showGameOptions) {
                    GameOptionsView()
                }
                
                Button(action: {
                    showSettings = true
                }) {
                    Text("Settings")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView()
                }

                
                Button(action: {
                    showProgress = true
                }) {
                    Text("Progress")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .sheet(isPresented: $showProgress){
                ProgressView()
            }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct GameOptionsView: View {
    var body: some View {
        VStack {
            Text("Choose a Game Option")
                .font(.title)
                .fontWeight(.bold)
            
            // Add your game options buttons here...
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text("Game Options"))
    }
}

struct SettingsView: View {
    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var address = ""
    
    var body: some View {
        Form {
            Section(header: Text("Profile Information")) {
                TextField("Name", text: $name)
                TextField("Phone Number", text: $phoneNumber)
                TextField("Address", text: $address)
            }
            
            Section {
                Button(action: {
                    // Save the profile information
                    // Add your code here to save the profile data
                }) {
                    Text("Save")
                        .foregroundColor(.blue)
                }
            }
        }
        .navigationBarTitle(Text("Settings"))
    }
}

struct ProgressView: View {
    @State private var numberOfAttempts = 0
    @State private var numberOfCorrectAttempts = 0
    @State private var numberOfIncorrectAttempts = 0
    
    let graphHeight: CGFloat = 200
    
    var body: some View {
        VStack {
            Text("Progress")
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("Number of Attempts: \(numberOfAttempts)")
            
            Text("Number of Correct Attempts: \(numberOfCorrectAttempts)")
            
            Text("Number of Incorrect Attempts: \(numberOfIncorrectAttempts)")
            
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 10) {
                        ForEach(0..<3, id: \.self) { index in
                            VStack {
                                Spacer()
                                Capsule()
                                    .frame(width: 20, height: valueHeight(value: getValue(for: index)), alignment: .bottom)
                                    .foregroundColor(getColor(for: index))
                                Text("\(getValue(for: index))")
                                    .font(.caption)
                                Spacer()
                            }
                        }
                    }
                }
                .frame(height: graphHeight)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text("Progress"))
        .onAppear {
            // Update the values based on actual data or logic
            numberOfAttempts = 50
            numberOfCorrectAttempts = 30
            numberOfIncorrectAttempts = 20
        }
    }
    
    func getValue(for index: Int) -> Int {
        switch index {
        case 0:
            return numberOfAttempts
        case 1:
            return numberOfCorrectAttempts
        case 2:
            return numberOfIncorrectAttempts
        default:
            return 0
        }
    }
    
    func getColor(for index: Int) -> Color {
        switch index {
        case 0:
            return .blue
        case 1:
            return .green
        case 2:
            return .red
        default:
            return .clear
        }
    }
    
    func valueHeight(value: Int) -> CGFloat {
        let maxValue = max(numberOfAttempts, max(numberOfCorrectAttempts, numberOfIncorrectAttempts))
        let ratio = CGFloat(value) / CGFloat(maxValue)
        return ratio * graphHeight
    }
}

struct ContentView: View {
    var body: some View {
        MainMenuView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

