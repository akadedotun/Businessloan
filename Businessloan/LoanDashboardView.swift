import SwiftUI

struct LoanDashboardView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 28) {

                // ── Header ────────────────────────────────────────
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Byte Loan")
                            .font(.system(size: 22, weight: .bold))
                        Text("Manage your loans on Byte")
                            .font(.system(size: 14))
                            .foregroundColor(.byteGray)
                    }
                    Spacer()
                    VStack(spacing: 3) {
                        Text("₦500,000")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.white)
                        Text("Credit Limit")
                            .font(.system(size: 11))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .background(Color.byteBadgeBg)
                    .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)

                // ── Quick actions ─────────────────────────────────
                HStack(spacing: 14) {
                    Button { router.push(.step1Personal) } label: {
                        QuickActionButton(icon: "arrow.forward.to.line.circle", title: "Apply")
                    }
                    QuickActionButton(icon: "arrow.down.to.line.circle", title: "Repay")
                }
                .padding(.horizontal, 24)

                // ── Active loans ──────────────────────────────────
                VStack(alignment: .leading, spacing: 14) {
                    DashSectionHeader(title: "Active Loans")

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ActiveLoanCard(amount: "₦150,000", label: "Business", due: "Jun 15, 2026", progress: 0.40)
                            ActiveLoanCard(amount: "₦80,000",  label: "Personal",  due: "Jul 20, 2026", progress: 0.70)
                        }
                        .padding(.horizontal, 24)
                    }
                }

                // ── Loan history ──────────────────────────────────
                VStack(alignment: .leading, spacing: 0) {
                    DashSectionHeader(title: "Loan History")
                        .padding(.bottom, 6)

                    Group {
                        DateBand(label: "Today")
                        LoanTransactionRow(title: "Loan Disbursed", sub: "@ByteFinance",
                                           time: "02:19 PM", amount: "+₦150,000", positive: true)
                        Divider().padding(.leading, 72)
                        LoanTransactionRow(title: "Repayment",      sub: "@ByteFinance",
                                           time: "10:30 AM", amount: "-₦25,000",  positive: false)
                    }
                    Group {
                        DateBand(label: "Yesterday")
                        LoanTransactionRow(title: "Loan Disbursed", sub: "@ByteFinance",
                                           time: "11:00 AM", amount: "+₦80,000",  positive: true)
                        Divider().padding(.leading, 72)
                        LoanTransactionRow(title: "Repayment",      sub: "@ByteFinance",
                                           time: "09:45 AM", amount: "-₦12,000",  positive: false)
                    }
                }

                Spacer(minLength: 40)
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "bell")
                    .foregroundColor(.primary)
            }
        }
    }
}

// MARK: – Sub-components

private struct QuickActionButton: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 20))
            Text(title)
                .font(.system(size: 15, weight: .medium))
        }
        .foregroundColor(.primary)
        .frame(maxWidth: .infinity)
        .frame(height: 52)
        .background(Color.byteCardBg)
        .cornerRadius(12)
    }
}

private struct DashSectionHeader: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 18, weight: .bold))
            Spacer()
            Text("View all")
                .font(.system(size: 14))
                .foregroundColor(.byteGray)
        }
        .padding(.horizontal, 24)
    }
}

private struct ActiveLoanCard: View {
    let amount: String
    let label: String
    let due: String
    let progress: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("\(label) Loan")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.byteGray)
                Spacer()
                Image(systemName: "ellipsis")
                    .foregroundColor(.byteGray)
            }

            Text(amount)
                .font(.system(size: 22, weight: .bold))

            VStack(alignment: .leading, spacing: 6) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(Color.white).frame(height: 6)
                        Capsule().fill(Color.bytePurple).frame(width: geo.size.width * progress, height: 6)
                    }
                }
                .frame(height: 6)

                HStack {
                    Text("\(Int(progress * 100))% repaid")
                    Spacer()
                    Text("Due: \(due)")
                }
                .font(.system(size: 12))
                .foregroundColor(.byteGray)
            }
        }
        .padding(16)
        .frame(width: 220)
        .background(Color.byteCardBg)
        .cornerRadius(16)
    }
}

private struct DateBand: View {
    let label: String

    var body: some View {
        Text(label)
            .font(.system(size: 13, weight: .medium))
            .foregroundColor(.byteGray)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .background(Color.byteCardBg)
    }
}

private struct LoanTransactionRow: View {
    let title: String
    let sub: String
    let time: String
    let amount: String
    let positive: Bool

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.bytePurple.opacity(0.12))
                    .frame(width: 44, height: 44)
                Image(systemName: "building.columns.fill")
                    .font(.system(size: 18))
                    .foregroundColor(.bytePurple)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(title).font(.system(size: 15, weight: .semibold))
                Text(sub).font(.system(size: 13)).foregroundColor(.byteGray)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 3) {
                Text(time).font(.system(size: 12)).foregroundColor(.byteGray)
                Text(amount)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(positive ? .byteGreen : .byteRed)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 14)
    }
}

#Preview {
    NavigationStack { LoanDashboardView().environmentObject(Router()) }
}
