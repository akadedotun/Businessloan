import SwiftUI

struct Step6DocumentsView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var vm: LoanApplicationViewModel

    private var isValid: Bool {
        vm.cacUploaded && vm.idUploaded &&
        vm.bankStatementUploaded && vm.utilityBillUploaded
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                StepProgressBar(step: 6)
                StepHeader(title: "Document Upload",
                           subtitle: "Upload clear photos or scans")

                VStack(spacing: 12) {
                    DocumentRow(
                        icon: "building.2.crop.circle",
                        title: "CAC Certificate",
                        subtitle: "Business registration certificate",
                        isUploaded: $vm.cacUploaded
                    )
                    DocumentRow(
                        icon: "person.crop.rectangle",
                        title: "Government-Issued ID",
                        subtitle: "NIN slip, driver's licence or passport",
                        isUploaded: $vm.idUploaded
                    )
                    DocumentRow(
                        icon: "chart.bar.doc.horizontal",
                        title: "Bank Statement",
                        subtitle: "Last 6 months, stamped by bank",
                        isUploaded: $vm.bankStatementUploaded
                    )
                    DocumentRow(
                        icon: "house.and.flag",
                        title: "Utility Bill",
                        subtitle: "Proof of business address (< 3 months old)",
                        isUploaded: $vm.utilityBillUploaded
                    )
                }

                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "lock.shield")
                        .foregroundColor(.bytePurple)
                    Text("All documents are securely stored and used solely for verification purposes.")
                        .font(.system(size: 13))
                        .foregroundColor(.byteGray)
                        .frame(maxWidth: .infinity, alignment: .leading)
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
                    router.push(.step7Review)
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 32)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .navigationTitle("Documents")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: – Document upload row

private struct DocumentRow: View {
    let icon: String
    let title: String
    let subtitle: String
    @Binding var isUploaded: Bool

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(isUploaded ? Color.byteGreen.opacity(0.12) : Color.byteCardBg)
                    .frame(width: 48, height: 48)
                Image(systemName: isUploaded ? "checkmark" : icon)
                    .font(.system(size: 20, weight: isUploaded ? .bold : .regular))
                    .foregroundColor(isUploaded ? .byteGreen : .byteGray)
            }
            .animation(.easeInOut(duration: 0.2), value: isUploaded)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.byteGray)
            }

            Spacer()

            Button {
                withAnimation { isUploaded.toggle() }
            } label: {
                Text(isUploaded ? "Uploaded" : "Upload")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(isUploaded ? .byteGreen : .bytePurple)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(
                        isUploaded ? Color.byteGreen.opacity(0.10) : Color.bytePurple.opacity(0.08)
                    )
                    .cornerRadius(20)
            }
        }
        .padding(14)
        .background(Color.byteCardBg)
        .cornerRadius(14)
    }
}

#Preview {
    NavigationStack {
        Step6DocumentsView()
            .environmentObject(Router())
            .environmentObject(LoanApplicationViewModel())
    }
}
