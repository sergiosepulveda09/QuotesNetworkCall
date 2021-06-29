//
//  ContentView.swift
//  ProgrammingQuotesNetworkCall
//
//  Created by Sergio Sepulveda on 2021-06-28.
//

import SwiftUI

struct ContentView: View {
    
    @State private var quoteData: QuoteData?
    
    var body: some View {
        HStack {
           Spacer()
            VStack(alignment: .trailing) {
                Spacer()
                Text(quoteData?.content ?? "")
                    .font(.title2)
                Text("- \(quoteData?.author ?? "")")
                    .font(.title2)
                    .padding(.top)
                Spacer()
                
                Button(action: {
                    loadData()
                }, label: {
                    Image(systemName: "arrow.clockwise")
                })
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.top)
            }
        }
        .multilineTextAlignment(.trailing)
        .padding()
        .onAppear(perform: loadData)
    }
    
    private func loadData() {
        guard let url = URL(string: "https://api.quotable.io/random") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            guard let data = data else {
                return
            }
            if let decodedData = try? JSONDecoder().decode(QuoteData.self, from: data) {
                DispatchQueue.main.async {
                    self.quoteData = decodedData
                }
            }
        }.resume()
    }
}


struct QuoteData: Decodable {
    var _id: String
    var content: String
    var author: String
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
