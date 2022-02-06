//
//  postsTests.swift
//  postsTests
//
//  Created by Jose Tovar on 4/02/22.
//

import XCTest
@testable import posts

class postsTests: XCTestCase {
    var sut: HomeViewController?

    override func setUpWithError() throws {
        sut = ViewControllerCatalog.Home.createInstance() as? HomeViewController
        XCTAssertNotNil(sut, "No se encontró el ViewController en el Storyboard o no tiene asignada la clase correcta.")
        sut?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    //MARK: testData
    func testInitData() {
        //Given
        let dataObject: [Post] = postDataFromJsonFile(fileName: "post")
        let data = dataObject.map{PostViewModel.init(id: $0.id ?? 0, title: $0.title ?? "", body: $0.body ?? "", isFavorite: false, isRead: false)}
        sut?.viewModel.postList = data
        
        //When
        sut?.viewModel.saveListToRealm()

        //Then
        XCTAssertNotNil(dataObject)
        XCTAssertNotNil(data)
        XCTAssertNotNil(sut?.viewModel.postList)
        XCTAssertEqual(sut?.viewModel.postList?[0].id, 1)
    }
    
    func testGetDataFromDB() {
        //Given
        sut?.viewModel.postList = getDataJson()
        sut?.viewModel.postList?[0].id = 50
        
        //When
        sut?.viewModel.saveListToRealm()
        DispatchQueue.main.async {
            self.sut?.viewModel.getListFromDB()
        }
        
        //Then
        XCTAssertNotNil(sut?.viewModel.postList)
        XCTAssertEqual(sut?.viewModel.postList?[0].id, 50)
    }
    
    func testDeletePostDataFromDB() {
        //Given
        sut?.viewModel.postList = getDataJson()
        
        //When
        sut?.viewModel.deletePost(index: 0)
        
        //Then
        XCTAssertNotNil(sut?.viewModel.postList)
        XCTAssertEqual(sut?.viewModel.postList?[0].id, 2)
    }
    
    func testDeleteAllDataFromDB() {
        //Given
        sut?.viewModel.postList = getDataJson()
        
        //When
        sut?.viewModel.deleteListAll()
        
        //Then
        XCTAssertNotNil(sut?.viewModel.postList)
        XCTAssertEqual(sut?.viewModel.postList?.count, 0)
    }
    
    func getDataJson() -> [PostViewModel] {
        let dataObject: [Post] = postDataFromJsonFile(fileName: "post")
        let data = dataObject.map{PostViewModel.init(id: $0.id ?? 0, title: $0.title ?? "", body: $0.body ?? "", isFavorite: false, isRead: false)}
        return data
    }

    //MARK: testView
    func testHasATableView() {
        XCTAssertNotNil(sut?.tableView)
    }

    func testTableViewHasDelegate() {
        XCTAssertNotNil(sut?.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(((sut?.conforms(to: UITableViewDelegate.self)) != nil))
        XCTAssertTrue(((sut?.responds(to: #selector(sut?.tableView(_:didSelectRowAt:)))) != nil))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(sut?.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(((sut?.conforms(to: UITableViewDataSource.self)) != nil))
        XCTAssertTrue(((sut?.responds(to: #selector(sut?.tableView(_:numberOfRowsInSection:)))) != nil))
        XCTAssertTrue(((sut?.responds(to: #selector(sut?.tableView(_:cellForRowAt:)))) != nil))
    }

}
