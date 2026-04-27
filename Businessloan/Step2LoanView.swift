import SwiftUI

struct Step2LoanView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var vm: LoanApplicationViewModel

    private let terms   = [3, 6, 12, 18, 24]
    private let purposes = [
        "Business Expansion", "Equipment Purchase",
        "Working Capital",    "Inventory",
        "Commercial Property","Staff Salary",
        "Marketing",          "Other"
    ]

    private var isValid: Bool { !vm.loanPurpose.isEmpty }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                StepProgressBar(step: 2)
                StepHeader(title: "Loan Details",
                           subtitle: "How much does your business need?")

                // ── Amount display + slider ────────────────────────
                VStack(alignment: .leading, spacing: 12) {
                    Text("Loan Amount")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.byteGray)

                    Text(vm.fmt(vm.loanAmount))
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.bytePurple)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 22)
                        .background(Color.bytePurple.opacity(0.07))
                        .cornerRadius(14)

                    Slider(value: $vm.loanAmount, in: 100_000...5_000_000, step: 50_000)
                        .tint(.bytePurple)

                    HStack {
                        Text("₦100,000")
                        Spacer()
                        Text("₦5,000,000")
                    }
                    .font(.system(size: 12))
                    .foregroundColor(.byteGray)
                }

                // ── Repayment term ────────────────────────────────
                VStack(alignment: .leading, spacing: 10) {
                    Text("Repayment Term")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.byteGray)

                    HStack(spacing: 8) {
                        ForEach(terms, id: \.self) { m in
                            Button { vm.loanTerm = m } label: {
                                VStack(spacing: 2) {
                                    Text("\(m)")
                                        .font(.system(size: 18, weight: .bold))
                                    Text("mo")
                                        .font(.system(size: 11))
                                }
                                .foregroundColor(vm.loanTerm == m ? .white : .primary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .background(vm.loanTerm == m ? Color.bytePurple : Color.byteCardBg)
                                .cornerRadius(10)
                                .animation(.easeInOut(duration: 0.15), value: vm.loanTerm)
                            }
                        }
                    }
                }

                // ── Estimated monthly payment ─────────────────────
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(.bytePurple)
                        .font(.system(size: 14))
                    Text("Est. monthly repayment: \(vm.fmt(vm.monthlyRepayment)) at 1.5% / month")
                        .font(.system(size: 13))
                        .foregroundColor(.byteGray)
                }
                .padding(12)
                .background(Color.bytePurple.opacity(0.07))
                .cornerRadius(10)

                // ── Loan purpose ──────────────────────────────────
                VStack(alignment: .leading, spacing: 10) {
                    Text("Loan Purpose")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.byteGray)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(purposes, id: \.self) { p in
                            Button { vm.loanPurpose = p } label: {
                                Text(p)
                                    .font(.system(size: 14, weight: .medium))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(vm.loanPurpose == p ? .white : .primary)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .background(vm.loanPurpose == p ? Color.bytePurple : Color.byteCardBg)
                                    .cornerRadius(10)
                                    .animation(.easeInOut(duration: 0.15), value: vm.loanPurpose)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, 20)
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                Divider()
                PrimaryButton(title: "Continue", enabled: isValid) {
                    router.push(.step3Business)
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 32)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .navigationTitle("Loan Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        Step2LoanView()
            .environmentObject(Router())
            .environmentObject(LoanApplicationViewModel())
    }
}
