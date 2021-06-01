//
//  CurrencyCalculator.swift
//  Reiseapp
//
//  Created by Nicklas Düringer on 24.05.21.
//

import SwiftUI

struct CurrencyExchange: View {
    @StateObject var viewModel = FetchData()
    // Search Text
    @State var searchQuery = ""
    // Offsets
    @State var offset: CGFloat = 0
    // Start Offeset
    @State var startOffset: CGFloat = 0
    // to move title to center were getting the title width
    @State var titleOffset: CGFloat = 0
    // to get the scrollview padded from the top were going to get the height of the title Bar
    @State var titleBarHeight: CGFloat = 0
    // to adopt for dark mode
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        let sortedData = viewModel.conversionData.sorted{
            return $0.currencyName < $1.currencyName
        }
    ZStack(alignment: .top){
        // moving the search bar to the top if user starts typing
        VStack{
            if searchQuery == ""{
                HStack{
                    (   Text("Wechselkurse")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        +
                        Text(" - Euro")
                            .foregroundColor(.gray)
                    )
                    .font(.largeTitle)
                    .overlay(
                        GeometryReader{reader -> Color in
                            let width = reader.frame(in: .global).maxX
                            DispatchQueue.main.async {
                                //storing
                                if titleOffset == 0{
                                    titleOffset = width
                                }
                            }
                            return Color.clear
                        }
                        .frame(width: 0, height: 0)
                    )
                    .padding()
                    // get offset and moving view / scaling
                    .scaleEffect(getScale())
                    .offset(getOffset())
                    Spacer()
                }
            }
            VStack{
                //Search Bar
                HStack(spacing: 15){
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(.gray)
                    TextField("Search", text: $searchQuery)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.primary.opacity(0.05))
                .cornerRadius(8)
                .padding()
            }
            .offset(y: offset > 0 && searchQuery == "" ? (offset <= 95 ? -offset : -95) : 0)
        }
        // test
        //.background(Color.pink)
        .zIndex(1)
        // padding bottom
        // decrease height of the view
        .padding(.bottom, searchQuery == "" ? getOffset().height : 0)
        .background(
            ZStack{
                let color = scheme == .dark ? Color.black : Color.white
                LinearGradient(gradient: .init(colors: [color,color,color,color,color.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
            }
            .ignoresSafeArea()
        )
        .overlay(
            GeometryReader{reader -> Color in
                let height = reader.frame(in: .global).maxY
                    DispatchQueue.main.async {
                        if titleBarHeight == 0{
                            titleBarHeight = height - (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
                        }
                    }
                return Color.clear
            }
        )
        // animating if user starts typing
        .animation(.easeInOut, value: searchQuery != "")
            ScrollView(.vertical, showsIndicators: false, content: {
                //Fetched Data
                VStack(spacing: 15){
                    ForEach(sortedData) { rate in
                        HStack(spacing: 15){
                            Text(getFlag(currency: rate.currencyName))
                            .font(.system(size: 65))
                            VStack(alignment: .leading, spacing: 5, content: {
                                Text(rate.currencyName)
                                    .font(.title)
                                    .fontWeight(.bold)
                                Text("\(rate.currencyValue)")
                                    .fontWeight(.heavy)
                            })
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                // test
                // .background(Color.green)
                .padding(.top, 10)
                .padding(.top, searchQuery == "" ? titleBarHeight: 90)
                // Get Offset by geometry reader
                .overlay(
                    GeometryReader{proxy -> Color in
                        let minY = proxy.frame(in: .global).minY
                        DispatchQueue.main.async {
                            if startOffset == 0{
                                startOffset = minY
                            }
                            offset = startOffset - minY
                        }
                        return Color.clear
                    }
                    .frame(width: 0, height: 0)
                    ,alignment: .top
                )
            })
        }
    }

    // getting Country Flag by currency name
    func getFlag(currency: String)->String{
        let base = 127397
        var code = currency
        code.removeLast()
        
        var scalar = String.UnicodeScalarView()
        for i in code.utf16{
            if UnicodeScalar(base + Int(i)) != nil {
                scalar.append(UnicodeScalar(base + Int(i))!)
            }
        }
        return String(scalar)
    }
    
    // getting the Offset
    func getOffset()->CGSize{
        var size: CGSize = .zero
        let screenWidth = UIScreen.main.bounds.width / 2
        // since width is slow moving were muliplying with 1.5
        size.width = offset > 0 ? (offset * 1.5 <= (screenWidth - titleOffset) ? offset * 1.5 : (screenWidth - titleOffset)) : 0
        size.height = offset > 0 ? (offset <= 75 ? -offset : -75) : 0
        
        return size
    }
    // shrinking title while scroling
    func getScale()->CGFloat{
        if offset > 0{
            let screenWidth = UIScreen.main.bounds.width
            let progress = 1 - (getOffset().width / screenWidth)
            return progress >= 0.9 ? progress : 0.9
        }
        else{
            return 1
        }
    }
}

struct CurrencyExchange_Previews: PreviewProvider {
    static var previews: some View{
        CurrencyExchange()
            .preferredColorScheme(.dark)
    }
}
