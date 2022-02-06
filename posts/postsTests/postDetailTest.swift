//
//  postDetailTest.swift
//  postsTests
//
//  Created by Jose Tovar on 6/02/22.
//

import XCTest
@testable import posts

class postDetailTest: XCTestCase {
    var sut: DetailViewController?

    override func setUpWithError() throws {
        sut = ViewControllerCatalog.Detail.createInstance() as? DetailViewController
        XCTAssertNotNil(sut, "No se encontró el ViewController en el Storyboard o no tiene asignada la clase correcta.")
        sut?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    //MARK: testData
    func testInitData() {
        //Given
        sut?.viewModel.post = getPostDataJson()
        let dataComments = getDetailDataJson()
        
        //When
        sut?.viewModel.viewModel.cells.append(.init(idState: .infoUser, postViewModel: sut?.viewModel.post, commentsViewModel: nil))
        sut?.viewModel.viewModel.cells.append(.init(idState: .comments, postViewModel: nil, commentsViewModel: dataComments))
        
        //then
        XCTAssertNotNil(sut?.viewModel.viewModel.cells)
        XCTAssertTrue((sut?.viewModel.viewModel.cells.count ?? 0) > 0)
        XCTAssertEqual(sut?.viewModel.viewModel.cells[0].postViewModel?.id, 1)
        XCTAssertEqual(sut?.viewModel.viewModel.cells[1].commentsViewModel?[2].id, 3)
    }
    
    func getPostDataJson() -> PostViewModel {
        let dataObject: [Post] = postDataFromJsonFile(fileName: "post")
        let data = dataObject.map{PostViewModel.init(id: $0.id ?? 0, title: $0.title ?? "", body: $0.body ?? "", isFavorite: false, isRead: false)}
        return data[0]
    }
    
    func getDetailDataJson() -> [Comments] {
        let data: [Comments] = detailDataFromJsonFile(fileName: "postDetail")
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
