import Quick
import Nimble

class LayoutRelationshipSpec: QuickSpec {
  override func spec() {
    
    describe("A layout relationship") {
    
      describe("when no condition has been given") {
      
        it("should set value") {
          let view = UIView()
          let frame = CGRectMake(20, 20, 100, 100)
          
          LayoutRelationship<CGRect>(setter: PropertySetter(view) { view, frame in
            view.frame = frame
          }).equal(frame).apply()
          
          expect(view.frame) == frame
        }
      }
      
      describe("when condition is met") {
        
        it("should set value") {
          let view = UIView()
          let frame = CGRectMake(20, 20, 100, 100)
          
          LayoutRelationship<CGRect>(setter: PropertySetter(view) { view, frame in
            view.frame = frame
          }).equal(frame).when(true).apply()
          
          expect(view.frame) == frame
        }
      }
      
      describe("when condition is not met") {
        
        it("should not set value") {
          let view = UIView()
          let frame = CGRectMake(20, 20, 100, 100)
          
          LayoutRelationship<CGRect>(setter: PropertySetter(view) { view, frame in
            view.frame = frame
          }).equal(frame).when(false).apply()
          
          expect(view.frame) == CGRectZero
        }
      }
      
      describe("when no equality has been set") {
        
        it("should not set value") {
          let view = UIView()
          
          LayoutRelationship<CGRect>(setter: PropertySetter(view) { view, frame in
            view.frame = frame
          }).apply()
          
          expect(view.frame) == CGRectZero
        }
      }
    }
  }
}
