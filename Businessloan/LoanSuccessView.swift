import SwiftUI

struct LoanSuccessView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var vm: LoanApplicationViewModel

    @State private var animate = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // ── Success icon ──────────────────────────────────────
            ZStack {
                Circle().fill(Color.byteGreen.opacity(0.10)).frame(width: 150, height: 150)
                Circle().fill(Color.byteGreen.opacity(0.18)).frame(width: 112, height: 112)
                Image(systemName: "checkmark.circle.fill")
                    .resizable().scaledToFit().frame(width: 72)
                    .foregroundColor(.byteGreen)
                    .scaleEffect(animate ? 1 : 0.4)
                    .opacity(animate ? 1 : 0)
            }
            .padding(.bottom, 28)
            .onAppear {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.15)) {
                    animate = true
                }
            }

            Text("Loan Approved!")
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 10)

            Text("Your application is approved.\nDisbursement will be made within 24 hours.")
                .font(.system(size: 16))
                .foregroundColor(.byteGray)
                .multilineTextAlignment(.center)
                .padding(.bottom, 36)

            // ── Summary card ──────────────────────────────────────
            VStack(spacing: 0) {
                SLine(label: "Loan Amount",     value: vm.fmt(vm.loanAmount))
                Divider()
                SLine(label: "Monthly Payment", value: vm.fmt(vm.monthlyRepayment))
                Divider()
                SLine(label: "Repayment Term",  value: "\(vm.loanTerm) Months")
                Divider()
                SLine(label: "Disbursement to", value: vm.bankName)
            }
            .background(Color.byteCardBg)
            .cornerRadius(16)
            .padding(.horizontal, 24)

            Spacer()

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

private struct SLine: View {
    let label: String; let value: String
    var body: some View {
        HStack {
            Text(label).font(.system(size: 15)).foregroundColor(.byteGray)
            Spacer()
            Text(value).font(.system(size: 15, weight: .semibold))
        }
        .padding(.horizontal, 16).padding(.vertical, 14)
    }
}

#Preview {
    NavigationStack {
        LoanSuccessView()
            .environmentObject(Router())
            .environmentObject(LoanApplicationViewModel())
    }
}
