//
//  ViewController.swift
//  iosTool
//
//  Created by 韩李涛 on 2020/12/25.
//

import Cocoa
import SnapKit


class ViewController: NSViewController {
    var projectlable:NSTextField?
    var soure:NSTextField?
    var export:NSTextField?
    var inputString:String = ""
    var finishBtn:NSButton?
    override func viewDidLoad() {
        super.viewDidLoad()

        
//    let textFiled = NSTextField()
//    textFiled.isEditable = false
//    textFiled.stringValue = "/Users/hanlitao/Desktop/时代光华/云端学习定制/cloudstudy-revivee"
//    textFiled.backgroundColor = NSColor.clear
//    self.view.addSubview(textFiled)
//    textFiled.snp.makeConstraints { (make) in
//        make.left.equalTo(self.view.snp.left).offset(30)
//        make.top.equalTo(self.view.snp.top).offset(20)
//        make.width.equalTo(400)
//    }
//    self.projectlable = textFiled;
//    let choosebtn = NSButton()
//    self.view.addSubview(choosebtn)
//    choosebtn.title = "Brower"
//    choosebtn.snp.makeConstraints { (make) in
//        make.top.bottom.equalTo(textFiled)
//        make.left.equalTo(textFiled.snp.right).offset(5)
//    }
//    choosebtn.action = #selector(chooseProject)
    
     let sourcePath = NSTextField()
        sourcePath.backgroundColor = NSColor.clear
        self.view.addSubview(sourcePath)
        sourcePath.isEditable = false
        sourcePath.stringValue = "1024图片路径"
        sourcePath.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(30)
            make.top.equalTo(self.view.snp.top).offset(100)
        }
        
