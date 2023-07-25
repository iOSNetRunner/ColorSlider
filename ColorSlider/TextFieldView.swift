//
//  TextFieldView.swift
//  ColorSlider
//
//  Created by Dmitrii Galatskii on 25.07.2023.
//

import SwiftUI

struct TextFieldView: View {
    
    @Binding var text: String
    
    let action: () -> Void
    
    var body: some View {
        // Method: TextField(<#T##title: StringProtocol##StringProtocol#>, text: <#T##Binding<String>#>, onEditingChanged: <#T##(Bool) -> Void#>)
        TextField("0", text: $text) { _ in
            action()
        }
            .textFieldStyle(.roundedBorder)
            .frame(width: 45)
            .keyboardType(.numberPad)
        
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(text: .constant("255"), action: {})
    }
}
