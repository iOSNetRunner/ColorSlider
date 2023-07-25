//
//  ContentView.swift
//  ColorSlider
//
//  Created by Dmitrii Galatskii on 22.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    private enum Field {
        case red, green, blue
    }
    
    @State private var redSliderValue = Double.random(in: 0...255).rounded()
    @State private var greenSliderValue = Double.random(in: 0...255).rounded()
    @State private var blueSliderValue = Double.random(in: 0...255).rounded()
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black.gradient)
                .opacity(0.90)
                .ignoresSafeArea()
            
            VStack {
                GeneratedColorView(redChannel: redSliderValue,
                                   greenChannel: greenSliderValue,
                                   blueChannel: blueSliderValue)
                .padding(.bottom, 30)
                
                VStack {
                    SliderView(value: $redSliderValue, color: .red)
                        .focused($focusedField, equals: .red)
                    SliderView(value: $greenSliderValue, color: .green)
                        .focused($focusedField, equals: .green)
                    SliderView(value: $blueSliderValue, color: .blue)
                        .focused($focusedField, equals: .blue)
                }
                
                Spacer()
                
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Button(action: selectPreviousTextField) {
                                Image(systemName: "chevron.up")
                            }
                            
                            Button(action: selectNextTextField) {
                                Image(systemName: "chevron.down")
                            }
                            
                            Spacer()
                            
                            Button("Done") {
                                focusedField = nil
                            }
                            .fontWeight(.bold)
                        }
                    }
            }
            
            .padding()
        }
        .onTapGesture {
            focusedField = nil
        }
    }
    
    private func selectNextTextField() {
        switch focusedField {
        case .red: focusedField = .green
        case .green: focusedField = .blue
        case .blue: focusedField = .red
        case .none:
            focusedField = nil
        }
    }
    
    private func selectPreviousTextField() {
        switch focusedField {
        case .red: focusedField = .blue
        case .green: focusedField = .red
        case .blue: focusedField = .green
        case .none:
            focusedField = nil
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
