# Pixela.swift
[![Actions Status](https://github.com/Econa77/Pixela.swift/workflows/Xcode-Build/badge.svg)](https://github.com/Econa77/Pixela.swift/actions)
[![Release version](https://img.shields.io/github/release/Econa77/Pixela.swift.svg)](https://github.com/Econa77/Pixela.swift/releases/latest)
[![License: MIT](https://img.shields.io/github/license/Econa77/Pixela.swift.svg)](https://github.com/Econa77/Pixela.swift/blob/master/LICENSE)
[![Version](https://img.shields.io/cocoapods/v/Pixela.svg)](http://cocoadocs.org/docsets/Pixela)
[![Platform](https://img.shields.io/cocoapods/p/Pixela.svg)](http://cocoadocs.org/docsets/Pixela)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SPM supported](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager)

[Pixela](https://pixe.la/) API client for Swift.

# Requirements
- Swift 5.0 or later
- iOS 11.0 or later
- macOS 10.12 or later

# Getting started
## Setting user configuration
To make a request other than the registration API, it is necessary to set configuration.

```swift
Pixela.shared.configuration = Configuration(username: "username", token: "secret-token")
```

## User registration
```swift
Pixela.shared.createUser(token: "secret-token", username: "username", isAgreeTermsOfService: true, isNotMinor: true, thanksCode: "thanks-code") { result in
    switch result {
    case let .success(configuration):
        // Succeed new user registration
        Pixela.shared.configuration = configuration
    case let .failure(error)
        // Failed registration
    }
}
```

## Other APIs
This library supports all [Pixela](https://pixe.la/) API as of May 6, 2020. Check here for a list of Pixela APIs. (https://docs.pixe.la/)

```swift
Pixela.shared.configuration = Configuration(username: "username", token: "secret-token")
Pixela.shared.getGraphs { result in
    switch result {
    case let .success(graphs):
        print(graphs)
    case let .failure(error):
        print(error)
    }
}
```

## Multi account handling
Instead of using a shared instance, can use a Pixela instance for multiple accounts by manage it yourself.

```
let user1 = Pixela(configuration: Configuration(username: "user1", token: "user1-secret-token"))

let user2 = Pixela(configuration: nil)
user2.configuration = Configuration(username: "user2", token: "user2-secret-token")
```

## Enterprise support
Change `APIConfiguration` to connect to the Enterprise version of Pixela.

```
Pixela.shared.apiConfiguration = APIConfiguration(baseURL: URL(string: "https://custom.pixe.la")!)

let pixela = Pixela(configuration: Configuration(username: "user1", token: "user1-secret-token"))
pixela.apiConfiguration = APIConfiguration(baseURL: URL(string: "https://custom-domain-pixela.com")!)
```

## Error cases
All errors in the library will return a `PixelaError`. `PixelaError` is the next 3 cases:

- `PixelaError.requestFailed`: Error while creating URLRequest from Request. (some APIKit.SessionTaskError.requestError)
- `PixelaError.connectionFailed`: Error of networking backend stack. (some APIKit.SessionTaskError.connectionError)
- `PixelaError.responseFailed(ResponseErrorReason)`: Error while handling response.

# Contributing
1. Fork it ( https://github.com/Econa77/Pixela.swift/fork )
2. Update git submodule (`carthage checkout --no-build --use-submodules` or `git submodule init && git submodule update`)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
