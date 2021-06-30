
import SwiftUI

var destinations: [Destination] = load("destinationData.json")

struct DestinationList: View {
    var body: some View {
        NavigationView {
            List(destinations) { destination in
                NavigationLink(destination: DestinationDetail(destination: destination)) {
                    DestinationRow(destination: destination)
                }
            }
            .navigationTitle(LocalizedStringKey("destinations"))
        }
    }
}

struct DestinationList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
            DestinationList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
