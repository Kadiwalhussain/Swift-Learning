import SwiftUI

struct FrameworkGridView: View {
    private let columns = [
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]

    @State private var selectedFramework: Framework?
    @State private var searchText = ""

    private var filteredFrameworks: [Framework] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return MockData.frameworks
        }
        return MockData.frameworks.filter { framework in
            framework.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppBackgroundView()
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        HeroHeaderView()

                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(filteredFrameworks) { framework in
                                FrameworkTitleView(framework: framework)
                                    .onTapGesture {
                                        selectedFramework = framework
                                    }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 28)
                    .padding(.top, 6)
                }
            }
            .navigationTitle("Apple Frameworks")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search frameworks")
        }
        .sheet(item: $selectedFramework) { framework in
            FrameworkDetailView(framework: framework)
        }
    }
}

private struct HeroHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Explore Apple APIs")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
            Text("Build faster with a curated set of frameworks for iOS, macOS, watchOS, and tvOS.")
                .font(.system(.title3, design: .serif))
                .foregroundStyle(.secondary)
            HStack(spacing: 12) {
                Label("15 Frameworks", systemImage: "square.grid.2x2")
                Label("Curated", systemImage: "sparkles")
            }
            .font(.system(.subheadline, design: .rounded, weight: .semibold))
            .foregroundStyle(.secondary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(AppTheme.cardStroke, lineWidth: 1)
        )
        .shadow(color: AppTheme.shadowColor, radius: 18, x: 0, y: 10)
    }
}

#Preview {
    FrameworkGridView()
}
