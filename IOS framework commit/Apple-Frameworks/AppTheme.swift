import SwiftUI

enum AppTheme {
    static let cardStroke = Color.white.opacity(0.25)
    static let shadowColor = Color.black.opacity(0.12)

    static let backgroundTop = Color(.systemBackground)
    static let backgroundBottom = Color(.secondarySystemBackground)

    static let accentBlue = Color(red: 0.30, green: 0.58, blue: 0.95)
    static let accentTeal = Color(red: 0.36, green: 0.78, blue: 0.73)
    static let accentOrange = Color(red: 0.98, green: 0.62, blue: 0.28)
    static let accentPink = Color(red: 0.95, green: 0.45, blue: 0.62)

    static let gradients: [LinearGradient] = [
        LinearGradient(colors: [accentBlue.opacity(0.9), accentTeal.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(colors: [accentOrange.opacity(0.9), accentPink.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(colors: [accentTeal.opacity(0.9), accentBlue.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(colors: [accentPink.opacity(0.9), accentOrange.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
    ]
}

struct AppBackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [AppTheme.backgroundTop, AppTheme.backgroundBottom], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            Circle()
                .fill(AppTheme.accentTeal.opacity(0.22))
                .frame(width: 240, height: 240)
                .blur(radius: 30)
                .offset(x: -140, y: -220)

            Circle()
                .fill(AppTheme.accentPink.opacity(0.18))
                .frame(width: 280, height: 280)
                .blur(radius: 40)
                .offset(x: 160, y: -160)

            RoundedRectangle(cornerRadius: 180, style: .continuous)
                .fill(AppTheme.accentBlue.opacity(0.15))
                .frame(width: 320, height: 200)
                .blur(radius: 50)
                .rotationEffect(.degrees(-20))
                .offset(x: 120, y: 280)
        }
    }
}

struct PrimaryActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.headline, design: .rounded, weight: .semibold))
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: [AppTheme.accentBlue, AppTheme.accentTeal], startPoint: .leading, endPoint: .trailing)
            )
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .shadow(color: AppTheme.accentBlue.opacity(0.35), radius: 10, x: 0, y: 6)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
