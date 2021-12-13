//
//  GeekSeatDetailView.swift
//  GeekSeat
//
//  Created by Anthony Olukitibi on 12/9/21.
//

import SwiftUI

struct GeekSeatDetailView: View {
    var seat: GeekSeatsViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(seat.title ?? "")
                .font(.largeTitle)
            if seat.performers?.count ?? 0 >= 1 {
                AsyncImage(url: URL(string: seat.performers?[0].image ?? "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                }
            }
            Text(seat.eventDate ?? "")
                .font(.title2)
            Text("\(seat.venue?.city ?? ""), \(seat.venue?.state ?? "")")
                .font(.title2)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
