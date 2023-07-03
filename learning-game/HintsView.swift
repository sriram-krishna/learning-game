//
//  HintsView.swift
//  learning-game
//
//  Created by Vandit Jindal on 7/3/23.
//

import Foundation
import SwiftUI

struct HintsView: View {
    @AppStorage("hintsEnabled") private var hintsEnabled = true

    var body: some View {
        Button(action: {
            hintsEnabled.toggle()
        }) {
            HStack {
                Text("Hints")
                    .foregroundColor(.primary)
                    .font(.headline)
                Spacer()
                Toggle("", isOn: $hintsEnabled)
                    .labelsHidden()
            }
        }
        .padding()
    }
}
