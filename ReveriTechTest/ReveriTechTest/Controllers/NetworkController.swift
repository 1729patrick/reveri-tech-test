//
//  NetworkController.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import Combine
import Foundation

class NetworkController: ObservableObject {
    private var requests = Set<AnyCancellable>()
    
    func fetch<T: Decodable>(_ url: URL, defaultValue: T, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: url)
            .retry(1)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { response in
                if case .failure(let error) = response {
                    completion(.failure(error))
                }
            }, receiveValue: { data in
                completion(.success(data))
            })
            .store(in: &requests)
    }
    
    static var preview: NetworkController {
        NetworkController()
    }
}
