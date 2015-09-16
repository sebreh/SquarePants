import Quick
import Nimble

class LayoutMakerSpec: QuickSpec {
  override func spec() {
    
    describe("A layout maker") {
    
      it("should keep a reference to its view") {
        let view = UIView()
        let maker = LayoutMaker(view: view)
        expect(maker.view).to(equal(view))
      }
      
      it("should set the center of a view") {
        let view = UIView()
        let make = LayoutMaker(view: view)
        
        let center = CGPoint(x: 10, y: 10)
        make.center.equal(center).apply()
        
        expect(view.center).to(equal(center))
      }
      
      it("should set the frame of a view") {
        let view = UIView()
        let make = LayoutMaker(view: view)
        
        let frame = CGRectMake(10, 10, 20, 20)
        make.frame.equal(frame).apply()
        
        expect(view.frame).to(equal(frame))
      }
    }
  }
}
