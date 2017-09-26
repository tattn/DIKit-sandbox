//
//  App.swift
//  DIKit-sandbox
//
//  Created by Tatsuya Tanaka on 20170927.
//  Copyright © 2017年 tattn. All rights reserved.
//

import UIKit
import DIKit

// MARK: - DIKit

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

// MARK: - App

struct App {
    let appComponent: AppComponent

    func setup() {
        let vc = appComponent.resolveViewController() // 😆
    }
}

// MARK: - Production

final class ProductionAPIClient: APIClient {}

struct ProductionAppComponent: AppComponent {
    func provideAPIClient() -> APIClient {
        return ProductionAPIClient()
    }
}

struct Production {
    func main() {
        let app = App(appComponent: ProductionAppComponent())
    }
}

// MARK: - Test

final class MockAPIClient: APIClient {}

struct MockAppComponent: AppComponent {
    func provideAPIClient() -> APIClient {
        return MockAPIClient()
    }
}

struct Test {
    func main() {
        let app = App(appComponent: MockAppComponent())
    }
}
