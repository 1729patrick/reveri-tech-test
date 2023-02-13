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
    
    func fetch<T: Decodable>(_ url: URL, defaultValue: T, completion: @escaping (T) -> Void) {
        URLSession.shared.dataTaskPublisher(for: url)
            .retry(1)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .replaceError(with: defaultValue)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &requests)
    }
    
    static var preview: NetworkController {
        NetworkController()
    }
}
