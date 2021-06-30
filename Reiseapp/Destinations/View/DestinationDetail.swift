
import SwiftUI

struct DestinationDetail: View {
    var destination: Destination

    var body: some View {
        if let currentLanguage = Locale.current.languageCode {
            ScrollView {
                destination.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    Text(currentLanguage == "de" ? destination.name_de : destination.name).font(.title)
                    Divider()
                    Text(currentLanguage == "de" ? destination.description_de : destination.description)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
            }
            .navigationTitle(currentLanguage == "de" ? destination.name_de : destination.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DestinationDetail_Previews: PreviewProvider {
    static var previews: some View {
        DestinationDetail(destination: destinations[0])
    }
}
