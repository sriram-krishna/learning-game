//
//  SettingsView.swift
//  learning-game
//
//  Created by Vandit Jindal on 7/2/23.
//

import Foundation
import SwiftUI

struct Profile: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var phoneNumber: String
    var address: String
    
    static func == (lhs: Profile, rhs: Profile) -> Bool{
        return lhs.id == rhs.id
    }
}
struct SettingsView: View {
    @State private var profiles: [Profile] = []
    @State private var selectedProfile: Profile?
    @State private var showNewProfilePage = false
    
    var body: some View {
        Form {
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
        }
        .navigationBarTitle(Text("Settings"))
    }
}

struct NewProfileView: View {
    @Binding var profiles: [Profile]
    @Binding var showNewProfilePage: Bool
    @State private var newProfileName = ""
    @State private var newProfilePhoneNumber = ""
    @State private var newProfileAddress = ""
    
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
