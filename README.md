# be Vigilant

## Concept

It's great that you can run both [Quick](https://github.com/quick/quick) and [Nimble](https://github.com/quick/nimble) separately, however that does come with a downside. One of Rspec's great features that helps me catch bugs in my tests is that it will raise an error if a test does not run any expectations.

This Pod bridges Quick and Nimble, and creates a contract between the two. which enforces that you will use Nimble matchers inside every Quick test. 

The code is short, well commented, but a little bit esoteric. You'd probably enjoy [reading it](https://github.com/orta/vigilant/blob/master/Vigilant/Classes/Vigilant.m).

## Examples

Here's a test suite with two tests:

``` swift
import Quick
import Nimble

class VigilantSpec: QuickSpec {
    override func spec() {

        it("This test will pass") {
            
        }

        it("This should pass too") {
            expect("Tests") == "Tests"
        }
    }
}
```

Simply by including the Pod "Vigilant" in your Podfile, you will see a message like this in your console:

```
Test Case '-[Vigilant_Tests.VigilantSpec This_test_will_pass]' started.
2016-04-10 16:07:29.026 Vigilant_Example[20344:1112445] 

Vigilant: Did not see any `expect`s in the test: 'This test will pass'

Test Case '-[Vigilant_Tests.VigilantSpec This_test_will_pass]' passed (0.013 seconds).
```

Making it easy to see what tests are running without any `expect`s being called.

## Hard mode

Maybe you want to go all out and enforce that every test have expectations, well, this Pod 
also provides a way to do that. In your Testing AppDelegate, call the `Vigilant` class's function
`startExpecting` to cause assertions instead of logs.

## Usage

To run the example project, run `pod try Vigilant`.

## Installation

Vigilant is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile in a test target:

```ruby
pod "Vigilant"
```

Once SwiftPM becomes useful I'll look into supporting that too.

## Author

Orta Therox, orta.therox@gmail.com

## License

Vigilant is available under the MIT license. See the LICENSE file for more info.
