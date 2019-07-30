
import UIKit

public final class ASSlider: UISlider {
    
    // MARK: Properties
    
    private lazy var label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    private lazy var imageView: UIImageView = UIImageView(image: UIImage(named: "pin", in: self.podBundle, compatibleWith: nil))
    
    private var podBundle: Bundle {
        
        let podBundle = Bundle(for: self.classForCoder)
        if let bundleURL = podBundle.url(forResource: "ASSlider", withExtension: "bundle") {
            
            if let bundle = Bundle(url: bundleURL) {
                return bundle
            } else {
                assertionFailure("Could not load the bundle")
            }
        } else {
            assertionFailure("Could not create a path to the bundle")
        }
        return podBundle
    }
    
    // MARK: Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    public required init(frame: CGRect, minimumValue: Float, maximumValue: Float, initialValue: Float = 0) {
        super.init(frame: frame)
        
        self.value = initialValue
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        
        self.imageView = UIImageView(image: UIImage(named: "pin", in: self.podBundle, compatibleWith: nil))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    // MARK: Methods
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.adjustPointer()
    }
    
    private func commonInit() {
        self.superview?.addSubview(imageView)
        self.superview?.addSubview(label)
        
        self.addTarget(self, action:#selector(ASSlider.adjustPointerForSlider(_:)), for: UIControl.Event.valueChanged)
        self.value = 0.0

        let pointerImage = UIImage(named: "pointer", in: self.podBundle, compatibleWith: nil)
        self.setThumbImage(pointerImage, for: UIControl.State())
        self.setThumbImage(pointerImage, for: .highlighted)
        
        self.minimumTrackTintColor = UIColor.lightGray
        self.maximumTrackTintColor = UIColor.lightGray
        
        self.setMinimumTrackImage(UIImage.imageWithColor(UIColor.lightGray), for: UIControl.State())
        self.setMaximumTrackImage(UIImage.imageWithColor(UIColor.lightGray), for: UIControl.State())
        
        label.textAlignment = .center
        
        adjustPointer()
    }
    
    override public func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: bounds.width, height: 10)
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        self.commonInit()
    }
    
    @objc func adjustPointerForSlider(_ slider: UISlider) {
        adjustPointer()
    }
    
    private func adjustPointer() {
        let roundedValue = round(self.value)
        self.value = roundedValue
        label.text = "\(Int(roundedValue))"
        label.center = CGPoint(x: self.thumbCenterX, y: self.frame.origin.y - 62)
        imageView.center = CGPoint(x: self.thumbCenterX, y: self.frame.origin.y - 50)
    }
    
}

extension UISlider {
    
    var thumbCenterX: CGFloat {
        let _trackRect = trackRect(forBounds: self.bounds)
        let _thumbRect = thumbRect(forBounds: self.bounds, trackRect: _trackRect, value: value)
        return _thumbRect.origin.x + _thumbRect.width + _thumbRect.width/2
    }
}

extension UIImage {
    
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.init(cgImage: image!.cgImage!)
    }
    
    class func imageWithColor(_ color: UIColor) -> UIImage {
        return UIImage.imageWithColor(color, circular: false)
    }
    
    class func imageWithColor(_ color: UIColor, circular: Bool) -> UIImage {
        let size: CGFloat = circular ? 100 : 1
        let rect = CGRect(x: 0.0, y: 0.0, width: size, height: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        if(circular) {
            context!.fillEllipse(in: rect)
        } else {
            context!.fill(rect)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
