### run
1.双击 ArcBlockCodingTest.xcworkspace 文件打开项目；
2.xcode 中选中 ArcBlockCodingTest，然后在target中选中ArcBlockCodingTest，并在 Signing&Capabilities中修改成你自己的team，并设置一个bundle id；
3.在xcode界面顶部选择好运行的模拟器，然后点击run按钮（看起来像播放键）就可以
运行了。或者使用快捷键 command + r 也可以运行。

### 简介
- 使用MVVM模式
- 包含四个界面：首页、ArcBlock DevCon 2020、ArcBlock ABT Node、ABT 钱包的官网
- 首页：以列表的形式展示一些说明和另外3个界面的入口
- ArcBlock DevCon 2020 & ArcBlock ABT Node：以列表的形式展示说明和截图
- ABT 钱包的官网：主体是个WKWebView，用于展示web page

#####ABT 钱包的官网（CommonWebViewController）
- 导航栏处右边有两个按钮：返回上一页、刷新；
- 返回上一页：可以返回web的上一页区别于导航栏左边的 返回 按钮；
- 刷新：web page 加载失败的时候，刷新按钮变为可用状态，用于重新加载；
