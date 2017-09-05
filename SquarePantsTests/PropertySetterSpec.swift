import Quick
import Nimble

class PropertySetterSpec: QuickSpec {
  override func spec() {
    
    describe("A property setter") {
    
      it("should execute the set block") {
        let view = UIView(frame: CGRect.zero)
        let setter = PropertySetter<CGRect>(view) { view, frame in
          view.frame = frame
        }
        
        setter.set(CGRect(x: 10, y: 10, width: 20, height: 20))
        
        expect(view.frame).to(equal(CGRect(x: 10, y: 10, width: 20, height: 20)))
      }
    }
  }
}
