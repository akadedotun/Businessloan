import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.bytePurple.ignoresSafeArea()

            // Logo + illustration anchored in the purple area
            VStack(spacing: 0) {
                HStack(spacing: 6) {
                    Text("byte")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                    Image(systemName: "b.square.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white.opacity(0.9))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 64)

                Spacer()

                HeroIllustration()

                Spacer()

                // invisible spacer that matches white card height
                Color.clear.frame(height: 290)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // ── White card pinned to bottom ───────────────────────
            VStack(alignment: .leading, spacing: 0) {
                Text("Welcome to Byte")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primary)
                    .padding(.bottom, 8)

                Text("Use Byte as a person or business")
                    .font(.system(size: 16))
                    .foregroundColor(.byteGray)
                    .padding(.bottom, 28)

                VStack(spacing: 14) {
                    Button {
                        router.push(.step1Personal)
                    } label: {
                        Text("Get Started")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.bytePurple)
                            .cornerRadius(14)
                    }

                    Button {} label: {
                        Text("Login")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.bytePurple)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.bytePurple, lineWidth: 1.5)
                            )
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 32)
            .padding(.bottom, 52)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .clipShape(RoundedCorner(radius: 28, corners: [.topLeft, .topRight]))
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

private struct HeroIllustration: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(.white.opacity(0.12))
                .frame(width: 250, height: 250)
            Circle()
                .fill(.white.opacity(0.10))
                .frame(width: 190, height: 190)

            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(.white.opacity(0.95))
                        .frame(width: 72, height: 72)
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38)
                        .foregroundColor(.bytePurple)
                }
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white.opacity(0.85))
                    .frame(width: 54, height: 72)
            }
            .offset(y: 12)

            Image(systemName: "bag.fill")
                .font(.system(size: 46))
                .foregroundColor(.orange.opacity(0.88))
                .offset(x: 52, y: 22)

            RoundedRectangle(cornerRadius: 8)
                .fill(.white.opacity(0.85))
                .frame(width: 32, height: 52)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.bytePurple.opacity(0.25))
                        .frame(width: 24, height: 44)
                )
                .offset(x: -50, y: 28)
                .rotationEffect(.degrees(-12))

            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .frame(width: 58, height: 50)
                Text("😎")
                    .font(.system(size: 26))
            }
            .offset(x: -72, y: -56)
        }
    }
}

#Preview {
    WelcomeView().environmentObject(Router())
}
