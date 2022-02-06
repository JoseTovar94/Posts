//
//  JSONParser.swift
//  postsTests
//
//  Created by Jose Tovar on 6/02/22.
//

import XCTest
import Foundation
@testable import posts

extension XCTestCase {
    
    func loadJson(fileName: String) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                //let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                //let jsonResult = try JSONDecoder().decode([PostTest].self, from: data)
                return data
            } catch {
                // handle error
            }
        }
        return Data()
    }
    
    func postDataFromJsonFile(fileName: String) -> [Post] {
        let dict: Data = loadJson(fileName: fileName) ?? Data()
        do {
            let jsonResult = try JSONDecoder().decode([Post].self, from: dict)
            return jsonResult
        } catch {
            
        }
        return [Post]()
    }
    
    func detailDataFromJsonFile(fileName: String) -> [Comments] {
        let dict: Data = loadJson(fileName: fileName) ?? Data()
        do {
            let jsonResult = try JSONDecoder().decode([Comments].self, from: dict)
            return jsonResult
        } catch {
            
        }
        return [Comments]()
    }
}
/*
struct PostTest: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
    var isFavorite: Bool?
    var isRead: Bool?
}
*/

/*
let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
let decodedObject = try JSONDecoder().decode([PostTest].self, from: data)
print("decode:", decodedObject)
*/
