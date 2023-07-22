//
//  ContentView.swift
//  ColorSlider
//
//  Created by Dmitrii Galatskii on 22.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black.gradient)
                .opacity(0.85)
                .ignoresSafeArea()
            
            VStack {
                GeneratedColorView(redChannel: $redSliderValue,
                                   greenChannel: $greenSliderValue,
                                   blueChannel: $blueSliderValue)
                .padding(.bottom, 30)
                
                
                SliderView(sliderValue: $redSliderValue, color: .red)
                SliderView(sliderValue: $greenSliderValue, color: .green)
                SliderView(sliderValue: $blueSliderValue, color: .blue)
                Spacer()
            }
            .padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}






struct SliderView: View {
    
    @Binding var sliderValue: Double
    let color: Color
    
    var body: some View {
        HStack {
            Text("\(lround(sliderValue))")
                .frame(width: 35)
                .foregroundColor(.white)
            
            Slider(value: $sliderValue, in: 0...255, step: 1)
                .animation(.linear, value: sliderValue)
                .tint(color)
                
                
            
            TextField("000", value: $sliderValue, formatter: NumberFormatter())
                .textFieldStyle(.roundedBorder)
                .frame(width: 45)
        }
    }
}






struct GeneratedColorView: View {
    @Binding var redChannel: Double
    @Binding var greenChannel: Double
    @Binding var blueChannel: Double
    
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
