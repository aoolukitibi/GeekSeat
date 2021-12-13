//
//  GeekSeatsListViewModel.swift
//  GeekSeat
//
//  Created by Anthony Olukitibi on 12/9/21.
//

import Foundation

class GeekSeatsListViewModel: ObservableObject {
    @Published var geekSeats: [GeekSeatsViewModel] = []
    
    func fetchGeekSeats(searchingFor: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            WebService().fetchSeats(searchingFor: searchingFor) { [weak self] seats, error  in
                if let geekSeats = seats?.events {
                    DispatchQueue.main.async {
                        self?.geekSeats = geekSeats.map(GeekSeatsViewModel.init)
                    }
                } else {
                    //handle error accordingly
                    print(error?.localizedDescription ?? "")
                }
            }
        }
    }
}

struct GeekSeatsViewModel {
    
    let seat: GeekSeat
    
    var id: Int? {
        seat.id
    }
    var eventDate: String? {
        eventDateString
    }
    var title: String? {
        seat.title
    }
    var venue: Venue? {
        seat.venue
    }
    var performers: [Performer]? {
        seat.performers
    }
    
    
    var eventDateString: String? {
        guard let datetimeUTC = seat.datetimeUTC else { return nil }
        let stringToDateFormatter = DateFormatter()
        stringToDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        stringToDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = stringToDateFormatter.date(from: datetimeUTC)
        
        guard let date = date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, dd MMM yyyy"
        let dateString = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "h:mm a"
        let timeString = dateFormatter.string(from: date)
        
        return "\(dateString) \(timeString)"
    }
}
