//
//  ViewController.swift
//  convertImagesToPdf
//
//  Created by 佐藤一輝 on 2015/08/21.
//  Copyright (c) 2015年 ichiki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIDocumentInteractionControllerDelegate {

    var pdfData: NSData?
    var docController:UIDocumentInteractionController?
    
    //
    @IBAction func showOpenIn(sender: AnyObject) {
        let fileName = (NSTemporaryDirectory() as NSString).stringByAppendingPathComponent("tmp_file.pdf")
        let url: NSURL! = NSURL(fileURLWithPath: fileName)
        pdfData!.writeToURL(url, atomically: true)
        
        if url != nil {
            docController = UIDocumentInteractionController(URL: url)
            docController?.delegate = self
            docController?.presentOptionsMenuFromRect(self.view.frame, inView: self.view, animated: true)
        }
       
        if NSFileManager.defaultManager().fileExistsAtPath(fileName) {
            print("existed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var sampleImages: Array<UIImage> = []
        
        sampleImages.append(UIImage(named: "g_sample001.jpg")!)
        sampleImages.append(UIImage(named: "g_sample001.jpg")!)
        
        pdfData = self.createPDF(sampleImages)!
        
    }

    //convert all images to a pdf
    func createPDF(images: [UIImage]) -> NSData? {
        //16:9 default image size
        let imageWidth: CGFloat = 1136
        let imageHeight: CGFloat = 640
        
        let pdfData: NSMutableData = NSMutableData()
        let pdfConsumer: CGDataConsumerRef = CGDataConsumerCreateWithCFData(pdfData as CFMutableDataRef)!
        
        var mediaBox: CGRect = CGRectMake(0, 0, imageWidth, imageHeight)
        
        let pdfContext: CGContextRef = CGPDFContextCreate(pdfConsumer, &mediaBox, nil)!
        
        for var index = 0; index < images.count; ++index {
            CGContextBeginPage(pdfContext, &mediaBox)
            CGContextDrawImage(pdfContext, mediaBox, images[index].CGImage)
            CGContextEndPage(pdfContext)
        }
        
        return pdfData
    }
    
    func deletePDF(path: String) {
        let manager = NSFileManager()
        let success:Bool
        do {
            try manager.removeItemAtPath(path)
            success = true
        } catch _ {
            success = false
        }
        
        if success{
            print("pdf has been deleted")
        }else{
            print("[error] pdf has not been deleted ")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

