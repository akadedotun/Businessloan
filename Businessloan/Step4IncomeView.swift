import SwiftUI

struct Step4IncomeView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var vm: LoanApplicationViewModel

    private var isValid: Bool { vm.monthlyRevenue > 0 && vm.netMonthlyIncome > 0 }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                StepProgressBar(step: 4)
                StepHeader(title: "Income Verification",
                           subtitle: "Share your business financials")

                ByteAmountField(label: "Average Monthly Revenue", text: $vm.monthlyRevenueText)

                ByteAmountField(label: "Average Monthly Expenses", text: $vm.monthlyExpensesText)

                // Net income summary card
                if vm.monthlyRevenue > 0 {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Label("Revenue", systemImage: "arrow.up.circle.fill")
                                .foregroundColor(.byteGreen)
                            Spacer()
                            Text(vm.fmt(vm.monthlyRevenue))
                                .font(.system(size: 15, weight: .semibold))
                        }
                        Divider()
                        HStack {
                            Label("Expenses", systemImage: "arrow.down.circle.fill")
                                .foregroundColor(.byteRed)
                            Spacer()
                            Text(vm.fmt(vm.monthlyExpenses))
                                .font(.system(size: 15, weight: .semibold))
                        }
                        Divider()
                        HStack {
                            Text("Net Monthly Income")
                                .font(.system(size: 15, weight: .bold))
                            Spacer()
                            Text(vm.fmt(vm.netMonthlyIncome))
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(vm.netMonthlyIncome >= 0 ? .byteGreen : .byteRed)
                        }
                    }
                    .padding(16)
                    .background(Color.byteCardBg)
                    .cornerRadius(14)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                    .animation(.easeInOut, value: vm.monthlyRevenue)
                }

                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "lock.shield")
                        .foregroundColor(.bytePurple)
                    Text("Your financial information is encrypted and only used for loan assessment.")
                        .font(.system(size: 13))
                        .foregroundColor(.byteGray)
                }
                .padding(12)
                .background(Color.bytePurple.opacity(0.07))
                .cornerRadius(10)
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, 20)
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                Divider()
                PrimaryButton(title: "Continue", enabled: isValid) {
                    if vm.netMonthlyIncome > 200_000 {
                        router.push(.step5Bank)
                    } else {
                        router.push(.loanRejected)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 32)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .navigationTitle("Income Verification")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        Step4IncomeView()
            .environmentObject(Router())
            .environmentObject(LoanApplicationViewModel())
    }
}
