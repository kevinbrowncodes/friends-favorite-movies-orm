import SwiftUI
import SwiftData

struct MovieListFilteredView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            MovieListView(titleFilter: searchText)
                .searchable(text: $searchText)
        }
    }
}

#Preview {
    MovieListFilteredView()
        .modelContainer(SampleData.shared.modelContainer)
}
