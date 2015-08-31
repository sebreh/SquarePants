import Quick
import Nimble

class UIViewExtensionsSpec: QuickSpec {
  override func spec() {

    describe("A view") {
    
      it("should have a frame property") {
        let view = UIView(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        expect(view.sp_frame.value) == view.frame
      }
      
      it("should have a bounds property") {
        let view = UIView(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        expect(view.sp_bounds.value) == view.bounds
      }
      
      it("should have a width property") {
        let view = UIView(frame: CGRect(x: 20, y: 20, width: 80, height: 40))
        expect(view.sp_width.value) == 80
      }
      
      it("should have a height property") {
        let view = UIView(frame: CGRect(x: 20, y: 20, width: 80, height: 40))
        expect(view.sp_height.value) == 40
      }
    }
  }
}
