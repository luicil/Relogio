//
//  RelogioViewController.swift
//  Relogio
//
//  Created by Luicil Fernandes on 21/02/16.
//  Copyright © 2016 Luicil Fernandes. All rights reserved.
//

import UIKit
import AudioToolbox

class RelogioViewController: UIViewController,UIGestureRecognizerDelegate,UITabBarControllerDelegate{
    
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
        let hourLayer = CAShapeLayer()
        hourLayer.frame = newView.frame
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, CGRectGetMidX(newView.frame), CGRectGetMidY(newView.frame))
        CGPathAddLineToPoint(path, nil, time.h.x, time.h.y)
        hourLayer.path = path
        hourLayer.lineWidth = 4
        hourLayer.lineCap = kCALineCapRound
        hourLayer.strokeColor = cPers.loadCor("corPontHoras", defaultColor: UIColor.blackColor()).CGColor
        hourLayer.rasterizationScale = UIScreen.mainScreen().scale;
        hourLayer.shouldRasterize = true
        hourLayer.name = "horas"
        self.view.layer.addSublayer(hourLayer)
        rotateLayer(hourLayer,dur:43200, view:self)
        let minuteLayer = CAShapeLayer()
        minuteLayer.frame = newView.frame
        let minutePath = CGPathCreateMutable()
        CGPathMoveToPoint(minutePath, nil, CGRectGetMidX(newView.frame), CGRectGetMidY(newView.frame))
        CGPathAddLineToPoint(minutePath, nil, time.m.x, time.m.y )
        minuteLayer.path = minutePath
        minuteLayer.lineWidth = 3
        minuteLayer.lineCap = kCALineCapRound
        minuteLayer.strokeColor = cPers.loadCor("corPontMinutos", defaultColor: UIColor.whiteColor()).CGColor
        minuteLayer.rasterizationScale = UIScreen.mainScreen().scale;
        minuteLayer.shouldRasterize = true
        minuteLayer.name="minutos"
        self.view.layer.addSublayer(minuteLayer)
        rotateLayer(minuteLayer,dur: 3600, view:self)
        let secondLayer = CAShapeLayer()
        secondLayer.frame = newView.frame
        let secondPath = CGPathCreateMutable()
        CGPathMoveToPoint(secondPath, nil, CGRectGetMidX(newView.frame), CGRectGetMidY(newView.frame))
        CGPathAddLineToPoint(secondPath, nil, time.s.x, time.s.y)
        secondLayer.path = secondPath
        secondLayer.lineWidth = 1
        secondLayer.lineCap = kCALineCapRound
        secondLayer.strokeColor = cPers.loadCor("corPontSegundos", defaultColor: UIColor.redColor()).CGColor
        secondLayer.rasterizationScale = UIScreen.mainScreen().scale;
        secondLayer.shouldRasterize = true
        secondLayer.name = "segundos"
        self.view.layer.addSublayer(secondLayer)
        rotateLayer(secondLayer,dur: 60, view:self)
        let centerPiece = CAShapeLayer()
        let circle = UIBezierPath(arcCenter: CGPoint(x:CGRectGetMidX(newView.frame),y:CGRectGetMidY(newView.frame)), radius: 4.5, startAngle: 0, endAngle: endAngle, clockwise: true)
        centerPiece.path = circle.CGPath
        centerPiece.fillColor = cPers.loadCor("corCirculoCentroRelogio", defaultColor: UIColor.whiteColor()).CGColor
        centerPiece.name="circulo"
        self.view.layer.addSublayer(centerPiece)
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        self.startClock()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(RelogioViewController.startClock),
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(RelogioViewController.handleTap))
        tap.delegate = self
        self.imageViewRelogio.userInteractionEnabled = true
        self.imageViewRelogio.addGestureRecognizer(tap)
        
        self.tabBarController?.delegate = self
        
        let ativNotif = AtivNotif()
        ativNotif.ativaNotifs(self)
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
             AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        self.startClock()
//        
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.startClock()
    }

    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        let idTab = viewController.tabBarItem.tag
        if idTab == 100 {
            self.handleTap()
        }
    }
    
    func handleTap() {
        //setTabBarVisible(!tabBarIsVisible(), animated: true)
        
        let tbh : Bool = (self.tabBarController?.tabBar.hidden)!
        self.tabBarController?.tabBar.hidden = !tbh
        self.startClock()
    }
    
//    func setTabBarVisible(visible: Bool, animated: Bool) {
//        let frame = self.tabBarController?.tabBar.frame
//        let height = frame?.size.height
//        let offsetY = (visible ? -height! : height)
//        let duration:NSTimeInterval = (animated ? 0.3 : 0.0)
//        if frame != nil {
//            UIView.animateWithDuration(duration) {
//                self.tabBarController?.tabBar.frame = CGRectOffset(frame!, 0, offsetY!)
//                self.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height + offsetY!)
//                self.view.setNeedsDisplay()
//                self.view.layoutIfNeeded()
//                return
//            }
//        }
//    }
//    
//    func tabBarIsVisible() -> Bool {
//        return self.tabBarController?.tabBar.frame.origin.y < UIScreen.mainScreen().bounds.height
//    }
    
}

func rotateLayer(currentLayer:CALayer,dur:CFTimeInterval, view:UIViewController){
    let angle = degree2radian(360)
    let theAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
    theAnimation.duration = dur
    theAnimation.delegate = view
    theAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    theAnimation.fromValue = 0
    theAnimation.repeatCount = Float.infinity
    theAnimation.toValue = angle
    currentLayer.addAnimation(theAnimation, forKey:"rotate")
}

