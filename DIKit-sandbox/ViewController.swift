//
//  ViewController.swift
//  DIKit-sandbox
//
//  Created by Tatsuya Tanaka on 20170927.
//  Copyright © 2017年 tattn. All rights reserved.
//

import UIKit
import DIKit

final class ViewController: Injectable {
    struct Dependency {
        let apiClient: APIClient
    }

    init(dependency: Dependency) {}
}

protocol APIClient {}

protocol AppResolver: Resolver {
    func provideAPIClient() -> APIClient
}


protocol AppComponent: AppResolver /* , FooResolver, BarResolver */ {}


// MARK: - Production

final class ProductionAPIClient: APIClient {}

struct ProductionAppComponent: AppComponent {
    func provideAPIClient() -> APIClient {
        return ProductionAPIClient()
    }
}

struct App {
    let appComponent: AppComponent = ProductionAppComponent()

    init() {
        let vc = appComponent.resolveViewController() // 😆
    }
}

// MARK: - Test

final class MockAPIClient: APIClient {}

struct MockAppComponent: AppComponent {
    func provideAPIClient() -> APIClient {
        return MockAPIClient()
    }
}

struct MockApp {
    let appComponent: AppComponent = MockAppComponent()

    init() {
        let vc = appComponent.resolveViewController() // 😆
    }
}
