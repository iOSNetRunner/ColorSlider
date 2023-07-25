//
//  SliderView.swift
//  ColorSlider
//
//  Created by Dmitrii Galatskii on 25.07.2023.
//

import SwiftUI

struct SliderView: View {
    @Binding var value: Double
    @State private var text = ""
    @State private var showAlert = false
    
    let color: Color
    
    var body: some View {
        HStack {
            Text(value.formatted())
                .frame(width: 35)
                .foregroundColor(.white)
            
            Slider(value: $value, in: 0...255, step: 1)
                .animation(.linear, value: value)
                .tint(color)
                .onChange(of: value) { newValue in
                    text = newValue.formatted()
                }
            
            TextFieldView(text: $text, action: checkInput)
                .alert("Wrong number", isPresented: $showAlert, actions: {}) {
                    Text("Enter correct number \nbetween 0 and 255.")
                }
        }
        .onAppear {
            text = value.formatted()
        }
    }
    
    private func checkInput() {
        if let inputValue = Double(text), (0...255).contains(inputValue) {
            value = inputValue
        } else {
            showAlert.toggle()
            value = 0
            text = "0"
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray
            SliderView(value: .constant(23), color: .blue)
        }
    }
}
