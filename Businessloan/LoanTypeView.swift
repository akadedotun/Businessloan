import SwiftUI

enum LoanType: String, CaseIterable {
    case business = "Business"
    case personal  = "Person"

    var icon: String {
        switch self {
        case .business: return "storefront"
        case .personal:  return "person.badge.checkmark"
        }
    }
}

struct LoanTypeView: View {
    @EnvironmentObject var router: Router
    @State private var selected: LoanType? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("What do you want\nto use Byte as?")
                .font(.system(size: 28, weight: .bold))
                .lineSpacing(2)
                .padding(.top, 48)
                .padding(.horizontal, 24)

            // Selection cards
            HStack(spacing: 16) {
                ForEach(LoanType.allCases, id: \.self) { type in
                    TypeCard(type: type, isSelected: selected == type)
                        .onTapGesture { selected = type }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 40)

            Spacer()

            Button {
                if selected != nil { router.goToDashboard() }
            } label: {
                Text("Continue")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(selected != nil ? Color.bytePurple : Color.byteGray)
                    .cornerRadius(14)
                    .animation(.easeInOut(duration: 0.2), value: selected)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 48)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color.white)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct TypeCard: View {
    let type: LoanType
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: type.icon)
                .font(.system(size: 38, weight: .light))
                .foregroundColor(isSelected ? .white : .primary)

            Text(type.rawValue)
                .font(.system(size: 16))
                .foregroundColor(isSelected ? .white : .primary)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 160)
        .background(isSelected ? Color.byteTeal : Color.white)
        .cornerRadius(18)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.bytePurple.opacity(0.25), lineWidth: 1.2)
        )
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

#Preview {
    NavigationStack { LoanTypeView().environmentObject(Router()) }
}
