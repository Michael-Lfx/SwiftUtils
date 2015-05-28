import GLKit

// MARK: - OpenGL ES 3.0 函数式拓展

// MARK: 函数

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

/**
计算数据长度并返回GLsizei类型结果
*/
@inline(__always) func sizeof<T>(_: T.Type) -> GLsizei {
    return GLsizei(Swift.sizeof(T))
}

// MARK: 数据结构
/* 包装OpenGL的部分数据类型，避免每次转换 */

/* BeginMode */
let GLPoints        = GLenum(GL_POINTS)
let GLLines         = GLenum(GL_LINES)
let GLLineLoop      = GLenum(GL_LINE_LOOP)
let GLLineStrip     = GLenum(GL_LINE_STRIP)
let GLTriangles     = GLenum(GL_TRIANGLES)
let GLTriangleStrip = GLenum(GL_TRIANGLE_STRIP)
let GLTriangleFan   = GLenum(GL_TRIANGLE_FAN)

/* DataType */
let GLByte         = GLenum(GL_BYTE)
let GLUnsignedByte = GLenum(GL_UNSIGNED_BYTE)
let GLShort        = GLenum(GL_SHORT)
let GLUnsignedShot = GLenum(GL_UNSIGNED_SHORT)
let GLInt          = GLenum(GL_INT)
let GLUnsignedInt  = GLenum(GL_UNSIGNED_INT)
let GLFloat        = GLenum(GL_FLOAT)
let GLFixed        = GLenum(GL_FIXED)

/* Boolean */
let GLTrue  = GLboolean(GL_TRUE)
let GLFalse = GLboolean(GL_FALSE)

/* Buffer Objects */
let GLArrayBuffer               = GLenum(GL_ARRAY_BUFFER)
let GLElementArrayBuffer        = GLenum(GL_ELEMENT_ARRAY_BUFFER)
let GLArrayBufferBinding        = GLenum(GL_ARRAY_BUFFER_BINDING)
let GLElementArrayBufferBinding = GLenum(GL_ELEMENT_ARRAY_BUFFER_BINDING)

let GLStreamDraw = GLenum(GL_STREAM_DRAW)
let GLStaticDraw = GLenum(GL_STATIC_DRAW)
let GLDynmicDraw = GLenum(GL_DYNAMIC_DRAW)

/* ClearBufferMask */
let GLDepthBufferBit   = GLbitfield(GL_DEPTH_BUFFER_BIT)
let GLStencilBufferBit = GLbitfield(GL_STENCIL_BUFFER_BIT)
let GLColorBufferBit   = GLbitfield(GL_COLOR_BUFFER_BIT)

let GLVertexAttribPosition  = GLuint(GLKVertexAttrib.Position.rawValue)
let GLVertexAttribNormal    = GLuint(GLKVertexAttrib.Normal.rawValue)
let GLVertexAttribColor     = GLuint(GLKVertexAttrib.Color.rawValue)
let GLVertexAttribTexCoord0 = GLuint(GLKVertexAttrib.TexCoord0.rawValue)
let GLVertexAttribTexCoord1 = GLuint(GLKVertexAttrib.TexCoord1.rawValue)
