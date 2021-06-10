//
//  DropDown.swift
//  Reiseapp
//
//  Created by Nicklas Düringer on 09.06.21.
//

import SwiftUI

struct DropDown: View {
    @State var items: [Length]
    @Binding var selectedIndex: Length
    @State var expand = false
   
    var body: some View {
        VStack(alignment: .leading, spacing: 12, content: {
            HStack {
                Text(selectedIndex.rawValue.capitalized).fontWeight(.heavy).foregroundColor(.white)
                Image(systemName: expand ? "chevron.up" : "chevron.down").foregroundColor(.white)
            }.onTapGesture {
                self.expand.toggle()
            }
            if expand {
                ForEach(items, id: \.self) { item in
                    if item != selectedIndex {
                        Button(action: {
                            selectedIndex = item
                            self.expand.toggle()
                        }, label: {
                            Text(item.rawValue.capitalized)
                        }).foregroundColor(.white)
                    }
                }
            }
        })
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(LinearGradient(gradient: .init(colors: [.blue,.blue]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(6)
        .animation(.spring())
    }
}

struct DropDown_Previews: PreviewProvider {
    @State static var selectedIndex = Length.kilometer
    static var previews: some View {
        DropDown(items: [.zentimeter, .meter, .kilometer], selectedIndex: $selectedIndex)
    }
}
