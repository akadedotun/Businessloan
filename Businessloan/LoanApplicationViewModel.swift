import SwiftUI
import Combine

final class LoanApplicationViewModel: ObservableObject {

    // MARK: Step 1 – Personal details
    @Published var firstName  = ""
    @Published var lastName   = ""
    @Published var phone      = ""
    @Published var bvn        = ""
    @Published var dob        = Calendar.current.date(byAdding: .year, value: -28, to: Date()) ?? Date()
    @Published var homeAddress = ""
    @Published var stateOfResidence = ""

    // MARK: Step 2 – Loan amount + term
    @Published var loanAmount: Double = 500_000
    @Published var loanTerm   = 12
    @Published var loanPurpose = ""

    // MARK: Step 3 – Business basics
    @Published var businessName    = ""
    @Published var businessType    = ""
    @Published var cacNumber       = ""
    @Published var yearsInBusiness = ""
    @Published var businessAddress = ""
    @Published var businessState   = ""

    // MARK: Step 4 – Income verification
    @Published var monthlyRevenueText  = ""
    @Published var monthlyExpensesText = ""

    var monthlyRevenue:  Double { Double(monthlyRevenueText.filter(\.isNumber))  ?? 0 }
    var monthlyExpenses: Double { Double(monthlyExpensesText.filter(\.isNumber)) ?? 0 }
    var netMonthlyIncome: Double { monthlyRevenue - monthlyExpenses }

    // MARK: Step 5 – Bank linking
    @Published var bankName      = ""
    @Published var accountNumber = ""
    @Published var accountName   = ""

    // MARK: Step 6 – Documents
    @Published var cacUploaded           = false
    @Published var idUploaded            = false
    @Published var bankStatementUploaded = false
    @Published var utilityBillUploaded   = false

    // MARK: Derived
    var monthlyRepayment: Double {
        let r = 0.015          // 1.5 % / month  ≈ 18 % p.a.
        let n = Double(loanTerm)
        let p = loanAmount
        guard r > 0 else { return p / n }
        return p * r * pow(1 + r, n) / (pow(1 + r, n) - 1)
    }

    var totalRepayable: Double { monthlyRepayment * Double(loanTerm) }

    func fmt(_ v: Double) -> String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.maximumFractionDigits = 0
        return "₦\(f.string(from: NSNumber(value: v)) ?? "0")"
    }
}

// MARK: – Data

let nigerianStates: [String] = [
    "Abia","Adamawa","Akwa Ibom","Anambra","Bauchi","Bayelsa",
    "Benue","Borno","Cross River","Delta","Ebonyi","Edo",
    "Ekiti","Enugu","FCT Abuja","Gombe","Imo","Jigawa",
    "Kaduna","Kano","Katsina","Kebbi","Kogi","Kwara",
    "Lagos","Nasarawa","Niger","Ogun","Ondo","Osun",
    "Oyo","Plateau","Rivers","Sokoto","Taraba","Yobe","Zamfara"
]

let nigerianBanks: [String] = [
    "Access Bank","Fidelity Bank","First Bank","FCMB",
    "Guaranty Trust Bank","Heritage Bank","Jaiz Bank","Keystone Bank",
    "Kuda Bank","Moniepoint","Opay","Polaris Bank",
    "Stanbic IBTC","Sterling Bank","UBA","Union Bank",
    "Wema Bank","Zenith Bank"
]
