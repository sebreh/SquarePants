import Quick
import Nimble

class LazyPropertySpec: QuickSpec {
  override func spec() {
    
    describe("A lazy property") {
    
      it("should return evaluate to it's value") {
        let property = LazyProperty { 10 }
        expect(property.value).to(equal(10))
      }
    }
  }
}
