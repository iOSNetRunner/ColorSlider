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
    
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    @State private var redColorInput = 0.0
    @State private var greenColorInput = 0.0
    @State private var blueColorInput = 0.0
    
    @State private var alertPresented = false
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black.gradient)
                .opacity(0.90)
                .ignoresSafeArea()
            
            VStack {
                GeneratedColorView(redChannel: $redSliderValue,
                                   greenChannel: $greenSliderValue,
                                   blueChannel: $blueSliderValue)
                .padding(.bottom, 30)
                
                SliderView(sliderValue: $redSliderValue,
                           enteredValue: $redColorInput,
                           color: .red)
                .focused($focusedField, equals: .red)
                .onAppear(perform: {
                    redColorInput = redSliderValue
                })
                .onChange(of: redSliderValue) { newValue in
                    redColorInput = newValue
                    redSliderValue = newValue
                }
                .onSubmit {
                    redSliderValue = redColorInput
                }
                
                
                SliderView(sliderValue: $greenSliderValue,
                           enteredValue: $greenColorInput,
                           color: .green)
                .focused($focusedField, equals: .green)
                .onAppear(perform: {
                    greenColorInput = greenSliderValue
                })
                .onChange(of: greenSliderValue) { newValue in
                    greenColorInput = newValue
                    greenSliderValue = newValue
                }
                .onSubmit {
                    greenSliderValue = greenColorInput
                }
                
                
                SliderView(sliderValue: $blueSliderValue,
                           enteredValue: $blueColorInput,
                           color: .blue)
                .focused($focusedField, equals: .blue)
                .onAppear(perform: {
                    blueColorInput = blueSliderValue
                })
                .onChange(of: blueSliderValue) { newValue in
                    blueColorInput = newValue
                    blueSliderValue = newValue
                }
                .onSubmit {
                    blueSliderValue = blueColorInput
                }
                
                Spacer()
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button(action: selectPreviousTextField) {
                        Image(systemName: "chevron.up")
                    }
                    
                    Button(action: selectNextTextField) {
                        Image(systemName: "chevron.down")
                    }
                    
                    Spacer()
                    
                    Button("Done", action: checkInput)
                        .fontWeight(.bold)
                        .alert("Wrong number", isPresented: $alertPresented, actions: {}) {
                            Text("Enter correct number \nbetween 0 and 255.")
                        }
                }
            }
            .onTapGesture {
                focusedField = nil
            }
            .padding()
        }
    }
    
    private func checkInput() {
        if redColorInput > 255 {
            redColorInput = 0
            alertPresented.toggle()
        } else if greenColorInput > 255 {
            greenColorInput = 0
            alertPresented.toggle()
        } else if blueColorInput > 255 {
            blueColorInput = 0
            alertPresented.toggle()
        }
        
        switch focusedField {
        case .red:
            redSliderValue = redColorInput
        case .green:
            greenSliderValue = greenColorInput
        case .blue:
            blueSliderValue = blueColorInput
        case .none:
            focusedField = nil
        }
        
        focusedField = nil
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



struct SliderView: View {
    @Binding var sliderValue: Double
    @Binding var enteredValue: Double
    let color: Color
    
    var body: some View {
        HStack {
            Text("\(lround(sliderValue))")
                .frame(width: 35)
                .foregroundColor(.white)
            
            Slider(value: $sliderValue, in: 0...255, step: 1)
                .animation(.linear, value: sliderValue)
                .tint(color)
            
            TextField("0", value: $enteredValue, formatter: NumberFormatter())
                .textFieldStyle(.roundedBorder)
                .frame(width: 45)
                .keyboardType(.numberPad)
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
