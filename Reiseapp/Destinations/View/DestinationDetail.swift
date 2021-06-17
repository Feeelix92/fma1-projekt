
import SwiftUI

struct DestinationDetail: View {
    var destination: Destination

    var body: some View {
        ScrollView {
            destination.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text(destination.name)
                    .font(.title)
                Divider()
                Text(destination.description)
            }
            .padding()
        }
        .navigationTitle(destination.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DestinationDetail_Previews: PreviewProvider {
    static var previews: some View {
        DestinationDetail(destination: destinations[0])
    }
}
