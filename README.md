UnfairCrypto: Algorithmic crypto trading for the masses
======

![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS-333333.svg) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Unfair Crypto is the quickest and simplest way to get started with algorithmic trading of crypto currencies (and derivatives). It currently supports Bitmex and Binance, and over time all exchanges that provide an API will be added. Unfair Crypto requires a Mac and uses [Swift](https://developer.apple.com/swift/), Apple's new programming language. But you don't need to know Swift to get started using the platform! Unfair Crypto is made to be extremely simple to use, even for newcomers to the language or programming in general.

* [Background](#background)
* [Usage](#usage)
* [Requirements](#requirements)
* [Installation](#installation)
* [Tutorial](#tutorial)
* [Roadmap](#roadmap)
* [Feedback](#feedback)
* [Consulting](#consulting)

## Background

Unfair Advantage is a Scandinavian software development company that specialises in very challenging projects within fields such as drone and fintech, and Unfair Crypto was built for the [Skye crypto fund](https://skyecrypto.com), a crypto arbitrage fund that until recently was only taking private investments. When they decided to take investments from the broader community through an ICO they wanted a reliable toolchain that facilitated fast iteration and minimised the time spent fixing bugs. The result is the UnfairCrypto platform, which is gradually being open-sourced. It is extremely easy to use and highly extensible, and now anyone can use it to implement their crypto trading ideas, build visualisation tools or any other crypto related Mac or iOS app they can imagine.

The first part of the platform to be released is the interface for obtaining data from and placing orders at two major exchanges, Bitmex and Binance. Over time the entire toolchain will be open-sourced.

## Usage

Unfair Crypto covers the entire APIs of both exchanges, which in turn means that anything you can do in the web interfaces, you can do with Unfair Crypto -- from getting the latest quotes to placing complex interlinked orders.

### Examples

Places a simple limit order for 0.1 Cardano's at a price of 23 BTC, and prints the order status

```swift

// Sets up your API key and secret
Bitmex.setup(id: "My API id", secret: "My API secret")

// Places a simple limit buy order for 8 Ether's at a price of 0.065 BTC, and prints the order status
Bitmex.rest
    .order
    .create(symbol: .eth, side: .buy, quantity: 8)
    .limit(price: 0.065)
    .handleSuccess { order in print(order.ordStatus) }

// Send a chat message
Bitmex.rest
    .chat
    .send("Hello world")
    .handleSuccess { _ in print("Message was sent succesfully") }
```

## Requirements
We have some very exciting things in the pipeline that will change this, but at the moment, you need a Mac to get started with algorithmic crypto trading using Unfair Crypto. You can also use a [Hackintosh](https://hackintosh.com/) or a [virtual Mac](https://techsviewer.com/install-macos-high-sierra-vmware-windows/).

## Installation

The tutorial goes through everything in detail, but in general terms you need to perform the steps below. The whole process takes less than 30 minutes and is entirely free.

* Create an [Apple ID](https://appleid.apple.com)
* Enroll in the [Apple developer programme](https://developer.apple.com/programs/enroll/)
* Download and install [XCode](https://developer.apple.com/xcode/)
* Create an account at [Bitmex](https://www.bitmex.com) and/or [Binance](https://www.binance.com/)
* Create API keys at the exchange(s) you are intertested in using.
* Create an app and add Unfair Crypto to your app using Carthage (`github UnfairAdvantage/UnfairCrypto`) (or use our app template)
* Profit

## Tutorial

[Tutorials and instructions](Tutorial)

## Roadmap

Over the coming months, we will be rolling out a number of exciting features, including:

* Support for all remaining crypto exchanges
* Useful template trading apps that you can leverage to implement your own algorithms even faster
* Built-in support for RxSwift
* New platforms, making algo trading even more accessible

## Feedback

Create an issue here on Github or get in touch at info@unfair.me

## Consulting

Get in touch with us at [Unfair Advantage](hhtps://unfair.me) for enquiries about custom requirements or full implementations of your trading ideas.
