//
//  GeneratedColorView.swift
//  ColorSlider
//
//  Created by Dmitrii Galatskii on 25.07.2023.
//

import SwiftUI

struct GeneratedColorView: View {
    let redChannel: Double
    let greenChannel: Double
    let blueChannel: Double
    
    var fullColor: Color {
        .init(red: redChannel / 255,
              green: greenChannel / 255,
              blue: blueChannel / 255)
    }
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 30)
            .fill(fullColor.gradient)
            .frame(maxWidth: .infinity, maxHeight: 150)
            .shadow(color: .black, radius: 15)
            .overlay(RoundedRectangle(cornerRadius: 30).stroke(.black, lineWidth: 1))
    }
}

struct GeneratedColorView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratedColorView(redChannel: 50, greenChannel: 200, blueChannel: 44)
    }
}
