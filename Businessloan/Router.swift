import SwiftUI
import Combine

enum Route: Hashable {
    case loanType
    case dashboard
    case apply
    case summary(amount: Int, purpose: String, duration: Int)
    case success(amount: String, monthly: String, duration: Int)
}

final class Router: ObservableObject {
    @Published var path = NavigationPath()

    func push(_ route: Route) {
        path.append(route)
    }

    func goToDashboard() {
        path = NavigationPath([Route.dashboard])
    }
}
