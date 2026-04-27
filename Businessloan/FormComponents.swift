import SwiftUI

// MARK: – Step progress bar

struct StepProgressBar: View {
    let step: Int
    let total = 7

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 5) {
                ForEach(1...total, id: \.self) { i in
                    Capsule()
                        .fill(i <= step ? Color.bytePurple : Color.byteCardBg)
                        .frame(height: 4)
                        .animation(.easeInOut(duration: 0.25), value: step)
                }
            }
            Text("Step \(step) of \(total)")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.byteGray)
        }
    }
}

// MARK: – Text field

struct ByteTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboard: UIKeyboardType = .default
    var isSecure: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.byteGray)
            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                        .keyboardType(keyboard)
                }
            }
            .font(.system(size: 16))
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .background(Color.byteCardBg)
            .cornerRadius(10)
        }
    }
}

// MARK: – Amount field (₦ prefix, number-only)

struct ByteAmountField: View {
    let label: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.byteGray)
            HStack(spacing: 0) {
                Text("₦")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.byteGray)
                    .padding(.leading, 14)
                TextField("0", text: $text)
                    .keyboardType(.numberPad)
                    .font(.system(size: 16))
                    .padding(.vertical, 14)
                    .padding(.horizontal, 8)
            }
            .background(Color.byteCardBg)
            .cornerRadius(10)
        }
    }
}

// MARK: – State / bank dropdown

struct ByteDropdown: View {
    let label: String
    let placeholder: String
    let options: [String]
    @Binding var selection: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.byteGray)
            Menu {
                ForEach(options, id: \.self) { opt in
                    Button(opt) { selection = opt }
                }
            } label: {
                HStack {
                    Text(selection.isEmpty ? placeholder : selection)
                        .font(.system(size: 16))
                        .foregroundColor(selection.isEmpty ? Color(.placeholderText) : .primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 13))
                        .foregroundColor(.byteGray)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 14)
                .background(Color.byteCardBg)
                .cornerRadius(10)
            }
        }
    }
}

// MARK: – Chip selector

struct ChipGroup: View {
    let label: String
    let options: [String]
    @Binding var selection: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.byteGray)
            FlowLayout(spacing: 8) {
                ForEach(options, id: \.self) { opt in
                    Button { selection = opt } label: {
                        Text(opt)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(selection == opt ? .white : .primary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(selection == opt ? Color.bytePurple : Color.byteCardBg)
                            .cornerRadius(20)
                            .animation(.easeInOut(duration: 0.15), value: selection)
                    }
                }
            }
        }
    }
}

// MARK: – Primary button

struct PrimaryButton: View {
    let title: String
    var enabled: Bool = true
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(enabled ? Color.bytePurple : Color.byteGray)
                .cornerRadius(14)
                .animation(.easeInOut(duration: 0.2), value: enabled)
        }
        .disabled(!enabled)
    }
}

// MARK: – Step header

struct StepHeader: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 26, weight: .bold))
            Text(subtitle)
                .font(.system(size: 15))
                .foregroundColor(.byteGray)
        }
    }
}

// MARK: – Review row

struct ReviewRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.byteGray)
                .frame(width: 120, alignment: .leading)
            Text(value)
                .font(.system(size: 14, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
    }
}

// MARK: – Review card

struct ReviewCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.byteGray)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
            Divider()
            content()
        }
        .background(Color.byteCardBg)
        .cornerRadius(14)
    }
}

// MARK: – Simple flow layout for chips

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        let height = rows.map { $0.map { $0.sizeThatFits(.unspecified).height }.max() ?? 0 }
                         .reduce(0) { $0 + $1 + spacing } - spacing
        return CGSize(width: proposal.width ?? 0, height: max(height, 0))
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        var y = bounds.minY
        for row in rows {
            var x = bounds.minX
            let rowHeight = row.map { $0.sizeThatFits(.unspecified).height }.max() ?? 0
            for view in row {
                let size = view.sizeThatFits(.unspecified)
                view.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
                x += size.width + spacing
            }
            y += rowHeight + spacing
        }
    }

    private func computeRows(proposal: ProposedViewSize, subviews: Subviews) -> [[LayoutSubview]] {
        var rows: [[LayoutSubview]] = [[]]
        var x: CGFloat = 0
        let maxWidth = proposal.width ?? .infinity
        for view in subviews {
            let w = view.sizeThatFits(.unspecified).width
            if x + w > maxWidth, !rows[rows.endIndex - 1].isEmpty {
                rows.append([])
                x = 0
            }
            rows[rows.endIndex - 1].append(view)
            x += w + spacing
        }
        return rows
    }
}
