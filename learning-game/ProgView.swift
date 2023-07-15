//
//  ProgView.swift
//  learning-game
//
//  Created by admin on 7/14/23.
//

import SwiftUI

struct ProgView: View {
    var body: some View {
        TabView{
            AddrProgView()
                .tabItem() {
                    Image(systemName: "location")
                    Text("Address")
                }
            NameProgView()
                .tabItem(){
                    Image(systemName: "person")
                    Text("Name")
                }
            PhoneProgView()
                .tabItem(){
                    Image(systemName: "phone")
                    Text("Phone")
                }
        }
    }
}

struct ProgView_Previews: PreviewProvider {
    static var previews: some View {
        ProgView()
    }
}
