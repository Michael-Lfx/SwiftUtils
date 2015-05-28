import UIKit

// MARK: - 运算符

infix operator >>> { associativity left }

/**
管道运算符，fooX >>> footY表示fooX(a)的输出为fooY(b)的输入，类似UNIX管道

:param: lhs 函数fooX
:param: rhs 函数fooY

:returns: 接收footX输入参数且返回值为fooY输出的函数
*/
func >>> <T, U, V>(lhs: T -> U, rhs: U -> V) -> (T -> V) {
    return { x in rhs(lhs(x)) }
}

// MARK: - Core Image 函数式拓展

public typealias Filter = CIImage -> CIImage

// MARK: 生成器（CICategoryGenerator）

/**
颜色生成滤镜（CIConstantColorGenerator）

:param: color 颜色

:returns: Filter函数
*/
func colorGenerator(color: UIColor) -> Filter {
    return { _ in
        let parameters = [ kCIInputColorKey: color ]
        let filter = CIFilter(name: "CIConstantColorGenerator", withInputParameters: parameters)
        return filter.outputImage
    }
}

/**
资源合成滤镜 (CISourceOverCompositing)

:param: overlay 遮罩层

:returns: Filter函数
*/
func compositeSourceOver(overlay: CIImage) -> Filter {
    return { inputImage in
        let parameters = [
            kCIInputBackgroundImageKey: inputImage,
            kCIInputImageKey: overlay]
        let filter = CIFilter(name:"CISourceOverCompositing", withInputParameters: parameters)
        return filter.outputImage.imageByCroppingToRect(inputImage.extent())
    }
}

/**
在现有的图片上加上一层颜色蒙版

:param: color 蒙版颜色

:returns: Filter函数
*/
func colorOverlay(color: UIColor) -> Filter {
    return { inputImage in
        let overlay = colorGenerator(color)(inputImage)
        return compositeSourceOver(overlay)(inputImage)
    }
}

/**
色彩控制

:param: brightness 亮度，有效范围[-1, 1]
:param: contrast 对比度，有效范围[0.25, 4]
:param: saturation 饱和度，有效范围[0, 3]

:returns: Filter函数
*/
func colorControls(brightness: Float = 0, contrast: Float = 1, saturation: Float = 3) -> Filter {
    return { inputImage in
        let parameters = [
            kCIInputImageKey: inputImage,
            "inputBrightness": brightness,
            "inputContrast": contrast,
            "inputSaturation": saturation]
        let filter = CIFilter(name: "CIColorControls", withInputParameters: parameters)
        return filter.outputImage
    }
}

// MARK: 模糊（CICategoryBlur）

/**
放大模糊（CIZoomBlur）

:param: center 模糊中心点
:param: radius 模糊半径

:returns: Filter函数
*/
func zoomBlur(center: CIVector, radius: Float = 20) -> Filter {
    return { inputImage in
        let parameters = [
            kCIInputImageKey: inputImage,
            kCIInputRadiusKey: radius,
            kCIInputCenterKey: center]
        let filter = CIFilter(name: "CIZoomBlur", withInputParameters: parameters)
        return filter.outputImage
    }
}

/**
高斯模糊滤镜（CIGaussianBlur）

:param: radius 模糊半径，有效范围[0, 100]

:returns: Filter函数
*/
func gaussianBlur(radius: Float = 10) -> Filter {
    return { inputImage in
        let parameters = [
            kCIInputImageKey: inputImage,
            kCIInputRadiusKey: radius]
        let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parameters)
        return filter.outputImage
    }
}

/**
动感模糊（CIMotionBlur）

:param: radius 模糊半径，有效范围[0, 200]
:param: angle 模糊角度，有效范围[-3.141592653589793, 3.141592653589793]

:returns: Filter函数
*/
func motionBlur(radius: Float = 20, angle: Float = 0) -> Filter {
    return { inputImage in
        let parameters = [
            kCIInputImageKey: inputImage,
            kCIInputRadiusKey: radius,
            kCIInputAngleKey: angle]
        let filter = CIFilter(name: "CIMotionBlur", withInputParameters: parameters)
        return filter.outputImage
    }
}

// MARK: 色彩调整（CICategoryColorAdjustment）

/**
白点调整

:param: color 色彩，默认值不透明白色(1, 1, 1, 1)

:returns: Filter函数
*/
func whitePointAdjust(color: UIColor) -> Filter {
    return { inputImage in
        let parameters = [
            kCIInputImageKey: inputImage,
            kCIInputColorKey: color]
        let filter = CIFilter(name: "CIWhitePointAdjust", withInputParameters: parameters)
        return filter.outputImage
    }
}

// MARK: 合成操作（CICategoryCompositeOperation）

// MARK: 色彩特效（CICategoryColorEffect）

/**
CISepiaTone

:param: intensity 强度，有效值[0, 1]

:returns: Filter函数
*/
func sepiaTone(intensity: Float = 1) -> Filter {
    return { inputImage in
        let parameters = [
            kCIInputImageKey: inputImage,
            kCIInputIntensityKey: intensity]
        let filter = CIFilter(name: "CISepiaTone", withInputParameters: parameters)
        return filter.outputImage
    }
}

/**
CIVignette

:param: intensity 强度，有效值[-1, 1]
:param: radius 半径，有效值[0, 2]

:returns: Filter函数
*/
func vignette(intensity: Float = 0, radius: Float = 1) -> Filter {
    return { inputImage in
        let parameters = [
            kCIInputImageKey: inputImage,
            kCIInputIntensityKey: intensity,
            kCIInputRadiusKey: radius]
        let filter = CIFilter(name: "CIVignette", withInputParameters: parameters)
        return filter.outputImage
    }
}

/**
CIColorClamp

:param: inputMinComponents
:param: inputMaxComponents

:returns: Filter函数
*/
func colorClamp(min: CIVector, max: CIVector) -> Filter {
    return { inputImage in
        let parameters = [
            kCIInputImageKey: inputImage,
            "inputMinComponents": min,
            "inputMaxComponents": max]
        let filter = CIFilter(name: "CIColorClamp", withInputParameters: parameters)
        return filter.outputImage
    }
}


// MARK: 平铺特效（CICategoryTileEffect）

/**
CIAffineClamp

:param: transform

:returns: Filter函数
*/
func affineClamp(transform: CGAffineTransform) -> Filter {
    return { inputImage in
        let parameters = [
            kCIInputImageKey: inputImage,
            kCIInputTransformKey: NSValue(CGAffineTransform: transform)]
        let filter = CIFilter(name: "CIAffineClamp", withInputParameters: parameters)
        return filter.outputImage
    }
}

/**
CIAffineTile

:param: transform

:returns: Filter函数
*/
func affineTile(transform: CGAffineTransform) -> Filter {
    return { inputImage in
        let parameters = [
            kCIInputImageKey: inputImage,
            kCIInputTransformKey: NSValue(CGAffineTransform: transform)]
        let filter = CIFilter(name: "CIAffineTile", withInputParameters: parameters)
        return filter.outputImage
    }
}
