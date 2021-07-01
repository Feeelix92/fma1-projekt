
import SwiftUI

struct DestinationDetail: View {
    var destination: Destination

    var body: some View {
        if let currentLanguage = Locale.current.languageCode {
            let destinationName = currentLanguage == "de" ? destination.name_de : destination.name
            let destinationDescription = currentLanguage == "de" ? destination.description_de : destination.description
            ScrollView {
                destination.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    Text(destinationName).font(.title)
                    Divider()
                    Text(destinationDescription)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
            }
            .navigationTitle(destinationName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DestinationDetail_Previews: PreviewProvider {
    static var previews: some View {
        DestinationDetail(destination: destinations[0])
    }
}
