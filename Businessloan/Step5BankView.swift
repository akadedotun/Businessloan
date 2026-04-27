import SwiftUI

struct Step5BankView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var vm: LoanApplicationViewModel

    private var isValid: Bool {
        !vm.bankName.isEmpty &&
        vm.accountNumber.count == 10 &&
        !vm.accountName.isEmpty
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                StepProgressBar(step: 5)
                StepHeader(title: "Bank Linking",
                           subtitle: "Where should we send your loan?")

                ByteDropdown(label: "Select Bank",
                             placeholder: "Choose your bank",
                             options: nigerianBanks,
                             selection: $vm.bankName)

                ByteTextField(label: "Account Number",
                              placeholder: "0123456789",
                              text: $vm.accountNumber,
                              keyboard: .numberPad)
                    .onChange(of: vm.accountNumber) { newVal in
                        let digits = String(newVal.filter(\.isNumber).prefix(10))
                        vm.accountNumber = digits
                        vm.accountName = digits.count == 10 ? simulateName(digits) : ""
                    }

                if !vm.accountName.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Account Name")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.byteGray)
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.byteGreen)
                            Text(vm.accountName)
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 14)
                        .background(Color.byteGreen.opacity(0.08))
                        .cornerRadius(10)
                    }
                    .transition(.opacity.combined(with: .move(edge: .top)))
                    .animation(.easeInOut, value: vm.accountName)
                }

                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.bytePurple)
                    Text("Loan disbursement will be made directly to this account after approval.")
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
                    router.push(.step6Documents)
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 32)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .navigationTitle("Bank Linking")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func simulateName(_ digits: String) -> String {
        // Simulated BVN/NIP account name lookup
        let names = ["Martins Olaniyan", "Adedotun Ayodimeji",
                     "Chinwe Okafor",   "Emeka Nwosu"]
        return names[abs(digits.hashValue) % names.count]
    }
}

#Preview {
    NavigationStack {
        Step5BankView()
            .environmentObject(Router())
            .environmentObject(LoanApplicationViewModel())
    }
}
