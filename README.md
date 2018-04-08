<img src="assets/Rx_Logo_M.png" alt="Miss Electric Eel 2016" width="36" height="36"> UnfairCrypto: Algorithmic crypto trading for the masses
======

![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS-333333.svg) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Unfair Crypto is the quickest and simplest way to get started with algorithmic trading of crypto currencies (and derivatives). It currently supports Bitmex and Binance, and over time all exchanges that provide an API will be added. Unfair Crypto requires a Mac and uses [Swift](https://developer.apple.com/swift/), Apple's new programming language but you don't need to know Swift to get started using the platform, Unfair Crypto is made to be extremely simple to use, even for newcomers to the language or programming in general.

* [Introduction](#introduction)
* [Requirements](#requirements)
* [Tutorial](#tutorial)
* [Installation](#installation)
* [Usage](#usage)
* [Roadmap](#roadmap)
* [Feedback](#feedback)
* [Custom work](#custom work)

## Introduction

## Usage

## Requirements
We have some very exciting things in the pipeline that will change this, but at the moment, you need a Mac to get started with algorithmic crypto trading using Unfair Crypto. You can also use a [Hackintosh](https://hackintosh.com/) or a [virtual Mac](https://techsviewer.com/install-macos-high-sierra-vmware-windows/).

## Installation

The tutorial goes through the entire installation process in detail, but in general terms you need to perform the following steps:

* Create an [Apple ID](https://appleid.apple.com)
* Enroll in the free [Apple developer programme](https://developer.apple.com/programs/enroll/)
* Download and install [XCode](https://developer.apple.com/xcode/)
* Create an account at [Bitmex](https://www.bitmex.com) and/or [Binance](https://www.binance.com/)
* Create API keys at the exchange(s) you are intertested in using.
* Create an app and add Unfair Crypto to your app using Carthage (or use our template)
* Profit

## Tutorial

## Roadmap

Over the coming months, we will be rolling out a number of exciting features, including:

* Support for all remaining crypto exchanges
* Useful template trading apps that you can leverage to implement your own algorithms even faster
* Built-in support for RxSwift
* New platforms, making algo trading even more accessible

## Feedback

Create an issue here on Github or get in touch at info@unfair.me

## Custom work

Unfair Advantage is a software studio with deep knowledge of financial markets and algorithmic trading, with several Master's degrees in financial mathematics, a CFA holder, (Chartered Financial Analyst) and experienced traders in the team. We occasionally help customers implement their own algorithmic crypto strategies

###### ... understand

* [why use rx?](Documentation/Why.md)
* [the basics, getting started with RxSwift](Documentation/GettingStarted.md)
* [traits](Documentation/Traits.md) - what are `Single`, `Completable`, `Maybe`, `Driver`, `ControlProperty`, and `Variable` ... and why do they exist?
* [testing](Documentation/UnitTests.md)
* [tips and common errors](Documentation/Tips.md)
* [debugging](Documentation/GettingStarted.md#debugging)
* [the math behind Rx](Documentation/MathBehindRx.md)
* [what are hot and cold observable sequences?](Documentation/HotAndColdObservables.md)

###### ... install

* Integrate RxSwift/RxCocoa with my app. [Installation Guide](#installation)

###### ... hack around

* with the example app. [Running Example App](Documentation/ExampleApp.md)
* with operators in playgrounds. [Playgrounds](Documentation/Playgrounds.md)

###### ... interact

* All of this is great, but it would be nice to talk with other people using RxSwift and exchange experiences. <br />[![Slack channel](http://rxswift-slack.herokuapp.com/badge.svg)](http://slack.rxswift.org) [Join Slack Channel](http://slack.rxswift.org)
* Report a problem using the library. [Open an Issue With Bug Template](.github/ISSUE_TEMPLATE.md)
* Request a new feature. [Open an Issue With Feature Request Template](Documentation/NewFeatureRequestTemplate.md)
* Help out [Check out contribution guide](CONTRIBUTING.md)

###### ... compare

* [with other libraries](Documentation/ComparisonWithOtherLibraries.md).


###### ... find compatible

* libraries from [RxSwiftCommunity](https://github.com/RxSwiftCommunity).
* [Pods using RxSwift](https://cocoapods.org/?q=uses%3Arxswift).

###### ... see the broader vision

* Does this exist for Android? [RxJava](https://github.com/ReactiveX/RxJava)
* Where is all of this going, what is the future, what about reactive architectures, how do you design entire apps this way? [Cycle.js](https://github.com/cyclejs/cycle-core) - this is javascript, but [RxJS](https://github.com/Reactive-Extensions/RxJS) is javascript version of Rx.

## Usage

<table>
  <tr>
    <th width="30%">Here's an example</th>
    <th width="30%">In Action</th>
  </tr>
  <tr>
    <td>Define search for GitHub repositories ...</td>
    <th rowspan="9"><img src="https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/GithubSearch.gif"></th>
  </tr>
  <tr>
    <td><div class="highlight highlight-source-swift"><pre>
let searchResults = searchBar.rx.text.orEmpty
    .throttle(0.3, scheduler: MainScheduler.instance)
    .distinctUntilChanged()
    .flatMapLatest { query -> Observable&lt;[Repository]&gt; in
        if query.isEmpty {
            return .just([])
        }
        return searchGitHub(query)
            .catchErrorJustReturn([])
    }
    .observeOn(MainScheduler.instance)</pre></div></td>
  </tr>
  <tr>
    <td>... then bind the results to your tableview</td>
  </tr>
  <tr>
    <td width="30%"><div class="highlight highlight-source-swift"><pre>
searchResults
    .bind(to: tableView.rx.items(cellIdentifier: "Cell")) {
        (index, repository: Repository, cell) in
        cell.textLabel?.text = repository.name
        cell.detailTextLabel?.text = repository.url
    }
    .disposed(by: disposeBag)</pre></div></td>
  </tr>
</table>


## Requirements

* Xcode 9.0
* Swift 4.0
* Swift 3.x ([use `rxswift-3.0` branch](https://github.com/ReactiveX/RxSwift/tree/rxswift-3.0) instead)
* Swift 2.3 ([use `rxswift-2.0` branch](https://github.com/ReactiveX/RxSwift/tree/rxswift-2.0) instead)

## Installation

Rx doesn't contain any external dependencies.

These are currently the supported options:

### Manual

Open Rx.xcworkspace, choose `RxExample` and hit run. This method will build everything and run the sample app

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

**Tested with `pod --version`: `1.3.1`**

```ruby
# Podfile
use_frameworks!

target 'YOUR_TARGET_NAME' do
    pod 'RxSwift',    '~> 4.0'
    pod 'RxCocoa',    '~> 4.0'
end

# RxTest and RxBlocking make the most sense in the context of unit/integration tests
target 'YOUR_TESTING_TARGET' do
    pod 'RxBlocking', '~> 4.0'
    pod 'RxTest',     '~> 4.0'
end
```

Replace `YOUR_TARGET_NAME` and then, in the `Podfile` directory, type:

```bash
$ pod install
```

### [Carthage](https://github.com/Carthage/Carthage)

**Tested with `carthage version`: `0.26.2`**

Add this to `Cartfile`

```
github "ReactiveX/RxSwift" ~> 4.0
```

```bash
$ carthage update
```

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

**Tested with `swift build --version`: `Swift 4.0.0-dev (swiftpm-13126)`**

Create a `Package.swift` file.

```swift
// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "RxTestProject",
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", "4.0.0" ..< "5.0.0")
  ],
  targets: [
    .target(name: "RxTestProject", dependencies: ["RxSwift", "RxCocoa"])
  ]
)
```

```bash
$ swift build
```

To build or test a module with RxTest dependency, set `TEST=1`. ([RxSwift >= 3.4.2](https://github.com/ReactiveX/RxSwift/releases/tag/3.4.2))

```bash
$ TEST=1 swift test
```

### Manually using git submodules

* Add RxSwift as a submodule

```bash
$ git submodule add git@github.com:ReactiveX/RxSwift.git
```

* Drag `Rx.xcodeproj` into Project Navigator
* Go to `Project > Targets > Build Phases > Link Binary With Libraries`, click `+` and select `RxSwift-[Platform]` and `RxCocoa-[Platform]` targets


## References

* [http://reactivex.io/](http://reactivex.io/)
* [Reactive Extensions GitHub (GitHub)](https://github.com/Reactive-Extensions)
* [RxSwift RayWenderlich.com Book](https://store.raywenderlich.com/products/rxswift)
* [Boxue.io RxSwift Online Course](https://boxueio.com/series/rxswift-101) (Chinese 🇨🇳)
* [Erik Meijer (Wikipedia)](http://en.wikipedia.org/wiki/Erik_Meijer_%28computer_scientist%29)
* [Expert to Expert: Brian Beckman and Erik Meijer - Inside the .NET Reactive Framework (Rx) (video)](https://youtu.be/looJcaeboBY)
* [Reactive Programming Overview (Jafar Husain from Netflix)](https://www.youtube.com/watch?v=dwP1TNXE6fc)
* [Subject/Observer is Dual to Iterator (paper)](http://csl.stanford.edu/~christos/pldi2010.fit/meijer.duality.pdf)
* [Rx standard sequence operators visualized (visualization tool)](http://rxmarbles.com/)
* [Haskell](https://www.haskell.org/)

