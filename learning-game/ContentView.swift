import SwiftUI
import LineChartView
import TogglableSecureField

struct MainMenuView: View {
    @State private var showGameOptions = false
    @State private var showSettings = false
    @State private var showProgress = false
    
    var body: some View {
        ZStack {
            Image("HomePage Image")

            Image("Background Image")
                .resizable()
                .frame(height: nil)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                Text("Welcome to")
                    .font(.system(size: 50))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.yellow)
                    .offset(y: -75)
                
                Text("Memory Lane")
                    .font(.system(size: 80))
                    .fontWeight(.bold)
                    .foregroundColor(Color.yellow)
                    .offset(y: -80)
                                        
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
                
                .sheet(isPresented: $showProgress) {
                    ProgView()
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct GameOptionsView: View {
    @State private var showGameOptions = false

    var body: some View {
        VStack {
            Text("Choose a Game Option")
                .font(.title)
                .fontWeight(.bold)
            
            // Add your game options buttons here...
            Button(action: {
                showGameOptions = true
            }) {
                Text("Home Game")
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(20)
        }
        .sheet(isPresented: $showGameOptions){
            HomeGameView()
        }

            
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text("Game Options"))
    }
}

/*struct SettingsView: View {
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
                Button(action: {                }) {
                    Text("Save")
                        .foregroundColor(.blue)
                }
            }
        }
        .navigationBarTitle(Text("Settings"))
    }
}*/


struct ContentView: View {
    var body: some View {
        MainMenuView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
