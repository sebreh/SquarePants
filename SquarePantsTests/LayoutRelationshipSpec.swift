import Quick
import Nimble

class LayoutRelationshipSpec: QuickSpec {
  override func spec() {
    
    describe("A layout relationship") {
    
      describe("when no condition has been given") {
      
        it("should set value") {
          let view = UIView()
          let frame = CGRect(x: 20, y: 20, width: 100, height: 100)
          
          LayoutRelationship<CGRect>(PropertySetter(view) { view, frame in
            view.frame = frame
          }).equal(frame).apply()
          
          expect(view.frame) == frame
        }
      }
      
      describe("when condition is met") {
        
        it("should set value") {
          let view = UIView()
          let frame = CGRect(x: 20, y: 20, width: 100, height: 100)
          
          LayoutRelationship<CGRect>(PropertySetter(view) { view, frame in
            view.frame = frame
          }).equal(frame).when(true).apply()
          
          expect(view.frame) == frame
        }
      }
      
      describe("when condition is not met") {
        
        it("should not set value") {
          let view = UIView()
          let frame = CGRect(x: 20, y: 20, width: 100, height: 100)
          
          LayoutRelationship<CGRect>(PropertySetter(view) { view, frame in
            view.frame = frame
          }).equal(frame).when(false).apply()
          
          expect(view.frame) == CGRect.zero
        }
      }
      
      describe("when no equality has been set") {
        
        it("should not set value") {
          let view = UIView()
          
          LayoutRelationship<CGRect>(PropertySetter(view) { view, frame in
            view.frame = frame
          }).apply()
          
          expect(view.frame) == CGRect.zero
        }
      }
      
      describe("when centering in superview") {
      
        it("should center the view in its superview") {
          let superview = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
          let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
          superview.addSubview(view)
          
          LayoutRelationship(view.sp_centerSetter).centerInSuperview().apply()
          
          expect(view.center).to(equal(CGPoint(x: 50, y: 100)))
        }
      }
    }
  }
}
