//
//  HTTPRequestMaking.swift
//  Exchange Rates
//
//  Created by Roman K on 09.03.2023.
//

import Foundation

enum HTTPRequestError: Error {
    case invalidResponse(URL)
    case forwarded(Error)
}

protocol HTTPRequestMaking {
    func send<T: Decodable>(url: URL, completion: @escaping (Result<T, HTTPRequestError>) -> Void)
}

class HTTPRequestMaker: HTTPRequestMaking {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func send<T: Decodable>(url: URL, completion: @escaping (Result<T, HTTPRequestError>) -> Void) {
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.forwarded(error)))
                return
            }

            guard
                let response = response as? HTTPURLResponse,
                response.statusCode < 400,
                let responseData = data
            else {
                completion(.failure(.invalidResponse(url)))
                return
            }

            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode(T.self, from: responseData)
                completion(.success(decoded))
            } catch let error {
                completion(.failure(.forwarded(error)))
            }
        }

        dataTask.resume()
    }
}
