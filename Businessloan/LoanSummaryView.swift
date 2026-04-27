import SwiftUI

struct LoanSummaryView: View {
    @EnvironmentObject var router: Router

    let amount: Int
    let purpose: String
    let duration: Int

    private var interestRate: Double { 5.0 }
    private var totalInterest: Double { Double(amount) * (interestRate / 100) * (Double(duration) / 12) }
    private var totalRepayable: Double { Double(amount) + totalInterest }
    private var monthlyRepayment: Double { totalRepayable / Double(duration) }

    private func fmt(_ value: Double) -> String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.maximumFractionDigits = 0
        return "₦\(f.string(from: NSNumber(value: value)) ?? "0")"
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Review Loan")
                        .font(.system(size: 28, weight: .bold))
                        .padding(.top, 8)

                    // ── Hero card ─────────────────────────────────
                    VStack(spacing: 8) {
                        Text("Loan Amount")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.8))
                        Text(fmt(Double(amount)))
                            .font(.system(size: 38, weight: .bold))
                            .foregroundColor(.white)
                        Text("\(duration) Months  •  \(purpose)")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 36)
                    .background(Color.bytePurple)
                    .cornerRadius(20)

                    // ── Breakdown ─────────────────────────────────
                    VStack(spacing: 0) {
                        SummaryLine(label: "Interest Rate",     value: String(format: "%.1f%% p.a.", interestRate))
                        Divider()
                        SummaryLine(label: "Total Interest",    value: fmt(totalInterest))
                        Divider()
                        SummaryLine(label: "Monthly Repayment", value: fmt(monthlyRepayment))
                        Divider()
                        SummaryLine(label: "Total Repayable",   value: fmt(totalRepayable), highlighted: true)
                    }
                    .background(Color.byteCardBg)
                    .cornerRadius(16)

                    // ── Disclaimer ────────────────────────────────
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.bytePurple)
                        Text("By continuing, you agree to Byte's loan terms and conditions. Your credit score may be checked.")
                            .font(.system(size: 13))
                            .foregroundColor(.byteGray)
                    }
                    .padding(14)
                    .background(Color.bytePurple.opacity(0.07))
                    .cornerRadius(12)

                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 120)
            }

            // ── Sticky bottom button ───────────────────────────
            VStack(spacing: 0) {
                Divider()
                Button {
                    router.push(.success(
                        amount: fmt(Double(amount)),
                        monthly: fmt(monthlyRepayment),
                        duration: duration
                    ))
                } label: {
                    Text("Confirm & Apply")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.bytePurple)
                        .cornerRadius(14)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .navigationTitle("Summary")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct SummaryLine: View {
    let label: String
    let value: String
    var highlighted: Bool = false

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 15))
                .foregroundColor(.byteGray)
            Spacer()
            Text(value)
                .font(.system(size: 15, weight: highlighted ? .bold : .semibold))
                .foregroundColor(highlighted ? .bytePurple : .primary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }
}

#Preview {
    NavigationStack {
        LoanSummaryView(amount: 150_000, purpose: "Business", duration: 12)
            .environmentObject(Router())
    }
}
