//
// Be happy and free :)
//
// Nik Kov
// nik-kov.com
//

import UIKit

final class NKVFlagView: UIView {
    // MARK: - Interface
    /// Size of the flag icon
    var iconSize: CGSize     { didSet { configureInstance() } }
    /// Shifting for the icon from top, left, bottom and right.
    var insets: UIEdgeInsets { didSet { configureInstance() } }
    
    public var flagButton: UIButton = UIButton()
    
    /// Convenience method to set the flag with Country entity.
    public func setFlagWith(country: Country) {
        self.setFlag(with: country.countryCode)
    }
    
    /// Method for setting a flag with country (region) code.
    public func setFlag(with code: String?) {
        let code = code ?? "?"
        let flagImage = NKVSourcesHelper.getFlagImage(by: code)
        self.flagButton.setImage(flagImage, for: .normal)
        self.flagButton.imageView?.contentMode = .scaleAspectFit
    }
    
    public required init(with textField: UITextField) {
        self.textField = textField
        self.insets = UIEdgeInsetsMake(7, 7, 7, 0)
        self.iconSize = CGSize(width: 18.0, height: textField.frame.height)
        super.init(frame: CGRect.zero)
        configureInstance()
        setFlag(with: NKVLocalizationHelper.currentCode)
    }
    
    // MARK: - Implementation
    private weak var textField: UITextField!

    private func configureInstance() {
        // Setting flag view's frame
        self.frame = CGRect(x: 0,
                            y: 0,
                            width: insets.left + insets.right + iconSize.width,
                            height: max(textField.frame.height, iconSize.height))
        
        // Adding flag button to flag's view
        flagButton = UIButton.init(frame: self.frame)
        flagButton.imageEdgeInsets = insets;
        flagButton.contentMode = .scaleToFill
        if flagButton.superview == nil { self.addSubview(flagButton) }
        
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) not supported"); }
}