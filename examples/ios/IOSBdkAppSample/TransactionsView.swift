//
//  TransactionsView.swift
//  IOSBdkAppSample
//
//  Created by Sudarsan Balaji on 02/11/21.
//

import SwiftUI

extension Transaction {
    public func getDetails() -> TransactionDetails {
        switch self {
        case .unconfirmed(let details): return details
        case .confirmed(let details, _): return details
        }
    }
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

struct TransactionView: View {
    var transaction: Transaction
    
    var body: some View {
        VStack(alignment: .leading) {
            switch transaction {
            case .unconfirmed(let details):
                Text("id: \(details.id)")
                Text("sent: \(details.sent)")
                Text("received: \(details.received)")
                Text("fees: \(details.fees ?? 0)")
            case .confirmed(let details, let confirmation):
                Text("id: \(details.id)")
                Text("sent: \(details.sent)")
                Text("received: \(details.received)")
                Text("fees: \(details.fees ?? 0)")
                Text("confirmed via block \(confirmation.height) at \(Date(timeIntervalSince1970: TimeInterval(confirmation.timestamp)).getFormattedDate(format: "yyyy-MM-dd HH:mm:ss"))")
            }
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
    }
}

struct TransactionsView: View {
    var transactions: [Transaction]
    
    var body: some View {
        List {
            if transactions.isEmpty {
                Text("No transactions yet.").padding()
            } else {
                ForEach(transactions, id: \.self) { transaction in
                    TransactionView(transaction: transaction)
                }
            }
        }.navigationBarTitle("Transactions")
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(transactions: [Transaction.unconfirmed(details: TransactionDetails(fees: nil, received: 1000, sent: 10000, id: "some-tx-id")), Transaction.confirmed(details: TransactionDetails(fees: nil, received: 1000, sent: 10000, id: "some-other-tx-id"), confirmation: Confirmation(height: 20087, timestamp: 1635863544))])
    }
}
