import GLKit

// MARK: - OpenGL ES 3.0 函数式拓展

/**
三维向量
*/
@inline(__always) func GLKVector3Make(#x: Float, #y: Float, #z: Float) -> GLKVector3 {
    return GLKVector3Make(x, y, z)
}

/**
四维向量
*/
@inline(__always) func GLKVector4Make(#x: Float, #y: Float, #z: Float, #w: Float) -> GLKVector4 {
    return GLKVector4Make(x, y, z, w)
}

/**
四维向量表示颜色
*/
@inline(__always) func GLKColorMake(#red: Float, #green: Float, #blue: Float, #alpha: Float) -> GLKVector4 {
    return GLKVector4Make(red, green, blue, alpha)
}

/**
消除颜色缓冲中指定的颜色
*/
@inline(__always) func glClearColor(#red: GLfloat, #green: GLfloat, #blue: GLfloat, #alpha: GLfloat) {
    glClearColor(red, green, blue, alpha)
}

