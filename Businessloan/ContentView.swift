import SwiftUI

struct ContentView: View {
    @StateObject private var router = Router()
    @StateObject private var loanVM = LoanApplicationViewModel()

    var body: some View {
        NavigationStack(path: $router.path) {
            WelcomeView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .dashboard:        LoanDashboardView()
                    case .step1Personal:    Step1PersonalView()
                    case .step2Loan:        Step2LoanView()
                    case .step3Business:    Step3BusinessView()
                    case .step4Income:      Step4IncomeView()
                    case .step5Bank:        Step5BankView()
                    case .step6Documents:   Step6DocumentsView()
                    case .step7Review:      Step7ReviewView()
                    case .loanApproved:     LoanSuccessView()
                    case .loanRejected:     LoanRejectedView()
                    }
                }
        }
        .environmentObject(router)
        .environmentObject(loanVM)
    }
}

#Preview {
    ContentView()
}
