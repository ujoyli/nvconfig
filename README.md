<!--
-- File: README.md
-- Description: Documentation and user guide for the nvconfig Neovim distribution.
-- Design: Provides clear, concise, and structured keybindings, setup guides, and features.
-->

# nvconfig - 轻量级模块化 Neovim 配置

这是一个专为 macOS 和 Linux 设计的轻量级、模块化、极速启动的自定义 Neovim 配置。它摆脱了笨重的预制框架封装，仅保留最核心的 IDE 功能，尤其对 C++ 和 Lua 开发者提供了开箱即用的完美支持。

## 核心特性

- **极速启动**：所有核心插件（Treesitter、Telescope、LSP、自动补全）均配置了 `lazy-load` 延迟加载，启动零开销。
- **跨平台一键部署**：内置 `install.sh` 安装脚本，支持在 macOS（通过 Homebrew）和 Linux（自动处理各种包管理器并从 GitHub 官方发布源获取最新 Neovim 独立运行包）上极速一键配置。
- **卓越的 C++ 开发体验**：开箱即用支持 `clangd` LSP 和 C++ 的 Treesitter 语法高亮。

---

## 常用功能与快捷键指南

以下是您日常开发最常用的基础功能和对应快捷键：

### 1. 模糊匹配并打开工作区中的文件
- **操作**：在普通模式（Normal Mode）下按下：
  - **`空格键` + `f` + `f`**（即 `<leader>ff`）
- **功能**：展开当前项目目录下的所有文件列表。您可以输入文件名的一部分进行模糊匹配，使用 `Ctrl+j`/`Ctrl+k` 上下移动光标，按下 `Enter` 键即可跳转打开该文件。
- **进阶搜索**：
  - **`空格键` + `f` + `g`**（即 `<leader>fg`）：在整个项目的所有文件内容中进行文本全局搜索（Live Grep）。

### 2. 打开当前文件的函数/结构体列表（符号列表）
- **操作**：在普通模式下，当打开了一个包含函数/结构体的代码文件时，按下：
  - **`空格键` + `f` + `s`**（即 `<leader>fs`）
- **功能**：展开当前文件中所有的函数、类、结构体和变量列表。同样支持输入关键字进行模糊匹配，按下 `Enter` 键即可快速跳转到对应的函数定义处。

### 3. 查看一个函数在整个项目下的所有引用
- **操作**：在普通模式下，将光标移动到您想查询的函数（或变量/类）名字上，然后按下：
  - **`g` + `r`**（即 `gr`）
- **功能**：调用 LSP 引擎检索整个项目，并在 Telescope 窗口中列出该函数在所有文件中的引用位置。您可以通过模糊过滤定位，按下 `Enter` 键即可跳转。

### 4. 其他基础 IDE 快捷键
- **`g` + `d`**（即 `gd`）：光标移到符号上，跳转到其定义处（Goto Definition）。
- **`K`**：光标移到符号上，悬浮显示函数签名、文档或类型信息（Hover Doc）。
- **`空格键` + `r` + `n`**（即 `<leader>rn`）：对当前光标下的符号进行项目内重命名（Rename）。
- **`空格键` + `c` + `a`**（即 `<leader>ca`）：触发代码修复建议（Code Action）。
- **`Esc`**：清空搜索的高亮标记。
- **`Shift` + `h` / `Shift` + `l`**：切换上一个/下一个已打开的文件标签页（Buffer）。
- **`空格键` + `b` + `d`**：关闭当前文件标签页。

---

## 跨平台一键安装方法

在一台全新的 Mac 或 Linux 电脑上，只需在终端中运行以下命令，即可一键重置并配置好所有环境：

```bash
curl -sSL https://raw.githubusercontent.com/lidashuai/nvconfig/main/install.sh | bash
```

*(注意：如果是从克隆的本地仓库安装，可以直接在仓库目录下执行 `./install.sh`)*
