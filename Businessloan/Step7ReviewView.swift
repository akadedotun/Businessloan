import SwiftUI

struct Step7ReviewView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var vm: LoanApplicationViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                StepProgressBar(step: 7)
                StepHeader(title: "Review & Submit",
                           subtitle: "Confirm your application details")

                // ── Loan summary card ─────────────────────────────
                VStack(spacing: 6) {
                    Text("Loan Amount")
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.8))
                    Text(vm.fmt(vm.loanAmount))
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                    HStack(spacing: 16) {
                        Label("\(vm.loanTerm) Months", systemImage: "calendar")
                        Label(vm.loanPurpose, systemImage: "briefcase")
                    }
                    .font(.system(size: 13))
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(1)

                    Divider().overlay(Color.white.opacity(0.3)).padding(.vertical, 4)

                    HStack(spacing: 24) {
                        VStack(spacing: 2) {
                            Text("Monthly")
                                .font(.system(size: 11)).foregroundColor(.white.opacity(0.7))
                            Text(vm.fmt(vm.monthlyRepayment))
                                .font(.system(size: 15, weight: .bold)).foregroundColor(.white)
                        }
                        VStack(spacing: 2) {
                            Text("Total Repayable")
                                .font(.system(size: 11)).foregroundColor(.white.opacity(0.7))
                            Text(vm.fmt(vm.totalRepayable))
                                .font(.system(size: 15, weight: .bold)).foregroundColor(.white)
                        }
                        VStack(spacing: 2) {
                            Text("Rate")
                                .font(.system(size: 11)).foregroundColor(.white.opacity(0.7))
                            Text("18% p.a.")
                                .font(.system(size: 15, weight: .bold)).foregroundColor(.white)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 28)
                .padding(.horizontal, 20)
                .background(Color.bytePurple)
                .cornerRadius(20)

                // ── Personal details ──────────────────────────────
                ReviewCard(title: "PERSONAL DETAILS") {
                    ReviewRow(label: "Full Name",  value: "\(vm.firstName) \(vm.lastName)")
                    Divider()
                    ReviewRow(label: "Phone",      value: vm.phone)
                    Divider()
                    ReviewRow(label: "BVN",        value: vm.bvn)
                    Divider()
                    ReviewRow(label: "Address",    value: vm.homeAddress)
                    Divider()
                    ReviewRow(label: "State",      value: vm.stateOfResidence)
                }

                // ── Business details ──────────────────────────────
                ReviewCard(title: "BUSINESS DETAILS") {
                    ReviewRow(label: "Business",   value: vm.businessName)
                    Divider()
                    ReviewRow(label: "Type",       value: vm.businessType)
                    Divider()
                    ReviewRow(label: "CAC No.",    value: vm.cacNumber)
                    Divider()
                    ReviewRow(label: "Experience", value: vm.yearsInBusiness)
                }

                // ── Income ────────────────────────────────────────
                ReviewCard(title: "INCOME") {
                    ReviewRow(label: "Mthly Revenue",  value: vm.fmt(vm.monthlyRevenue))
                    Divider()
                    ReviewRow(label: "Mthly Expenses", value: vm.fmt(vm.monthlyExpenses))
                    Divider()
                    ReviewRow(label: "Net Income",     value: vm.fmt(vm.netMonthlyIncome))
                }

                // ── Bank details ──────────────────────────────────
                ReviewCard(title: "BANK DETAILS") {
                    ReviewRow(label: "Bank",    value: vm.bankName)
                    Divider()
                    ReviewRow(label: "Account", value: vm.accountNumber)
                    Divider()
                    ReviewRow(label: "Name",    value: vm.accountName)
                }

                // ── Documents ─────────────────────────────────────
                ReviewCard(title: "DOCUMENTS") {
                    ReviewRow(label: "CAC Certificate",  value: vm.cacUploaded           ? "✓ Uploaded" : "—")
                    Divider()
                    ReviewRow(label: "Government ID",    value: vm.idUploaded            ? "✓ Uploaded" : "—")
                    Divider()
                    ReviewRow(label: "Bank Statement",   value: vm.bankStatementUploaded ? "✓ Uploaded" : "—")
                    Divider()
                    ReviewRow(label: "Utility Bill",     value: vm.utilityBillUploaded   ? "✓ Uploaded" : "—")
                }

                Text("By submitting, you confirm all details are accurate and you authorise Byte to verify your information and run a credit check.")
                    .font(.system(size: 12))
                    .foregroundColor(.byteGray)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 8)
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, 20)
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                Divider()
                PrimaryButton(title: "Submit Application") {
                    router.push(.loanApproved)
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 32)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .navigationTitle("Review")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        Step7ReviewView()
            .environmentObject(Router())
            .environmentObject(LoanApplicationViewModel())
    }
}
