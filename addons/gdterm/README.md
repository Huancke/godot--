````
# GDTerm

GDTerm the Godot In-Editor Terminal

## 描述

此项目旨在满足在 Godot 编辑器中开发游戏的开发者的需求，同时需要执行命令行操作（如启动和停止服务器、监控日志等）。  

它还可能帮助使用[替代编程语言](https://github.com/Godot-Languages-Support/godot-lang-support)的人们，因为可以在 GDTerm 中运行 Helix、Neovim 或 Emacs。  

换句话说，这适用于喜欢将 Godot 编辑器保持全屏状态且无需切换窗口来完成命令行任务的用户。

它提供了以下功能：

* 主屏幕区域内的多个终端（与 2D/3D/脚本/资产库相同的位置）。
* 默认 shell 的伪终端接口。
* 模拟 ANSI 终端（16 种颜色）。
* 每个终端独立滚动回滚。
* 每个终端支持复制和粘贴。
* 与典型的命令行工具兼容：vi、top、tail。
* 支持 Unicode（有一定限制）。
* 支持 Linux、Windows 和 Mac。

## 开始使用

### 依赖项

* 针对 Godot 4.3-stable 开发。
* Godot 支持的 Linux、Windows 或 Mac 发行版。
* 适合从源代码编译扩展的环境。
  * 参见：https://docs.godotengine.org/en/stable/tutorials/scripting/gdextension/gdextension_cpp_example.html

### 安装

源代码位于 GitHub 上，最新稳定版本可在 GD 资产库中找到。

使用预编译二进制文件：

* `git clone http://github.com/markeel/gdterm`
* 将 `addons` 目录复制到需要此扩展的 Godot 项目中。

若从源代码编译而不是使用预编译库：

* `git clone http://github.com/markeel/gdterm`
* `cd gdterm`
* `git submodule update --init --recursive`
* `scons`
* 将 `addons` 目录复制到需要此扩展的 Godot 项目中。

### 执行程序

* 在你的 Godot 项目中。
* 从菜单栏：项目 -> 项目设置...
* 点击插件选项卡。
* 在“GDTerm”旁边的“启用”复选框中选择。

### 使用终端

选择“终端”按钮时，将提供默认的终端实例。

#### 复制和粘贴

可以使用鼠标选择文本：
* 单点击并拖动以高亮字符。
* 双点击并拖动以高亮单词。
* 三点击并拖动以高亮行。

右键上下文菜单包括复制和粘贴功能，可与系统剪贴板交互。

#### 新建和关闭

可以通过在上下文菜单所在的窗口上方、下方、左侧或右侧添加一个新终端来创建新终端。

也可以从上下文菜单关闭终端。

#### 重启

重启将清除窗口并启动新的终端会话。这是重新启动被此终端使用的 shell 已退出的终端会话的方法。

## 设置

GDTerm 插件在编辑器 -> 编辑器设置... 下提供以下设置。

设置位于 Gdterm 部分，具体如下：

- 布局：指示终端应在 Godot 编辑器中的位置。

  - main - 终端将位于主窗口（与 2D、3D、脚本和资产库相同的位置），此选项为执行如编辑配置文件或查看列表等任务提供了最大的空间。
  - bottom - 终端将位于底部面板区域（输出、调试器、音频等所在位置）。
  - both - 将有 2 个终端（一个在主区域，另一个在底部面板）。

- 主题：支持 3 种主题之一，改变所有终端窗口的颜色、前景色和背景色。

- 初始命令：启动终端窗口时将执行零个、一个或多个命令。这些命令仅在初次创建或对窗口执行“重启”时执行。

- 将 Alt/Meta 发送为 Esc：如果勾选，结合其他字符按下的 Alt 或 Meta 键将发送一个 ESC 给前台应用程序。这对于期望此行为的 Emacs 等应用程序很重要。

- 字体：如果不为空，将使用指定路径处的字体作为终端窗口的字体，应始终使用等宽字体，否则终端将无法正常工作。

- 字体大小：默认值为 14，但可以调整为任意大小。这对于配备 Retina 显示的 Mac 可能很重要。

## Unicode 和 UTF-8 编码

GDTerm 插件期望所有输入和输出均为 UTF-8。这是大多数 Linux 发行版默认设置，如果你的发行版不是，改变你的区域设置可能是最简单的选择。底层的 Windows 伪终端也使用 UTF-8，因此在 Windows 环境中无需特别操作。

尽管如此，并非所有 Windows 程序都支持 Unicode，你可能会看到奇怪的字符，因为这些程序（如“type”）不理解 Unicode 或 UTF-8。在 Windows 平台上使用 PowerShell 通常更安全。

GDTerm 插件尝试处理由多个 Unicode 代码点组成的高级 Unicode 字符，但受限于可用字体渲染这些字符的能力以及你实际运行的应用程序如何处理这些字符。

例如，bash shell 和 vi 处理组合 Unicode 字符的方式并非完全一致。如果你只有少数几个，可能会足够用。不管怎样，与 GDTerm 比较的其他终端也有类似的问题。

## 帮助

这是一个全新的扩展，如果你遇到问题，请创建一个 issue，对于一般问题，你可以使用 Discussions 标签。

## 作者

markeel

## 版本历史

* 1.0.1
	* 在 Mac OS 上使用 Cmd 键代替 Ctrl。
	* 允许在编辑器设置中覆盖字体和字体大小。

* 1.0
	* 支持 Mac OS。
	* 修复背景颜色问题。
	* 允许将 Alt 或 Meta 作为 Esc 发送给 Emacs。

* 0.99
	* 支持编辑器设置。
	* 更好地支持 Unicode。

* 0.95
	* 支持 Windows。

* 0.9
	* 初始发布。

## 许可证

此项目根据 MIT 许可证授权 - 详情见 LICENSE.md 文件。

## 致谢

### Godot

如果你已经使用 Godot 游戏引擎，就不会在这里：参见 [Godot Engine](https://godotengine.org/)

### ANSI 终端代码逻辑

ANSI 代码解释使用 libtmt 构建，但稍作扩展以支持滚动回滚。参见 [libtmt](https://github.com/deadpixi/libtmt)

### 字体

使用的字体是来自 [Google Fonts](https://fonts.google.com/specimen/Source+Code+Pro) 的 Source Code Pro，许可证如下：

版权 2010, 2012 Adobe Systems Incorporated (http://www.adobe.com/)，保留字体名称“Source”。Source 是 Adobe Systems Incorporated 在美国及/或其他国家/地区的商标。版权所有。

此字体软件根据 SIL 开放字体许可证第 1.1 版获得许可。此许可证及常见问题解答可在：https://openfontlicense.org 找到。

SIL 开放字体许可证第 1.1 版 - 2007 年 2 月 26 日

### 声音

铃声：

```
版权：Dr. Richard Boulanger 等
URL：http://www.archive.org/details/Berklee44v12
许可证：CC-BY Attribution 3.0 Unported
```xxxxxxxxxx3 1Copyright: Dr. Richard Boulanger et al2URL: http://www.archive.org/details/Berklee44v123License: CC-BY Attribution 3.0 Unported
````
