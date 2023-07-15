//
//  SettingsView.swift
//  learning-game
//
HomeGameView
//  Created by Vandit Jindal on 7/6/23.
//

//
//  SettingsView.swift
//  learning-game
//

main
//  Created by Vandit Jindal on 7/2/23.
//

import Foundation
import SwiftUI

HomeGameView
struct Profile: Identifiable, Equatable, Codable {

struct Profile: Identifiable, Equatable {
main
    var id = UUID()
    var name: String
    var phoneNumber: String
    var address: String
    
HomeGameView
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case phoneNumber
        case address
    }
    
    init(name: String, phoneNumber: String, address: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.address = address
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        address = try container.decode(String.self, forKey: .address)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(address, forKey: .address)
    }
}


    static func == (lhs: Profile, rhs: Profile) -> Bool{
        return lhs.id == rhs.id
    }
}
main
struct SettingsView: View {
    @State private var profiles: [Profile] = []
    @State private var selectedProfile: Profile?
    @State private var showNewProfilePage = false
    
    var body: some View {
        Form {
            Section(header: Text("Hints")) {
                HintsView()
            }
HomeGameView
            
            Section(header: Text("Profile Information")) {
                if profiles.isEmpty {
                    Button(action: {
                        showNewProfilePage = true
                    }) {
                        Text("Add Profile")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .sheet(isPresented: $showNewProfilePage) {
                        NewProfileView(profiles: $profiles, showNewProfilePage: $showNewProfilePage, saveAction: saveProfiles)
                    }
                } else {
                    ForEach(profiles.indices, id: \.self) { index in
                        Button(action: {
                            selectedProfile = profiles[index]
                        }) {
                            Text(profiles[index].name)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                                .background(selectedProfile == profiles[index] ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            
            if profiles.count >= 3 {
                Text("Maximum number of profiles (3) reached.")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            
            if let selectedProfile = selectedProfile {
                Section(header: Text(selectedProfile.name)) {
                    Text("Phone Number: \(selectedProfile.phoneNumber)")
                    Text("Address: \(selectedProfile.address)")
                }
            }


            Section(header: Text("Profile Information")) {
                VStack {
                    if profiles.isEmpty {
                        Button(action: {
                            showNewProfilePage = true
                        }) {
                            Text("Add Profile")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .sheet(isPresented: $showNewProfilePage) {
                            NewProfileView(profiles: $profiles, showNewProfilePage: $showNewProfilePage)
                        }
                    } else {
                        ForEach(profiles.indices, id: \.self) { index in
                            Button(action: {
                                selectedProfile = profiles[index]
                            }) {
                                Text(profiles[index].name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding()
                                    .background(selectedProfile == profiles[index] ? Color.blue : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        
                        Button(action: {
                            showNewProfilePage = true
                        }) {
                            Text("Add Profile")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .sheet(isPresented: $showNewProfilePage) {
                            NewProfileView(profiles: $profiles, showNewProfilePage: $showNewProfilePage)
                        }
                        
                        if let selectedProfile = selectedProfile, let selectedProfileIndex = profiles.firstIndex(of: selectedProfile) {
                            TextField("Name", text: $profiles[selectedProfileIndex].name)
                            TextField("Phone Number", text: $profiles[selectedProfileIndex].phoneNumber)
                            TextField("Address", text: $profiles[selectedProfileIndex].address)
                        } else {
                            Text("No profile selected")
                        }


                    }
                }
            }
main
        }
        .navigationBarTitle(Text("Settings"))
    }
}
HomeGameView
private func saveProfiles() {
        // Your code to save the profiles
    }

main

struct NewProfileView: View {
    @Binding var profiles: [Profile]
    @Binding var showNewProfilePage: Bool
    @State private var newProfileName = ""
    @State private var newProfilePhoneNumber = ""
    @State private var newProfileAddress = ""
HomeGameView
    var saveAction: () -> Void

main
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Profile")) {
                    TextField("Name", text: $newProfileName)
                    TextField("Phone Number", text: $newProfilePhoneNumber)
                    TextField("Address", text: $newProfileAddress)
                }
                
                Section {
                    Button(action: {
                        let newProfile = Profile(name: newProfileName, phoneNumber: newProfilePhoneNumber, address: newProfileAddress)
                        profiles.append(newProfile)
                        newProfileName = ""
                        newProfilePhoneNumber = ""
                        newProfileAddress = ""
HomeGameView
                        saveAction() // Save the profiles

main
                        showNewProfilePage = false
                    }) {
                        Text("Save")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationBarTitle(Text("New Profile"))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showNewProfilePage = false
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                }
            }
        }
    }
}
