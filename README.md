# SwiftArmyKnife

收录常用的工具方法，提高生产效率。支持面向对象及函数式编程范式，故同一个功能存在多种用法，选择最适合你团队的即可。

## 使用

拷贝目录至工程即可使用。

## 目录说明

```
|-  Extensions：常规拓展
|-  Controls：常用控件
|-  FunctionalProgramming：函数式拓展
```

##  未来

由于现在是初始版本，暂不支持CocoaPods，可能以后也不支持，原因是这些常用方法如果每次都写`import SwiftArmyKnife`也是件麻烦事，拷贝进来则直接调用，省去不必要的`import SwiftArmyKnife`。

## 文档

预计会存在数量可观的方法，每个都写详细用法，工作量较大，我倾向于就一些不直观的方法写出详细用法。下面是正式使用文档。

### NSUserDefaults

#### 链式编程

```swift
NSUserDefaults.defaultsSetValue(123, forKey: "helloInt")
    .defaultsSetValue(123.0, forKey: "helloDouble")
    .defaultsSynchronize()
```

#### 函数式编程

```swift
let stdStore =
    standardUserDefaultsSetValue(true, forKey: "testCaseForStoreBool") >>>
        standardUserDefaultsSetValue("string for test", forKey: "testCaseForStoreString") >>>
            standardUserDefaultsSetValue(123, forKey: "testCaseForStoreInt")

stdStore(NSUserDefaults.standardUserDefaults()).synchronize()
```

## 参与

登陆GitHub，点击项目右上角 Fork 按钮，终端中输入git clone 你的副本地址（如https://github.com/你的用户名/SwiftArmyKnife），在本地修改后，提交到远程，我到时合并进来。

## 致谢

感谢以下几位朋友认可本项目：

* sagesse(智慧)  69236523
* 螃蟹 739869041

## 许可信息

允许使用者自由修改与拷贝，本项目维护者不负任何法律责任，也不承诺提供任何维护支持。下面这段版本信息是拷贝别人的，忽略即可。同时，因为这里标注了，文件内将不再重复，只关注功能的实现，敬请留意。

```
// Copyright (c) 2015 Michael (http://michael-lfx.github.io/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
```


