//
//  WebService.swift
//  GeekSeat
//
//  Created by Anthony Olukitibi on 12/11/21.
//

import Foundation

class WebService {
    func fetchSeats(searchingFor: String, complete:@escaping (GeekSeats?, Error?) -> ()) {
        let searchFor = searchingFor != "" ? searchingFor : "swift"
        let urlString = "https://api.seatgeek.com/2/events?client_id=MjQ4NjI4MjN8MTYzOTA4NDAwMC44NjgxOTY&q=\(searchFor)"
        guard let url = URL(string: urlString) else {
            return
        }
        let request = NSMutableURLRequest(url: url)
        let task = URLSession(configuration: .default).dataTask(with: request as URLRequest) { data, response, error in
            if let _ = response {
                do {
                    if let data = data {
                        let geekSeats = try JSONDecoder().decode(GeekSeats.self, from: data)
                        complete(geekSeats, nil)
                    }
                } catch let error {
                    //handle error accordingly
                    print(error.localizedDescription)
                    complete(nil, error)
                }
            } else {
                if let error = error {
                    //handle error accordingly
                    print(error.localizedDescription)
                    complete(nil, error)
                }
            }
        }
        task.resume()
    }
}
