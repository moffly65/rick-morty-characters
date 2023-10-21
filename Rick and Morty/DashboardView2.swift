import SwiftUI

struct DashboardView2: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                DashButtonView(imageString: "characters", titleString: "Characters", destinationView: ContentView())
                Spacer()
                DashButtonView(imageString: "locations", titleString: "Locations", destinationView: LocationsView())
                Spacer()
                DashButtonView(imageString: "episodes", titleString: "Episodes", destinationView: EpisodesView())
                Spacer()
                    .navigationBarTitle("Rick & Morty Show")
            }
            //.background(Color(red: 0.9, green: 0.9, blue: 0.9))
        }
    }
    
    struct DashboardView2_Previews: PreviewProvider {
        static var previews: some View {
            DashboardView2()
        }
    }
}
