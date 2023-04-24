//
//  NetworkManager.swift
//  einarbeitung-zuelfiye
//
//  
//

import Foundation

/// NetworkService Klasse für die URL- Anfrage
class NetworkService {
    
    /// mit shared Zugriff auf NetworkService
    static let shared = NetworkService()
    
    private init() {}
    
    /// mit dieser Funktion wird deine URL- Anfrage erstellt.
    func request<T: Decodable>(
        _ fileURLWithPath: String,
        type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        /// mit filePath wird der Pfad zu der json Datei flavors hergestellt.
        
        // sollte eine URL angegegben werden?
        guard let filePath = Bundle.main.path(forResource: "flavors", ofType: "json") else {
            completion(.failure(NetworkingError.invalidUrl))
            return
        }
        
        let url = URL(fileURLWithPath: filePath)
        let request = URLRequest(url: url)
        
        /// dataTask gibt eine URLSessionDataTask-Instanz zurück und akzeptiert zwei Argumente, ein URL-Objekt und eine completion.
        /// wenn die dataTask fehlschlägt, hat der Fehler einen Wert. Wenn die Datenaufgabe erfolgreich ist, haben data und response einen Wert.
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, optionalError in
            if let error = optionalError {
                completion(.failure(NetworkingError.custom(error: error)))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkingError.invalidData))
                return
            }
            /// der JSONDecoder kann das Objekt kovertieren und falls es zu einem Fehler kommt, wird der Fehler im catch Block  aufgefangen.
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let res = try decoder.decode(T.self, from: data)
                completion(.success(res))
            } catch {
                completion(.failure(NetworkingError.failedToDecode(error: error)))
            }
        }
        dataTask.resume()
    }
}

extension NetworkService {
    enum NetworkingError: Error {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}
