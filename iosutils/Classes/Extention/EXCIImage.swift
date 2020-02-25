
import UIKit
extension CIImage {
  func toUIImage() -> UIImage? {
    let context: CIContext = CIContext.init(options: nil)

    if let cgImage: CGImage = context.createCGImage(self, from: self.extent) {
      return UIImage(cgImage: cgImage)
    } else {
      return nil
    }
  }
func toCGImage() -> CGImage? {
        let context = CIContext.shared
        if let cgImage = context.createCGImage(self, from: self.extent) {
            return cgImage
        }
        return nil
}
        var averageLuminance: Double {
            let vector = CIVector(cgRect: extent)
            let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: self, kCIInputExtentKey: vector])!
            var bitmap = [UInt8](repeating: 0, count: 4)

            CIContext.shared.render(filter.outputImage!, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())

            let r = (Double(bitmap[0]) / 255) * 0.213
            let g = (Double(bitmap[1]) / 255) * 0.715
            let b = (Double(bitmap[2]) / 255) * 0.072

            return (r + g + b)
        }
}
extension UIImage{
    func crop(rect: CGRect) -> UIImage? {
      guard let cropped = self.cgImage?.cropping(to: rect) else {
        return nil
      }
      return UIImage(cgImage: cropped, scale: self.scale, orientation: self.imageOrientation)
    }
}
extension UIImage {
    /// Creates a UIImage from the specified CIImage.
    static func from(ciImage: CIImage) -> UIImage {
        if let cgImage = CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent) {
            return UIImage(cgImage: cgImage)
        } else {
            return UIImage(ciImage: ciImage, scale: 1.0, orientation: .up)
        }
    }

    /// Draws a new cropped and scaled (zoomed in) image.
    ///
    /// - Parameters:
    ///   - point: The center of the new image.
    ///   - scaleFactor: Factor by which the image should be zoomed in.
    ///   - size: The size of the rect the image will be displayed in.
    /// - Returns: The scaled and cropped image.
    func scaledImage(atPoint point: CGPoint, scaleFactor: CGFloat, targetSize size: CGSize) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }

        let scaledSize = CGSize(width: size.width / scaleFactor, height: size.height / scaleFactor)
        let midX = point.x - scaledSize.width / 2.0
        let midY = point.y - scaledSize.height / 2.0
        let newRect = CGRect(x: midX, y: midY, width: scaledSize.width, height: scaledSize.height)

        guard let croppedImage = cgImage.cropping(to: newRect) else {
            return nil
        }

        return UIImage(cgImage: croppedImage)
    }

    /// Scales the image to the specified size in the RGB color space.
    ///
    /// - Parameters:
    ///   - scaleFactor: Factor by which the image should be scaled.
    /// - Returns: The scaled image.
    func scaledImage(scaleFactor: CGFloat) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }

        let customColorSpace = CGColorSpaceCreateDeviceRGB()

        let width = CGFloat(cgImage.width) * scaleFactor
        let height = CGFloat(cgImage.height) * scaleFactor
        let bitsPerComponent = cgImage.bitsPerComponent
        let bytesPerRow = cgImage.bytesPerRow
        let bitmapInfo = cgImage.bitmapInfo.rawValue

        guard let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: customColorSpace, bitmapInfo: bitmapInfo) else { return nil }

        context.interpolationQuality = .high
        context.draw(cgImage, in: CGRect(origin: .zero, size: CGSize(width: width, height: height)))

        return context.makeImage().flatMap { UIImage(cgImage: $0) }
    }

}
