
import SwiftUI

struct DestinationRow: View {
    var destination: Destination

    var body: some View {
        HStack {
            destination.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(destination.name)
            Spacer()
        }
    }
}

struct DestinationRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DestinationRow(destination: destinations[0])
            DestinationRow(destination: destinations[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