func ctime ()->(h:Int,m:Int,s:Int) {
    
    var t = time_t()
    time(&t)
    let x = localtime(&t)
    
    return (h:Int(x.memory.tm_hour),m:Int(x.memory.tm_min),s:Int(x.memory.tm_sec))
}

func  timeCoords(x:CGFloat,y:CGFloat,time:(h:Int,m:Int,s:Int),radius:CGFloat,adjustment:CGFloat=90)->(h:CGPoint, m:CGPoint,s:CGPoint) {
    let cx = x
    let cy = y
    var r  = radius
    var points = [CGPoint]()
    var angle = degree2radian(6)
    func newPoint (t:Int) {
        let xpo = cx - r * cos(angle * CGFloat(t)+degree2radian(adjustment))
        let ypo = cy - r * sin(angle * CGFloat(t)+degree2radian(adjustment))
        points.append(CGPoint(x: xpo, y: ypo))
    }
    var hours = time.h
    if hours > 12 {
        hours = hours-12
    }
    let hoursInSeconds = time.h*3600 + time.m*60 + time.s
    newPoint(hoursInSeconds*5/3600)
    r = radius * 1.25
    let minutesInSeconds = time.m*60 + time.s
    newPoint(minutesInSeconds/60)
    r = radius * 1.5
    newPoint(time.s)
    return (h:points[0],m:points[1],s:points[2])
}

func degree2radian(a:CGFloat)->CGFloat {
    let b = CGFloat(M_PI) * a/180
    return b
}

func circleCircumferencePoints(sides:Int,x:CGFloat,y:CGFloat,radius:CGFloat,adjustment:CGFloat=0)->[CGPoint] {
    let angle = degree2radian(360/CGFloat(sides))
    let cx = x
    let cy = y
    let r  = radius
    var i = sides
    var points = [CGPoint]()
    while points.count <= sides {
        let xpo = cx - r * cos(angle * CGFloat(i)+degree2radian(adjustment))
        let ypo = cy - r * sin(angle * CGFloat(i)+degree2radian(adjustment))
        points.append(CGPoint(x: xpo, y: ypo))
        i -= 1;
    }
    return points
}

func secondMarkers(ctx ctx:CGContextRef, x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, color:UIColor) {
    let points = circleCircumferencePoints(sides,x: x,y: y,radius: radius)
    let path = CGPathCreateMutable()
    var divider:CGFloat = 1/16
    for p in points.enumerate() {
        if p.index % 5 == 0 {
            divider = 1/8
        }
        else {
            divider = 1/16
        }
        let xn = p.element.x + divider*(x-p.element.x)
        let yn = p.element.y + divider*(y-p.element.y)
        CGPathMoveToPoint(path, nil, p.element.x, p.element.y)
        CGPathAddLineToPoint(path, nil, xn, yn)
        CGPathCloseSubpath(path)
        CGContextAddPath(ctx, path)
    }
    let cgcolor = color.CGColor
    CGContextSetStrokeColorWithColor(ctx,cgcolor)
    CGContextSetLineWidth(ctx, 3.0)
    CGContextStrokePath(ctx)
    
}

func drawText(rect rect:CGRect, ctx:CGContextRef, x:CGFloat, y:CGFloat, radius:CGFloat, sides:NumberOfNumerals, color:UIColor) {
    CGContextTranslateCTM(ctx, 0.0, CGRectGetHeight(rect))
    CGContextScaleCTM(ctx, 1.0, -1.0)
    let inset:CGFloat = radius/3.5
    let points = circleCircumferencePoints(sides.rawValue,x: x,y: y,radius: radius-inset,adjustment:270)
    _ = CGPathCreateMutable()
    let multiplier = 12/sides.rawValue
    for p in points.enumerate() {
        if p.index > 0 {
            let aFont = UIFont(name: "DamascusBold", size: radius/5)
            let cPers = RelogioPersistance()
            let attr:CFDictionaryRef = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:(cPers.loadCor("corBordaDigitosRelogio", defaultColor: UIColor.whiteColor()))]
            let str = String(p.index*multiplier)
            let text = CFAttributedStringCreate(nil, str, attr)
            let line = CTLineCreateWithAttributedString(text)
            let bounds = CTLineGetBoundsWithOptions(line, CTLineBoundsOptions.UseOpticalBounds)
            CGContextSetLineWidth(ctx, 1.5)
            CGContextSetTextDrawingMode(ctx, .FillStroke)
            let xn = p.element.x - bounds.width/2
            let yn = p.element.y - bounds.midY
            CGContextSetTextPosition(ctx, xn, yn)
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
        let ctx = UIGraphicsGetCurrentContext()
        let rad = CGRectGetWidth(rect)/3.5
        let endAngle = CGFloat(2*M_PI)
        let cPers = RelogioPersistance()
        CGContextAddArc(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect), rad, 0, endAngle, 1)
        CGContextSetFillColorWithColor(ctx,cPers.loadCor("corFundoRelogio", defaultColor: UIColor.grayColor()).CGColor)
        CGContextSetStrokeColorWithColor(ctx,cPers.loadCor("corBordaDigitosRelogio", defaultColor: UIColor.whiteColor()).CGColor)
        CGContextSetLineWidth(ctx, 4.0)
        CGContextDrawPath(ctx, .FillStroke);
        secondMarkers(ctx: ctx!, x: CGRectGetMidX(rect), y: CGRectGetMidY(rect), radius: rad, sides: 60, color: (cPers.loadCor("corBordaDigitosRelogio", defaultColor: UIColor.whiteColor())))
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
        drawText(rect:rect, ctx: ctx!, x: CGRectGetMidX(rect), y: CGRectGetMidY(rect), radius: rad, sides: nDig, color: UIColor.whiteColor())
    }
}
