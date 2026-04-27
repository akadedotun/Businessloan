import SwiftUI
import Combine

enum Route: Hashable {
    case dashboard
    case step1Personal
    case step2Loan
    case step3Business
    case step4Income
    case step5Bank
    case step6Documents
    case step7Review
    case loanApproved
    case loanRejected
}

final class Router: ObservableObject {
    @Published var path = NavigationPath()

    func push(_ route: Route) {
        path.append(route)
    }

    func goToDashboard() {
        path = NavigationPath([Route.dashboard])
    }

    func startApplication() {
        path.append(Route.step1Personal)
    }
}
