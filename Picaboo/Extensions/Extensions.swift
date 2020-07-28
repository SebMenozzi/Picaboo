//
//  Extensions.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 27/07/2020.
//

import UIKit

extension UIView {
    func makeCorner(withRadius radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        layer.isOpaque = false
    }
}

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1, color: UIColor = .black) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = color
        self.numberOfLines = numberOfLines
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIColor {
    convenience init?(hex: String) {
        // trim leading # if present
        var cleanedHexString = hex
        
        if hex.hasPrefix("#") {
            cleanedHexString = String(hex.dropFirst())
        }

        // String to UInt64
        var rgbValue: UInt64 = 0
        Scanner(string: cleanedHexString).scanHexInt64(&rgbValue)

        // UInt64 to rgb
        let red = CGFloat((rgbValue >> 16) & 0xff) / 255.0
        let green = CGFloat((rgbValue >> 08) & 0xff) / 255.0
        let blue = CGFloat((rgbValue >> 00) & 0xff) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension UIImageView {
    func loadImage(at url: URL) {
        UIImageLoader.shared.load(url, for: self)
    }

    func cancelImageLoad() {
        UIImageLoader.shared.cancel(for: self)
    }
}
