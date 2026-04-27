import SwiftUI

extension Color {
    static let bytePurple  = Color(red: 107/255, green: 111/255, blue: 212/255)
    static let byteTeal    = Color(red: 61/255,  green: 145/255, blue: 158/255)
    static let byteCardBg  = Color(red: 242/255, green: 243/255, blue: 248/255)
    static let byteBadgeBg = Color(red: 142/255, green: 145/255, blue: 196/255)
    static let byteGreen   = Color(red: 52/255,  green: 199/255, blue: 89/255)
    static let byteRed     = Color(red: 255/255, green: 59/255,  blue: 48/255)
    static let byteGray    = Color(red: 142/255, green: 142/255, blue: 147/255)
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
