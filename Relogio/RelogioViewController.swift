//
//  RelogioViewController.swift
//  Relogio
//
//  Created by Luicil Fernandes on 21/02/16.
//  Copyright © 2016 Luicil Fernandes. All rights reserved.
//

import UIKit

class RelogioViewController: UIViewController {
    
    @IBOutlet weak var imageViewRelogio: UIImageView!
    
    func startClock() {
        
        let cPers = RelogioPersistance()
        self.imageViewRelogio.image = cPers.loadImage()
        self.imageViewRelogio.alpha = CGFloat(cPers.loadTransparencia())
        
        let endAngle = CGFloat(2*M_PI)
        
        if let viewWithTag = self.view.viewWithTag(100){
            if let subLayers = self.view.layer.sublayers{
                for layer in subLayers{
                    var nome : String = ""
                    if layer.name != nil {
                        nome = layer.name!
                    }
                    
                    switch nome{
                    case "horas", "minutos", "segundos", "circulo":
                        layer.removeFromSuperlayer()
                    default:break
                    }
                }
            }
            self.view.bringSubviewToFront(viewWithTag)
            viewWithTag.removeFromSuperview()
            
        }
        
        let newView = View(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(self.view.frame), height: CGRectGetHeight(self.view.frame)))
        
        newView.tag = 100
        
        newView.backgroundColor = cPers.loadCor("corFundoTela", defaultColor: UIColor.blackColor())
        
        self.view.addSubview(newView)
        self.view.sendSubviewToBack(newView)
        
        let time = timeCoords(CGRectGetMidX(newView.frame), y: CGRectGetMidY(newView.frame), time: ctime(),radius: 50)
        // Do any additional setup after loading the view, typically from a nib.
        // Hours
        let hourLayer = CAShapeLayer()
        hourLayer.frame = newView.frame
        let path = CGPathCreateMutable()
        
        CGPathMoveToPoint(path, nil, CGRectGetMidX(newView.frame), CGRectGetMidY(newView.frame))
        CGPathAddLineToPoint(path, nil, time.h.x, time.h.y)
        hourLayer.path = path
        hourLayer.lineWidth = 4
        hourLayer.lineCap = kCALineCapRound
        
        //hourLayer.strokeColor = UIColor.blackColor().CGColor
        
        hourLayer.strokeColor = cPers.loadCor("corPontHoras", defaultColor: UIColor.blackColor()).CGColor
        
        // see for rasterization advice http://stackoverflow.com/questions/24316705/how-to-draw-a-smooth-circle-with-cashapelayer-and-uibezierpath
        hourLayer.rasterizationScale = UIScreen.mainScreen().scale;
        hourLayer.shouldRasterize = true
        hourLayer.name = "horas"
        self.view.layer.addSublayer(hourLayer)
        // time it takes for hour hand to pass through 360 degress
        rotateLayer(hourLayer,dur:43200, view:self)
        
        // Minutes
        let minuteLayer = CAShapeLayer()
        minuteLayer.frame = newView.frame
        let minutePath = CGPathCreateMutable()
        
        CGPathMoveToPoint(minutePath, nil, CGRectGetMidX(newView.frame), CGRectGetMidY(newView.frame))
        CGPathAddLineToPoint(minutePath, nil, time.m.x, time.m.y )
        minuteLayer.path = minutePath
        minuteLayer.lineWidth = 3
        minuteLayer.lineCap = kCALineCapRound
        
        //minuteLayer.strokeColor = UIColor.whiteColor().CGColor
        
        minuteLayer.strokeColor = cPers.loadCor("corPontMinutos", defaultColor: UIColor.whiteColor()).CGColor
        
        minuteLayer.rasterizationScale = UIScreen.mainScreen().scale;
        minuteLayer.shouldRasterize = true
        minuteLayer.name="minutos"
        self.view.layer.addSublayer(minuteLayer)
        rotateLayer(minuteLayer,dur: 3600, view:self)
        
        // Seconds
        let secondLayer = CAShapeLayer()
        secondLayer.frame = newView.frame
        
        let secondPath = CGPathCreateMutable()
        CGPathMoveToPoint(secondPath, nil, CGRectGetMidX(newView.frame), CGRectGetMidY(newView.frame))
        CGPathAddLineToPoint(secondPath, nil, time.s.x, time.s.y)
        
        secondLayer.path = secondPath
        secondLayer.lineWidth = 1
        secondLayer.lineCap = kCALineCapRound
        
        //secondLayer.strokeColor = UIColor.redColor().CGColor
        
        secondLayer.strokeColor = cPers.loadCor("corPontSegundos", defaultColor: UIColor.redColor()).CGColor
        
        secondLayer.rasterizationScale = UIScreen.mainScreen().scale;
        
        secondLayer.shouldRasterize = true
        secondLayer.name = "segundos"
        self.view.layer.addSublayer(secondLayer)
        rotateLayer(secondLayer,dur: 60, view:self)
        let centerPiece = CAShapeLayer()
        
