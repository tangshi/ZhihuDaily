# 知乎日报

拿知乎日报项目练练手，学习Swift(2.0)。

知乎日报API来源于[这里](https://github.com/izzyleung/ZhihuDailyPurify/wiki/知乎日报-API-分析)

从`iOS9.0`和`OS X 10.11`开始，苹果引入了`App Transport Security(ATS)`技术，增加了网络传输的安全性，苹果官方说明文档在[这里](https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/index.html)

练手的项目关心啥安全啊，我选择直接关闭`ATS`！方法参考自[这里](http://blog.csdn.net/keyzhang_blog/article/details/46910797)。

在`Info.plist`文件中添加如下项关闭`ATS`：



    <key>NSAppTransportSecurity</key>
    <dict>
        <!--Include to allow all connections (DANGER)-->
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>



若要使用`ATS`，添加如下项：


    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSExceptionDomains</key>
        <dict>
            <key>news-at.zhihu.com</key>
            <dict>
                <!--Include to allow subdomains-->
                <key>NSIncludesSubdomains</key>
                <true/>
                <!--Include to allow HTTP requests-->
                <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
                <true/>
                <!--Include to specify minimum TLS version-->
                <key>NSTemporaryExceptionMinimumTLSVersion</key>
                <string>TLSv1.1</string>
            </dict>
        </dict>
    </dict>



说明：`NSExceptionDomains`字典列举出所有使用到的服务器域名，上例只列举了一个，即知乎日报的API服务器域名`news-at.zhihu.com`。


网络库使用[Alamofire(swift-2.0)](https://github.com/Alamofire/Alamofire/tree/swift-2.0)

发送网络请求，获得JSON格式的响应数据：


    let url_string = "http://news-at.zhihu.com/api/4/news/latest"
    Alamofire.request(.GET, url_string).responseJSON { (_, _, result, _) -> Void in
        if let obj = result.value {
            let dict = obj as! NSDictionary
            // do something ... 
        }   
    }


从网络下载图片：


    let image_url_string = "http://pic3.zhimg.com/9d22a64c7b3d365025d9d3498501bdca.jpg"
    Alamofire.request(.GET, image_url_string).response(completionHandler: { (_, _, data, _) -> Void in 
        if let imagedata = data {
            let image = UIImage(data: imagedata)
            // do something ...
        }
    })


