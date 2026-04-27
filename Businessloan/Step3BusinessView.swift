import SwiftUI

struct Step3BusinessView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var vm: LoanApplicationViewModel

    private let businessTypes = ["Sole Proprietorship", "Partnership", "Ltd / LTD", "PLC", "NGO / Co-op"]
    private let yearsOptions  = ["Less than 1 year", "1 – 2 years", "3 – 5 years", "5 + years"]

    private var isValid: Bool {
        !vm.businessName.isEmpty &&
        !vm.businessType.isEmpty &&
        !vm.cacNumber.isEmpty &&
        !vm.yearsInBusiness.isEmpty &&
        !vm.businessAddress.isEmpty &&
        !vm.businessState.isEmpty
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                StepProgressBar(step: 3)
                StepHeader(title: "Business Details",
                           subtitle: "Tell us about your business")

                ByteTextField(label: "Business / Trading Name",
                              placeholder: "Olaniyan Ventures Ltd",
                              text: $vm.businessName)

                ChipGroup(label: "Business Type",
                          options: businessTypes,
                          selection: $vm.businessType)

                ByteTextField(label: "CAC Registration Number (RC No.)",
                              placeholder: "RC 1234567",
                              text: $vm.cacNumber)

                ChipGroup(label: "Years in Operation",
                          options: yearsOptions,
                          selection: $vm.yearsInBusiness)

                ByteTextField(label: "Business Address",
                              placeholder: "45 Broad Street, Lagos Island",
                              text: $vm.businessAddress)

                ByteDropdown(label: "Business State",
                             placeholder: "Select state",
                             options: nigerianStates,
                             selection: $vm.businessState)
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, 20)
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                Divider()
                PrimaryButton(title: "Continue", enabled: isValid) {
                    router.push(.step4Income)
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 32)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .navigationTitle("Business Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        Step3BusinessView()
            .environmentObject(Router())
            .environmentObject(LoanApplicationViewModel())
    }
}
