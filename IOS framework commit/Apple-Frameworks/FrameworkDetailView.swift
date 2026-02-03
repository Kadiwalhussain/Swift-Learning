import SwiftUI

struct FrameworkDetailView: View {
    let framework: Framework

    @Environment(\.dismiss) private var dismiss

    private var gradient: LinearGradient {
        let scalarSum = framework.name.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        let index = abs(scalarSum) % AppTheme.gradients.count
        return AppTheme.gradients[index]
    }

    var body: some View {
        ZStack {
            AppBackgroundView()

            ScrollView {
                VStack(spacing: 24) {
                    headerSection
                    descriptionSection
                    Link(destination: URL(string: framework.urlString)!) {
                        Label("Learn More", systemImage: "safari")
                    }
                    .buttonStyle(PrimaryActionButtonStyle())
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
                .padding(.top, 8)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }

    private var headerSection: some View {
        VStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 36, style: .continuous)
                    .fill(gradient)
                    .frame(height: 160)
                Image(framework.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 110)
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 10)
            }

            Text(framework.name)
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .multilineTextAlignment(.center)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(AppTheme.cardStroke, lineWidth: 1)
        )
    }

    private var descriptionSection: some View {
        Text(framework.description)
            .font(.system(.body, design: .serif))
            .foregroundStyle(.primary)
            .lineSpacing(6)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(AppTheme.cardStroke, lineWidth: 1)
            )
    }
}

#Preview {
    FrameworkDetailView(framework: MockData.sampleFramework)
}
