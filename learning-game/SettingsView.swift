//
//  SettingsView.swift
//  learning-game
//
//  Created by Vandit Jindal on 7/2/23.
//

import Foundation
import SwiftUI

struct Profile {
 var name: String
 var phoneNumber: String
 var address: String
}

struct SettingsView: View {
 @State private var profiles: [Profile] = [
     Profile(name: "Profile 1", phoneNumber: "", address: ""),
     Profile(name: "Profile 2", phoneNumber: "", address: ""),
     Profile(name: "Profile 3", phoneNumber: "", address: "")
 ]
 @State private var selectedProfileIndex = 0
 @State private var showProfiles = false
 @State private var showNewProfilePage = false
 
 var body: some View {
     Form {
         Section(header: Text("Profile Information")) {
             Button(action: {
                 showProfiles = true
             }) {
                 Text("Profiles")
                     .font(.title)
                     .fontWeight(.bold)
                     .padding()
                     .background(Color.blue)
                     .foregroundColor(.white)
                     .cornerRadius(10)
             }
             
             if showProfiles {
                 VStack(spacing: 10) {
                     ForEach(profiles.indices, id: \.self) { index in
                         Button(action: {
                             selectedProfileIndex = index
                             showProfiles = false
                         }) {
                             Text(profiles[index].name)
                                 .font(.title)
                                 .fontWeight(.bold)
                                 .padding()
                                 .background(selectedProfileIndex == index ? Color.blue : Color.gray)
                                 .foregroundColor(.white)
                                 .cornerRadius(10)
                         }
                     }
                 }
             }
             
             TextField("Name", text: $profiles[selectedProfileIndex].name)
             TextField("Phone Number", text: $profiles[selectedProfileIndex].phoneNumber)
             TextField("Address", text: $profiles[selectedProfileIndex].address)
         }
         
         Section {
             Button(action: {
                 showNewProfilePage = true
             }) {
                 Text("Profile")
                     .font(.title)
                     .fontWeight(.bold)
                     .padding()
                     .background(Color.green)
                     .foregroundColor(.white)
                     .cornerRadius(10)
             }
         }
     }
     .sheet(isPresented: $showNewProfilePage) {
         NewProfileView(profiles: $profiles)
     }
     .navigationBarTitle(Text("Settings"))
 }
}

struct NewProfileView: View {
 @Binding var profiles: [Profile]
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
                 }) {
                     Text("Save")
                         .foregroundColor(.blue)
                 }
             }
         }
         .navigationBarTitle(Text("New Profile"))
     }
 }
}

struct SettingsContentView: View {
 var body: some View {
     SettingsView()
 }
}

struct SettingsContentView_Previews: PreviewProvider {
 static var previews: some View {
     ContentView()
 }
}


