import SwiftUI

struct LoanRejectedView: View {
    @EnvironmentObject var router: Router

    @State private var animate = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // ── Icon ──────────────────────────────────────────────
            ZStack {
                Circle().fill(Color.byteGray.opacity(0.10)).frame(width: 150, height: 150)
                Circle().fill(Color.byteGray.opacity(0.16)).frame(width: 112, height: 112)
                Image(systemName: "xmark.circle.fill")
                    .resizable().scaledToFit().frame(width: 72)
                    .foregroundColor(.byteGray)
                    .scaleEffect(animate ? 1 : 0.4)
                    .opacity(animate ? 1 : 0)
            }
            .padding(.bottom, 28)
            .onAppear {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.15)) {
                    animate = true
                }
            }

            Text("Application Unsuccessful")
                .font(.system(size: 26, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.bottom, 12)
                .padding(.horizontal, 32)

            Text("We were unable to process your loan application at this time.")
                .font(.system(size: 16))
                .foregroundColor(.byteGray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.bottom, 48)

            Spacer()

            Button { router.goToDashboard() } label: {
                Text("Complete Signup")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.bytePurple)
                    .cornerRadius(14)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 48)
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        LoanRejectedView().environmentObject(Router())
    }
}
