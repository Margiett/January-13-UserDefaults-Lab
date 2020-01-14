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

    static func postAPI (postHoroscope: Horoscope,
                         completion: @escaping (Result<Bool, AppError>) -> ()) {
        // remember to change the url
        let horoscopeEndpointURL = "http://sandipbgt.com/theastrologer/api/horoscope/all/today"

        //MARK: Create a URL from the endpoint String
        guard let url = URL(string: horoscopeEndpointURL) else {
            completion(.failure(.badURL(horoscopeEndpointURL)))
            return
        }
        //MARK: converting to data
        do {
            let data = try JSONEncoder().encode(postHoroscope)

            //MARK: Confirgure out URLRequest
            // type of url
            var request = URLRequest(url: url)

            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            request.httpMethod = "POST"

            //MARK: Execute POST request
            // either our completion captures Data or AppError
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success:
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(.encodingError(error)))
        }
    }
    //MARK: if i delete for faves: [PuppyLove], there is no issue in the view controller
    static func getHoroscope(sign:String,
        completion: @escaping(Result <Horoscope, AppError>) -> ()) {
        // remember to change the url
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
   

    //MARK: This Function will post on the app favorites tab !


//    static func getfaves(favoritesPup: [PuppyLove], completion: @escaping (Result <[PuppyLove], AppError>) ->()) {
//        let favoritePosting = "http://5e0299e863d08b0014a289a4.mockapi.io/favorites"
//
//        guard let url = URL(string: favoritePosting) else {
//            completion(.failure(.badURL(favoritePosting)))
//            return
//        }
//
//        let request = URLRequest(url: url)
//        NetworkHelper.shared.performDataTask(with: request, completion: {
//            result in
//            switch result {
//            case .failure(let appError):
//                completion(.failure(.networkClientError(appError)))
//            case .success(let data):
//                do {
//                    let favPuppy = try JSONDecoder().decode([PuppyLove].self, from: data)
//                    completion(.success(favPuppy))
//                } catch {
//                    completion(.failure(.decodingError(error)))
//                }
//
//            }
//
//        })
//    }
}