        let circle = UIBezierPath(arcCenter: CGPoint(x:CGRectGetMidX(newView.frame),y:CGRectGetMidY(newView.frame)), radius: 4.5, startAngle: 0, endAngle: endAngle, clockwise: true)
        // thanks to http://stackoverflow.com/a/19395006/1694526 for how to fill the color
        centerPiece.path = circle.CGPath
        
        //centerPiece.fillColor = UIColor.blueColor().CGColor
        
        centerPiece.fillColor = cPers.loadCor("corCirculoCentroRelogio", defaultColor: UIColor.whiteColor()).CGColor
        
        centerPiece.name="circulo"
        self.view.layer.addSublayer(centerPiece)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.startClock()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "startClock",
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
        
        //self.tabBarController?.tabBar.hidden = true
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.startClock()
    }

}


func rotateLayer(currentLayer:CALayer,dur:CFTimeInterval, view:UIViewController){
    
    let angle = degree2radian(360)
    
    // rotation http://stackoverflow.com/questions/1414923/how-to-rotate-uiimageview-with-fix-point
    let theAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
    theAnimation.duration = dur
    // Make this view controller the delegate so it knows when the animation starts and ends
    theAnimation.delegate = view
    theAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    // Use fromValue and toValue
    theAnimation.fromValue = 0
    theAnimation.repeatCount = Float.infinity
    theAnimation.toValue = angle
    
    // Add the animation to the layer
    currentLayer.addAnimation(theAnimation, forKey:"rotate")
    
}

// MARK: Retrieve time
func ctime ()->(h:Int,m:Int,s:Int) {
    
    var t = time_t()
    time(&t)
    let x = localtime(&t) // returns UnsafeMutablePointer
    
    return (h:Int(x.memory.tm_hour),m:Int(x.memory.tm_min),s:Int(x.memory.tm_sec))
}
// END: Retrieve time

// MARK: Calculate coordinates of time
func  timeCoords(x:CGFloat,y:CGFloat,time:(h:Int,m:Int,s:Int),radius:CGFloat,adjustment:CGFloat=90)->(h:CGPoint, m:CGPoint,s:CGPoint) {
    let cx = x // x origin
    let cy = y // y origin
    var r  = radius // radius of circle
    var points = [CGPoint]()
    var angle = degree2radian(6)
    func newPoint (t:Int) {
        let xpo = cx - r * cos(angle * CGFloat(t)+degree2radian(adjustment))
        let ypo = cy - r * sin(angle * CGFloat(t)+degree2radian(adjustment))
        points.append(CGPoint(x: xpo, y: ypo))
    }
    // work out hours first
    var hours = time.h
    if hours > 12 {
        hours = hours-12
    }
    let hoursInSeconds = time.h*3600 + time.m*60 + time.s
    newPoint(hoursInSeconds*5/3600)
    
    // work out minutes second
    r = radius * 1.25
    let minutesInSeconds = time.m*60 + time.s
    newPoint(minutesInSeconds/60)
    
    // work out seconds last
    r = radius * 1.5
    newPoint(time.s)
    
    return (h:points[0],m:points[1],s:points[2])
}
// END: Calculate coordinates of hour

func degree2radian(a:CGFloat)->CGFloat {
    let b = CGFloat(M_PI) * a/180
    return b
}

func circleCircumferencePoints(sides:Int,x:CGFloat,y:CGFloat,radius:CGFloat,adjustment:CGFloat=0)->[CGPoint] {
    let angle = degree2radian(360/CGFloat(sides))
    let cx = x // x origin
    let cy = y // y origin
    let r  = radius // radius of circle
    var i = sides
    var points = [CGPoint]()
    while points.count <= sides {
        let xpo = cx - r * cos(angle * CGFloat(i)+degree2radian(adjustment))
        let ypo = cy - r * sin(angle * CGFloat(i)+degree2radian(adjustment))
        points.append(CGPoint(x: xpo, y: ypo))
        i--;
    }
    return points
}

func secondMarkers(ctx ctx:CGContextRef, x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, color:UIColor) {
    // retrieve points
    let points = circleCircumferencePoints(sides,x: x,y: y,radius: radius)
    // create path
    let path = CGPathCreateMutable()
    // determine length of marker as a fraction of the total radius
    var divider:CGFloat = 1/16
    //for p in enumerate(points) {
    for p in points.enumerate() {
        if p.index % 5 == 0 {
            divider = 1/8
        }
        else {
            divider = 1/16
        }
        
        let xn = p.element.x + divider*(x-p.element.x)
        let yn = p.element.y + divider*(y-p.element.y)
        // build path
        CGPathMoveToPoint(path, nil, p.element.x, p.element.y)
        CGPathAddLineToPoint(path, nil, xn, yn)
        CGPathCloseSubpath(path)
        // add path to context
        CGContextAddPath(ctx, path)
    }
    // set path color
    let cgcolor = color.CGColor
    CGContextSetStrokeColorWithColor(ctx,cgcolor)
    CGContextSetLineWidth(ctx, 3.0)
    CGContextStrokePath(ctx)
    
}

