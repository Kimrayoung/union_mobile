//
//  MockNetworkManager.swift
//  union_mobileTests
//
//  Created by 김라영 on 2025/01/14.
//

import Foundation
@testable import union_mobile

/// 네트워크 테스트할 모의객체
final class MockNetworkManager: NetworkProtocol {
    var mockData: Data? /// 테스트할 데이터
    var mockResponse: HTTPURLResponse? /// 들어온다고 가정할 응답
    var mockError: Error? /// 들어온다고 가정할 테스트들
    
    func callWithAsync<Value>(endpoint: APIManager, httpCodes: HTTPCodes = .success) async -> Result<Value, Error> where Value: Decodable {
        if let error = mockError {
            return .failure(error)
        }
        
        guard let response = mockResponse else {
            return .failure(APIError.unexpectedResponse)
        }
        
        guard httpCodes.contains(response.statusCode) else {
            if response.statusCode == HTTPCodes.badRequest {
                print(#fileID, #function, #line, "- error")
                return .failure(APIError.invalidURL)
            }
            return .failure(APIError.httpCode(response.statusCode))
        }
        
        do {
            guard let data = mockData else {
                throw APIError.unexpectedResponse
            }
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(Value.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
}
