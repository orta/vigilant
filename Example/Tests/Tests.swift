import Quick
import Nimble

class VigilantSpec: QuickSpec {
    override func spec() {
        describe("Vigilant's tiny test suite") {

            describe("FAILS -") {
                it("this should fail") { }

                it("this also should fail") {
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        expect(0) == 0
                    }
                }
            }

            describe("FAILS - shouldn't be affected by nested beforeEach") {
                beforeEach { }
                it("fails") { }
            }

            it("This should pass though") {
                expect("Tests") == "Tests"
            }
        }
    }
}
