//
//  NetworkManager.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/14.
//

import Foundation

protocol NetworkProtocol {
    func callWithAsync<Value>(endpoint: APIManager, httpCodes: HTTPCodes) async -> Result<Value, Error> where Value: Decodable
}

final class NetworkManager: NetworkProtocol {
    static let shared = NetworkManager()
    private let session: URLSession
    private let BASE_URL: String = "http://3.35.9.192:8282/api/viva"
    
    init() {
        self.session = URLSession.shared
    }
    /// API요청
    /// - Parameters:
    ///   - endpoint: 만들어진  URLRequest
    ///   - httpCodes: 반드시 특정 httpCode가 들어와야 할 경우에 작성(ex, 203만 들어와야 할 경우)
    /// - Returns: 필요한 데이터의 형태로 나감
    func callWithAsync<Value>(endpoint: APIManager, httpCodes: HTTPCodes = .success) async -> Result<Value, Error> where Value: Decodable {
        // 네트워크 연결 체크
//        guard NetworkMonitor.shared.isNetworkAvailable() else {
//            return .failure(APIError.networkError)
//        }
         
        do {
            let request = try endpoint.urlRequest(baseURL: BASE_URL)
//            print(#fileID, #function, #line, "- request url checking🍂: \(request)")
            let (data, response) = try await session.data(for: request)
            
            guard let code = (response as? HTTPURLResponse)?.statusCode else {
                throw APIError.unexpectedResponse
            }
            
            guard httpCodes.contains(code) else {
                if code == HTTPCodes.urlError {
                    throw APIError.invalidURL
                }
                
                throw APIError.httpCode(code)
            }
            
            
            let decoder = JSONDecoder()
            let decodeData = try decoder.decode(Value.self, from: data)
            return .success(decodeData)
        } catch let error {
            return .failure(error)
        }
    }
}
