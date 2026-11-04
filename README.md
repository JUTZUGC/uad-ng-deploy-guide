# UAD-ng 一键安装指南

> 第三方部署指南 · 非 UAD-ng 官方仓库。官方项目：[Universal-Debloater-Alliance/universal-android-debloater-next-generation](https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation)
> 内容来自官方文档（2026-11-04）。项目迭代快，请以[官方文档](https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation/wiki)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己敲命令，让百度搭子帮你把安装包下载并校验好。

⚠️ 有风险：卸载系统应用可能导致功能异常甚至无法开机，请先备份并只动列表里标为安全的包。需要手机开启开发者选项与 USB 调试，用数据线连电脑操作。仅支持电脑端。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/uad-ng-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会下载对应平台的官方二进制并落到本地目录，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## UAD-ng 是什么？

UAD-ng 是开源的图形化的 Android 去臃肿工具，免 root 卸载系统预装应用（协议：GPL-3.0，<img src="https://img.shields.io/github/stars/Universal-Debloater-Alliance/universal-android-debloater-next-generation?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

通过 ADB 连接安卓手机，按社区维护的包列表批量卸载或停用预装应用，不需要 root。带图形界面、搜索、过滤与导出，另有命令行版本可脚本化。

- 免 root，走 ADB
- 近万 star，列表持续维护
- 图形界面 + CLI 两种形态
- 按厂商/安全等级筛选
- 不上传任何用户数据
- GPL-3.0

（来源：[官方仓库](https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 9728 stars | 社区维护活跃 |
| 免 root | 不用刷机 |
| 图形界面 | 可搜索和筛选 |
| 附带 CLI | 可脚本化 |
| 不上传用户数据 | — |
| 支持 Windows / macOS / Linux | — |

| 需要注意 | 说明 |
|---|---|
| 卸载系统应用有变砖风险 | — |
| 需要开 USB 调试 | — |
| 部分包卸载后无法恢复 | — |
| 依赖社区列表 | 新机型可能没收录 |
| macOS 需手动放行 | — |
| 不提供一键备份整机 | — |

> 以上基于官方文档与社区反馈整理（2026-11-04），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
curl -fL -o uad-ng https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation/releases/latest/download/uad-ng-linux
chmod +x uad-ng
./uad-ng
```

安装包来源：[https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation/wiki/Getting-started](https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation/wiki/Getting-started)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认免 root、ADB 连接与数据不上传 | 已核对 2026-11-04 |
| 确认 release 提供 GUI 与 CLI 的 Windows/macOS/Linux 产物 | 已核对 2026-11-04 |
| 未实测下载、连接手机与卸载操作 | 说明 2026-11-04 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-11-04 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-11-04 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目本身不带 MCP；本仓库的 MCP server 提供安装、连接手机与回滚的步骤说明。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-11-04）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\uad-ng-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 使用前准备

1. 手机进入「关于手机」，连点版本号开启开发者选项。
2. 在开发者选项里打开 USB 调试。
3. 数据线连接电脑，手机上点「允许调试」。
4. 打开 UAD-ng，列表出现应用即连接成功。

## 命令行版本

release 里另有 `uad-cli-*`，适合批量脚本：

```bash
./uad-cli --help
```

## 回滚

- 卸载前先导出当前包列表
- 被卸载的系统应用可尝试用 `adb install-existing <包名>` 恢复
- 恢复不了时只能刷机，务必先备份

## 注意

- 列表里标注 `Unlisted` 或 `Expert` 的包不要动
- 不要批量勾选「全部卸载」
- 部分厂商 ROM 卸载某些包会导致无法开机
- macOS 首次运行需在「隐私与安全性」里放行

## 常见坑

- 列表空白：确认 USB 调试已开且手机已授权本机
- 识别不到设备：换数据线，或在开发者选项里切换 USB 配置
- 卸载后手机异常：用 `adb install-existing` 恢复，恢复不了只能刷机
- 误删关键包：只动标为 Recommended 的条目
- macOS 打不开：在隐私与安全性里允许运行
- CLI 权限不足：`chmod +x` 后再执行
- 列表更新失败：检查能否访问 GitHub

## 免责声明

本仓库为第三方指南，与 UAD-ng 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-11-04），项目迭代快，请以[官方文档](https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation/wiki)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
