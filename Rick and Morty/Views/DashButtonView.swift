import SwiftUI

struct DashButtonView<Destination: View>: View {
    var imageString: String
    var titleString: String
    var destinationView: Destination
    
    var body: some View {
        NavigationLink(destination: destinationView) {
            Image(imageString)
                .resizable()
                .frame(height: 200)
                .cornerRadius(10)
                .overlay(
                    Text(titleString)
                        .frame(width: 95, height: 10)
                        .foregroundColor(Color.cyan)
                        .bold()
                        .italic()
                        .padding(15)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                        .offset(x: 100, y: 70)
                )
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .padding(.bottom, 5)
    }
    
}
