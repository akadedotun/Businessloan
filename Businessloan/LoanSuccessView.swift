import SwiftUI

struct LoanSuccessView: View {
    @EnvironmentObject var router: Router

    let amount: String
    let monthly: String
    let duration: Int

    @State private var animate = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // ── Success icon ──────────────────────────────────────
            ZStack {
                Circle()
                    .fill(Color.byteGreen.opacity(0.10))
                    .frame(width: 148, height: 148)
                Circle()
                    .fill(Color.byteGreen.opacity(0.18))
                    .frame(width: 112, height: 112)
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70)
                    .foregroundColor(.byteGreen)
                    .scaleEffect(animate ? 1 : 0.4)
                    .opacity(animate ? 1 : 0)
            }
            .padding(.bottom, 32)
            .onAppear {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.15)) {
                    animate = true
                }
            }

            Text("Loan Approved!")
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 10)

            Text("Your loan has been approved and\nwill be disbursed shortly.")
                .font(.system(size: 16))
                .foregroundColor(.byteGray)
                .multilineTextAlignment(.center)
                .padding(.bottom, 40)

            // ── Summary card ──────────────────────────────────────
            VStack(spacing: 0) {
                SuccessLine(label: "Loan Amount",   value: amount)
                Divider()
                SuccessLine(label: "Monthly Payment", value: monthly)
                Divider()
                SuccessLine(label: "Duration",      value: "\(duration) Months")
            }
            .background(Color.byteCardBg)
            .cornerRadius(16)
            .padding(.horizontal, 24)

            Spacer()

            // ── Done ──────────────────────────────────────────────
            Button { router.goToDashboard() } label: {
                Text("Done")
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

private struct SuccessLine: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 15))
                .foregroundColor(.byteGray)
            Spacer()
            Text(value)
                .font(.system(size: 15, weight: .semibold))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 15)
    }
}

#Preview {
    NavigationStack {
        LoanSuccessView(amount: "₦150,000", monthly: "₦13,750", duration: 12)
            .environmentObject(Router())
    }
}
