import SwiftUI

struct LoanApplyView: View {
    @EnvironmentObject var router: Router

    @State private var amount: Double = 100_000
    @State private var selectedPurpose: String? = nil
    @State private var selectedDuration = 6

    private let purposes = ["Business Expansion", "Equipment Purchase",
                            "Working Capital",    "Personal",
                            "Education",          "Emergency"]
    private let durations = [3, 6, 12, 18, 24]

    private var formatted: String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return "₦\(f.string(from: NSNumber(value: Int(amount))) ?? "0")"
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 28) {

                Text("Apply for Loan")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.top, 8)

                // ── Amount ────────────────────────────────────────
                VStack(alignment: .leading, spacing: 14) {
                    SectionLabel("How much do you need?")

                    Text(formatted)
                        .font(.system(size: 38, weight: .bold))
                        .foregroundColor(.bytePurple)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 22)
                        .background(Color.bytePurple.opacity(0.07))
                        .cornerRadius(14)

                    Slider(value: $amount, in: 10_000...500_000, step: 5_000)
                        .tint(.bytePurple)

                    HStack {
                        Text("₦10,000")
                        Spacer()
                        Text("₦500,000")
                    }
                    .font(.system(size: 12))
                    .foregroundColor(.byteGray)
                }

                // ── Purpose ───────────────────────────────────────
                VStack(alignment: .leading, spacing: 12) {
                    SectionLabel("Loan Purpose")

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(purposes, id: \.self) { p in
                            Button { selectedPurpose = p } label: {
                                Text(p)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(selectedPurpose == p ? .white : .primary)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 13)
                                    .background(selectedPurpose == p ? Color.bytePurple : Color.byteCardBg)
                                    .cornerRadius(10)
                                    .animation(.easeInOut(duration: 0.15), value: selectedPurpose)
                            }
                        }
                    }
                }

                // ── Duration ──────────────────────────────────────
                VStack(alignment: .leading, spacing: 12) {
                    SectionLabel("Loan Duration")

                    HStack(spacing: 10) {
                        ForEach(durations, id: \.self) { m in
                            Button { selectedDuration = m } label: {
                                VStack(spacing: 2) {
                                    Text("\(m)")
                                        .font(.system(size: 18, weight: .bold))
                                    Text("mo")
                                        .font(.system(size: 11))
                                }
                                .foregroundColor(selectedDuration == m ? .white : .primary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 62)
                                .background(selectedDuration == m ? Color.bytePurple : Color.byteCardBg)
                                .cornerRadius(10)
                                .animation(.easeInOut(duration: 0.15), value: selectedDuration)
                            }
                        }
                    }
                }

                Spacer(minLength: 20)

                // ── Continue ──────────────────────────────────────
                Button {
                    guard let p = selectedPurpose else { return }
                    router.push(.summary(amount: Int(amount), purpose: p, duration: selectedDuration))
                } label: {
                    Text("Continue")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(selectedPurpose != nil ? Color.bytePurple : Color.byteGray)
                        .cornerRadius(14)
                        .animation(.easeInOut(duration: 0.2), value: selectedPurpose != nil)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 48)
        }
        .background(Color.white)
        .navigationTitle("Apply")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct SectionLabel: View {
    let text: String
    init(_ text: String) { self.text = text }

    var body: some View {
        Text(text)
            .font(.system(size: 17, weight: .semibold))
    }
}

#Preview {
    NavigationStack { LoanApplyView().environmentObject(Router()) }
}
