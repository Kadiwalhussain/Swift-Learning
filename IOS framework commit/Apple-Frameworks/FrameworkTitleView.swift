import SwiftUI

struct FrameworkTitleView: View {
    let framework: Framework

    private var gradient: LinearGradient {
        let scalarSum = framework.name.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        let index = abs(scalarSum) % AppTheme.gradients.count
        return AppTheme.gradients[index]
    }

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(gradient)
                    .frame(width: 78, height: 78)
                Image(framework.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 52, height: 52)
                    .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 4)
            }

            Text(framework.name)
                .font(.system(.headline, design: .rounded, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundStyle(.primary)
                .lineLimit(2)
                .frame(maxWidth: .infinity)
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 150)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(AppTheme.cardStroke, lineWidth: 1)
        )
        .shadow(color: AppTheme.shadowColor, radius: 12, x: 0, y: 8)
    }
}

#Preview {
    FrameworkTitleView(framework: MockData.sampleFramework)
        .padding()
        .background(AppBackgroundView())
}
