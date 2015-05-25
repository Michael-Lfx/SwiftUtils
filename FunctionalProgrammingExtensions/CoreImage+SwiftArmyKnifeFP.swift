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

/**
高斯模糊滤镜（CIGaussianBlur）

:param: radius 模糊半径

:returns: Filter函数
*/
func blur(radius: Float) -> Filter {
    return { inputImage in
        let parameters = [
            kCIInputImageKey: inputImage,
            kCIInputRadiusKey: radius]
        let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parameters)
        return filter.outputImage
    }
}

/**
颜色生成滤镜（CIConstantColorGenerator）

:param: color 颜色

:returns: Filter函数
*/
func colorGenerator(color: UIColor) -> Filter {
    return { _ in
        let parameters = [ kCIInputColorKey: color]
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
        let overlay = self.colorGenerator(color)(inputImage)
        return self.compositeSourceOver(overlay)(inputImage)
    }
}