        let sourceFiled = NSTextField()
        sourceFiled.backgroundColor = NSColor.clear
        sourceFiled.isEditable = false
        self.view.addSubview(sourceFiled)
        sourceFiled.placeholderString = "请选择一个1024的png图片"
        sourceFiled.snp.makeConstraints { (make) in
            make.left.equalTo(sourcePath.snp.right).offset(5)
            make.top.equalTo(sourcePath.snp.top).offset(0)
            make.width.equalTo(300)
            make.bottom.equalTo(sourcePath)
        }
        self.soure  = sourceFiled;
        let savePath = NSTextField()
        savePath.backgroundColor = NSColor.clear
        savePath.isEditable = false
        self.view.addSubview(savePath)
        savePath.stringValue = "保存位置"
        savePath.snp.makeConstraints { (make) in
            make.left.equalTo(sourcePath.snp.left).offset(0)
            make.top.equalTo(sourcePath.snp.bottom).offset(20)
        }
        let btn = NSButton()
        self.view.addSubview(btn)
        btn.title = "Brower"
        btn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(sourceFiled)
            make.left.equalTo(sourceFiled.snp.right).offset(5)
        }
        btn.action = #selector(click)
        
        
        let saveFiled = NSTextField()
        saveFiled.backgroundColor = NSColor.clear
        saveFiled.isEditable = false
        self.view.addSubview(saveFiled)
        saveFiled.placeholderString = "请选择保存位置"
        saveFiled.snp.makeConstraints { (make) in
            make.left.equalTo(sourceFiled.snp.left).offset(0)
            make.top.equalTo(savePath.snp.top).offset(0)
            make.width.equalTo(300)
            make.bottom.equalTo(savePath.snp.bottom)
        }
        self.export = saveFiled;
        let savebtn = NSButton()
        self.view.addSubview(savebtn)
        savebtn.title = "Brower"
        savebtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(saveFiled)
            make.left.equalTo(saveFiled.snp.right).offset(5)
        }
        savebtn.action = #selector(save)
        
        
        let clicpbtn = NSButton()

        self.view.addSubview(clicpbtn)
        clicpbtn.title = "开始切图"
        clicpbtn.snp.makeConstraints { (make) in
            make.top.equalTo(saveFiled.snp.bottom).offset(30)
            make.centerX.equalTo(self.view)
        }
        clicpbtn.action = #selector(work)
        self.finishBtn = clicpbtn;
    
    }
    
  @objc  private func chooseProject(){
        let openDialog = NSOpenPanel()
        openDialog.canChooseFiles = false
        openDialog.canChooseDirectories = true
        openDialog.allowsMultipleSelection = false
        openDialog.allowsOtherFileTypes = false

        openDialog.beginSheetModal(for: self.view.window!) { (result) in
            if result == NSApplication.ModalResponse.OK{
                let path = openDialog.urls[0].absoluteString.removingPercentEncoding
               
                self.projectlable?.stringValue = path!.components(separatedBy: "///").last!

               
            }
        }
    }
    
    @objc  func work(_ sender: NSButton) {
        let manger = FileManager.default
        self.createAppiconset()
        self.clipImage(sourcepath: self.soure!.stringValue)
        self.createJsonFile()
        try! manger.copyItem(atPath: self.soure!.stringValue, toPath: self.inputString + "/1024.png")
        self.finishBtn?.isEnabled = false
        self.finishBtn?.title = "完成"
    }
    
    private func createJsonFile(){
        let jsonString = "{\n  \"images\" : [\n    {\n      \"filename\" : \"20@2x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"2x\",\n      \"size\" : \"20x20\"\n    },\n    {\n      \"filename\" : \"20@3x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"3x\",\n      \"size\" : \"20x20\"\n    },\n    {\n      \"filename\" : \"29@2x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"2x\",\n      \"size\" : \"29x29\"\n    },\n    {\n      \"filename\" : \"29@3x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"3x\",\n      \"size\" : \"29x29\"\n    },\n    {\n      \"filename\" : \"40@2x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"2x\",\n      \"size\" : \"40x40\"\n    },\n    {\n      \"filename\" : \"40@3x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"3x\",\n      \"size\" : \"40x40\"\n    },\n    {\n      \"filename\" : \"60@2x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"2x\",\n      \"size\" : \"60x60\"\n    },\n    {\n      \"filename\" : \"60@3x.png\",\n      \"idiom\" : \"iphone\",\n      \"scale\" : \"3x\",\n      \"size\" : \"60x60\"\n    },\n    {\n      \"filename\" : \"20@x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"1x\",\n      \"size\" : \"20x20\"\n    },\n    {\n      \"filename\" : \"20@2x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"2x\",\n      \"size\" : \"20x20\"\n    },\n    {\n      \"filename\" : \"29@x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"1x\",\n      \"size\" : \"29x29\"\n    },\n    {\n      \"filename\" : \"29@2x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"2x\",\n      \"size\" : \"29x29\"\n    },\n    {\n      \"filename\" : \"40@x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"1x\",\n      \"size\" : \"40x40\"\n    },\n    {\n      \"filename\" : \"40@2x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"2x\",\n      \"size\" : \"40x40\"\n    },\n    {\n      \"filename\" : \"76@x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"1x\",\n      \"size\" : \"76x76\"\n    },\n    {\n      \"filename\" : \"76@2x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"2x\",\n      \"size\" : \"76x76\"\n    },\n    {\n      \"filename\" : \"83.5@2x.png\",\n      \"idiom\" : \"ipad\",\n      \"scale\" : \"2x\",\n      \"size\" : \"83.5x83.5\"\n    },\n    {\n      \"filename\" : \"1024.png\",\n      \"idiom\" : \"ios-marketing\",\n      \"scale\" : \"1x\",\n      \"size\" : \"1024x1024\"\n    }\n  ],\n  \"info\" : {\n    \"author\" : \"xcode\",\n    \"version\" : 1\n  }\n}\n"
        let manger = FileManager.default
        let jsonData = jsonString.data(using: .utf8)
        manger.createFile(atPath: self.inputString + "/Contents.json", contents: jsonData!, attributes: nil)
    }
    
    
   private func createAppiconset(){
        let manger = FileManager.default
        
        let appiconset = self.export!.stringValue + "/AppIcon.appiconset"
        
        if manger.fileExists(atPath: appiconset) == false {
           try! manger.createDirectory(atPath: appiconset, withIntermediateDirectories: true, attributes: nil)
        }else{
           try! manger.removeItem(atPath: appiconset)
           try! manger.createDirectory(atPath: appiconset, withIntermediateDirectories: true, attributes: nil)
        }
        self.inputString = appiconset
    }
    
    
    
    
    
    @objc private func save(_ sender: NSButton) {
//        let saveDialog = NSSavePanel()
//        saveDialog.nameFieldStringValue = "Untitle.text"
//        saveDialog.message = "Choose the path to save the document"
//        saveDialog.allowedFileTypes = ["text"]
//        saveDialog.isExtensionHidden = false
//        saveDialog.beginSheetModal(for:self.view.window!) { (result) in
//            print(result)
//            if result == NSApplication.ModalResponse.OK{
//                //let path = saveDialog.urls[0]
//                print("ooooook")
//            }
//        }
        let openDialog = NSOpenPanel()
        openDialog.canChooseFiles = false
        openDialog.canChooseDirectories = true
        openDialog.allowsMultipleSelection = false
        openDialog.allowsOtherFileTypes = false

        openDialog.beginSheetModal(for: self.view.window!) { (result) in
            if result == NSApplication.ModalResponse.OK{
                let path = openDialog.urls[0].absoluteString.removingPercentEncoding
               
                self.export?.stringValue = path!.components(separatedBy: "///").last!

               
            }
        }
    }
    
    
    @objc private func click(_ sender: NSButton) {
        let openDialog = NSOpenPanel()
        openDialog.canChooseFiles = true
        openDialog.canChooseDirectories = false
        openDialog.allowsMultipleSelection = false
        openDialog.allowsOtherFileTypes = false
        openDialog.allowedFileTypes = ["png"]
        openDialog.beginSheetModal(for: self.view.window!) { (result) in
            if result == NSApplication.ModalResponse.OK{
                let path = openDialog.urls[0].absoluteString.removingPercentEncoding
                self.soure?.stringValue = path!.components(separatedBy: "///").last!
            }
        }
    }
    func clipImage(sourcepath:String)  {
        let sorceurl = URL(fileURLWithPath: sourcepath)
        let inoutData = try! Data.init(contentsOf: sorceurl)
        let dataProvider = CGDataProvider(data: inoutData as CFData)
        if let inputImage = CGImage(pngDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent) {
            if inputImage.width == 1024 {
                print(inputImage.width)
                       print("转换成功")
                
                createImage(image: inputImage, scale: 2, iphone: "iphone")
                createImage(image: inputImage, scale: 3, iphone: "iphone")
                
                createImage(image: inputImage, scale: 1, iphone: "ipad")
                createImage(image: inputImage, scale: 2, iphone: "ipad")

            }else{
                print("转换失败，图片必须是1024Px")
                
            }
            
        }else {
            print("转换失败，图片必须是png格式")
        }
    }
    
    //1024 1      2x 80 3x 120
    func createImage(image:CGImage,scale:Int,iphone:String){
        let iphoneArray  = [20,29,40,60.0]
        let ipadArray = [20,29,40,76,83.5]
        var name = ""
        
        var array = iphoneArray
        
        if iphone == "iphone" {
            
        }else{
            array = ipadArray
        }
        
        if scale == 1 {
            name = "@x"
        }
        if scale == 2 {
            name = "@2x"
        }
        if scale == 3 {
            name = "@3x"
        }
        
        for widthPt in array{
            if widthPt == 83.5 && scale == 1{
                continue
            }
            
                    let width = Int(widthPt*Double(scale))
                    let height = Int(widthPt*Double(scale))
            
                    var test = ""
                 
                  
                  if widthPt == 83.5 {
                      test   = String(widthPt) + "\(name)"
                  }else{
                 
                    
                     test = String(Int(widthPt)) + "\(name)"
                  }
                   
                   let fileName = test
            
                   
                  
                    let bitsPerComponent = image.bitsPerComponent
                    let bytesPerRow = image.bytesPerRow
                    let colorSpace  = CGColorSpaceCreateDeviceRGB()
                    
                    if let context = CGContext.init(data: nil,
                                                    width: width,
                                                    height: height,
                                                    bitsPerComponent: bitsPerComponent,
                                                    bytesPerRow: bytesPerRow,
                                                    space: colorSpace,
                                                    bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
                        context.interpolationQuality = .high
                        context.draw(image, in: .init(origin: .zero, size: .init(width: width, height: height)))
                        if let outputImage = context.makeImage() {
                            let outputImagePath = self.inputString + "/\(fileName).png"
                            let outputUrl = URL(fileURLWithPath: outputImagePath) as CFURL
                            let destination = CGImageDestinationCreateWithURL(outputUrl, kUTTypePNG, 1, nil)
                            if let destination = destination {
                                CGImageDestinationAddImage(destination, outputImage, nil)
                                if CGImageDestinationFinalize(destination) {
                                    print("图片生成成功\n")
                                }else {
                                    // print("图片: \(filename) 生成失败\n")
                                }
                            }
                        }else {
                            print("图片生成失败")
                        }
                    }
            }
    }



    
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

