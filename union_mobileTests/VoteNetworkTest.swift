//
//  VoteNetworkTest.swift
//  union_mobileTests
//
//  Created by 김라영 on 2025/01/14.
//

import XCTest
@testable import union_mobile

final class VoteNetworkTest: XCTestCase {
    /// CandidateList 파싱 테스트
    func testCadidateDataDecoding() async throws {
//        print("test start")
//        XCTAssert(true)
//        print("test end")
//        Given
        let mockNetworkManager = MockNetworkManager()
        print(#fileID, #function, #line, "- here")
        // Mock response 설정
        let jsonString = """
           {
               "content": [
                   {
                       "id": 48,
                       "candidateNumber": 1,
                       "name": "Gana",
                       "profileUrl": "https://angkorchat-bucket.s3.ap-southeast-1.amazonaws.com/candidate/48/409425fa12d842e092a4e4db87263009.png",
                       "voteCnt": "21"
                   }
               ],
               "pageable": {
                   "sort": {
                       "empty": true,
                       "sorted": false,
                       "unsorted": true
                   },
                   "offset": 0,
                   "pageNumber": 0,
                   "pageSize": 20,
                   "paged": true,
                   "unpaged": false
               },
               "totalPages": 1,
               "totalElements": 9,
               "last": true,
               "size": 20,
               "number": 0,
               "sort": {
                   "empty": true,
                   "sorted": false,
                   "unsorted": true
               },
               "numberOfElements": 9,
               "first": true,
               "empty": false
           }
           """
        
        mockNetworkManager.mockData = jsonString.data(using: .utf8)
        mockNetworkManager.mockResponse = HTTPURLResponse(url: URL(string: "https://test.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        let result: Result<PageCandidateList, Error> = await mockNetworkManager.callWithAsync(endpoint: VoteAPIManager.fetchCandidateList(sortType: "string"))
        
        //Then
        switch result {
        case .success(let data):
            XCTAssertEqual(data, PageCandidateList(content: [Candidate(id: 48, candidateNumber: 1, name: "Gana", profileUrl: "https://angkorchat-bucket.s3.ap-southeast-1.amazonaws.com/candidate/48/409425fa12d842e092a4e4db87263009.png", voteCnt: "21")], pageable: Pageable(sort: Sort(empty: true, sorted: false, unsorted: true), offset: 0, pageNumber: 0, pageSize: 20, paged: true, unpaged: false), totalPages: 1, totalElements: 9, last: true, size: 20, number: 0, sort: Sort(empty: true, sorted: false, unsorted: true), numberOfElements: 9, first: true, empty: false))
        case .failure(let failure):
            XCTFail("decoding fail:\(failure)")
        }
    }
}
