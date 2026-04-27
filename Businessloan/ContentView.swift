import SwiftUI

struct ContentView: View {
    @StateObject private var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            WelcomeView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .loanType:
                        LoanTypeView()

                    case .dashboard:
                        LoanDashboardView()

                    case .apply:
                        LoanApplyView()

                    case let .summary(amount, purpose, duration):
                        LoanSummaryView(amount: amount, purpose: purpose, duration: duration)

                    case let .success(amount, monthly, duration):
                        LoanSuccessView(amount: amount, monthly: monthly, duration: duration)
                    }
                }
        }
        .environmentObject(router)
    }
}

#Preview {
    ContentView()
}