func drawText(rect rect:CGRect, ctx:CGContextRef, x:CGFloat, y:CGFloat, radius:CGFloat, sides:NumberOfNumerals, color:UIColor) {
    
    // Flip text co-ordinate space, see: http://blog.spacemanlabs.com/2011/08/quick-tip-drawing-core-text-right-side-up/
    CGContextTranslateCTM(ctx, 0.0, CGRectGetHeight(rect))
    CGContextScaleCTM(ctx, 1.0, -1.0)
    // dictates on how inset the ring of numbers will be
    let inset:CGFloat = radius/3.5
    // An adjustment of 270 degrees to position numbers correctly
    let points = circleCircumferencePoints(sides.rawValue,x: x,y: y,radius: radius-inset,adjustment:270)
    _ = CGPathCreateMutable()
    // multiplier enables correcting numbering when fewer than 12 numbers are featured, e.g. 4 sides will display 12, 3, 6, 9
    let multiplier = 12/sides.rawValue
    
    //for p in enumerate(points) {
    for p in points.enumerate() {
        if p.index > 0 {
            // Font name must be written exactly the same as the system stores it (some names are hyphenated, some aren't) and must exist on the user's device. Otherwise there will be a crash. (In real use checks and fallbacks would be created.) For a list of iOS 7 fonts see here: http://support.apple.com/en-us/ht5878
            let aFont = UIFont(name: "DamascusBold", size: radius/5)
            // create a dictionary of attributes to be applied to the string
            let attr:CFDictionaryRef = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:UIColor.whiteColor()]
            // create the attributed string
            let str = String(p.index*multiplier)
            let text = CFAttributedStringCreate(nil, str, attr)
            // create the line of text
            let line = CTLineCreateWithAttributedString(text)
            // retrieve the bounds of the text
            let bounds = CTLineGetBoundsWithOptions(line, CTLineBoundsOptions.UseOpticalBounds)
            // set the line width to stroke the text with
            CGContextSetLineWidth(ctx, 1.5)
            // set the drawing mode to stroke
            //CGContextSetTextDrawingMode(ctx, kCGTextStroke)
            
            CGContextSetTextDrawingMode(ctx, .FillStroke)
            
            
            // Set text position and draw the line into the graphics context, text length and height is adjusted for
            let xn = p.element.x - bounds.width/2
            let yn = p.element.y - bounds.midY
            CGContextSetTextPosition(ctx, xn, yn)
            // the line of text is drawn - see https://developer.apple.com/library/ios/DOCUMENTATION/StringsTextFonts/Conceptual/CoreText_Programming/LayoutOperations/LayoutOperations.html
            // draw the line of text
            CTLineDraw(line, ctx)
        }
    }
    
}

enum NumberOfNumerals:Int {
    case two = 2, four = 4, twelve = 12
}

class View: UIView {
    
    
    override func drawRect(rect:CGRect)
        
    {
        
        // obtain context
        let ctx = UIGraphicsGetCurrentContext()
        
        // decide on radius
        let rad = CGRectGetWidth(rect)/3.5
        
        let endAngle = CGFloat(2*M_PI)
        
        let cPers = RelogioPersistance()
        
        // add the circle to the context
        CGContextAddArc(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect), rad, 0, endAngle, 1)
        
        // set fill color
        //CGContextSetFillColorWithColor(ctx,UIColor.grayColor().CGColor)
        
        CGContextSetFillColorWithColor(ctx,cPers.loadCor("corFundoRelogio", defaultColor: UIColor.grayColor()).CGColor)
        
        // set stroke color
        //CGContextSetStrokeColorWithColor(ctx,UIColor.whiteColor().CGColor)
        
        CGContextSetStrokeColorWithColor(ctx,cPers.loadCor("corBordaDigitosRelogio", defaultColor: UIColor.whiteColor()).CGColor)
        
        // set line width
        CGContextSetLineWidth(ctx, 4.0)
        // use to fill and stroke path (see http://stackoverflow.com/questions/13526046/cant-stroke-path-after-filling-it )
        
        // draw the path
        
        // CGContextDrawPath(ctx, CGPathFillStroke);
        
        CGContextDrawPath(ctx, .FillStroke);
        
        secondMarkers(ctx: ctx!, x: CGRectGetMidX(rect), y: CGRectGetMidY(rect), radius: rad, sides: 60, color: UIColor.whiteColor())

        let sides : Int = cPers.loadDigRelogio()
        let nDig : NumberOfNumerals
        
        switch sides{
        case 1:
            nDig = .two
        case 2:
            nDig = .four
        case 3:
            nDig = .twelve
        default:
            nDig = .twelve
        }
        
        //drawText(rect:rect, ctx: ctx!, x: CGRectGetMidX(rect), y: CGRectGetMidY(rect), radius: rad, sides: .twelve, color: UIColor.whiteColor())
        
        drawText(rect:rect, ctx: ctx!, x: CGRectGetMidX(rect), y: CGRectGetMidY(rect), radius: rad, sides: nDig, color: UIColor.whiteColor())
        
    }
    
}
