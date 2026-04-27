import SwiftUI

struct Step1PersonalView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var vm: LoanApplicationViewModel

    private var isValid: Bool {
        !vm.firstName.isEmpty &&
        !vm.lastName.isEmpty &&
        vm.phone.count == 11 &&
        vm.bvn.count == 11 &&
        !vm.homeAddress.isEmpty &&
        !vm.stateOfResidence.isEmpty
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                StepProgressBar(step: 1)
                StepHeader(title: "Personal Details",
                           subtitle: "Tell us a bit about yourself")

                ByteTextField(label: "First Name", placeholder: "John", text: $vm.firstName)
                ByteTextField(label: "Last Name",  placeholder: "Doe",  text: $vm.lastName)

                ByteTextField(label: "Phone Number", placeholder: "08012345678",
                              text: $vm.phone, keyboard: .phonePad)

                ByteTextField(label: "BVN", placeholder: "12345678901",
                              text: $vm.bvn, keyboard: .numberPad)

                VStack(alignment: .leading, spacing: 6) {
                    Text("Date of Birth")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.byteGray)
                    HStack {
                        DatePicker("", selection: $vm.dob,
                                   in: ...Calendar.current.date(byAdding: .year, value: -18, to: Date())!,
                                   displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 14)
                    .background(Color.byteCardBg)
                    .cornerRadius(10)
                }

                ByteTextField(label: "Home Address", placeholder: "123 Lagos Street, Ikeja",
                              text: $vm.homeAddress)

                ByteDropdown(label: "State of Residence", placeholder: "Select state",
                             options: nigerianStates, selection: $vm.stateOfResidence)
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, 20)
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                Divider()
                PrimaryButton(title: "Continue", enabled: isValid) {
                    router.push(.step2Loan)
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 32)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .navigationTitle("Personal Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        Step1PersonalView()
            .environmentObject(Router())
            .environmentObject(LoanApplicationViewModel())
    }
}
