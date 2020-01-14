//
//  APIClient.swift
//  January 13 UserDefaults Lab
//
//  Created by Margiett Gil on 1/13/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation
import NetworkHelper

struct APIClient {
    static func getHoroscope(sign:String,
        completion: @escaping(Result <Horoscope, AppError>) -> ()) {
        
        let idEndpointUrl = "http://sandipbgt.com/theastrologer/api/horoscope/\(sign)/today"

        guard let url = URL(string: idEndpointUrl) else {
            completion(.failure(.badURL(idEndpointUrl)))

            return
        }
        let request = URLRequest(url: url)

        NetworkHelper.shared.performDataTask(with: request) { (result) in

            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let horoscopeAPI = try JSONDecoder().decode(Horoscope.self, from: data)
                    completion(.success(horoscopeAPI))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
   


}
