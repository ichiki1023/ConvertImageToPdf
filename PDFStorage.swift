import Foundation
//import Parse

class PDFStorage: NSObject {
    var name: String!
    var data: NSData!
    
    init(name: String, data: NSData) {
        self.name = name
        self.data = data
    }
    
    //既にレコードがあれば、updateするように仕向ける
    
    /*func savePDF() {
        let PDFObject = PFObject(className: "pdf")
        PDFObject["name"] = name
        PDFObject["data"] = data
        PDFObject.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                print("PDF has been saved")
            }
        }
    }*/
}
