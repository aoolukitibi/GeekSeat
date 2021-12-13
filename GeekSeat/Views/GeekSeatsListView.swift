//
//  GeekSeatsListView.swift
//  GeekSeat
//
//  Created by Anthony Olukitibi on 12/8/21.
//

import SwiftUI

struct GeekSeatsListView: View {
    @ObservedObject var viewModel = GeekSeatsListViewModel()
    @State var isSearchingFor = ""
    
    var body: some View {
        NavigationView {
            List(viewModel.geekSeats, id: \.id) { seat in
                NavigationLink(destination: GeekSeatDetailView(seat: seat)) {
                    GeekSeatView(seat: seat)
                }
            }
            .searchable(text: $isSearchingFor)
            .onChange(of: isSearchingFor, perform: { newValue in
                viewModel.fetchGeekSeats(searchingFor: isSearchingFor)
            })
            .navigationTitle("Seats")
        }
        .onAppear {
            viewModel.fetchGeekSeats(searchingFor: isSearchingFor)
        }
        .accentColor(Color(.label))
    }
}

struct GeekSeatView: View {
    var seat: GeekSeatsViewModel
    
    var body: some View {
        HStack {
            if seat.performers?.count ?? 0 >= 1 {
                AsyncImage(url: URL(string: seat.performers?[0].image ?? "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 75)
                        .cornerRadius(4)
                } placeholder: {
                    ProgressView()
                }
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(seat.title ?? "")
                    .fontWeight(.semibold)
                    .lineLimit(2)
                Text("\(seat.venue?.city ?? ""), \(seat.venue?.state ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(seat.eventDate ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }    
}
