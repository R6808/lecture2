# dart_basics —— 课堂作业二 · Dart 语言基础一

> 移动应用软件开发实训　第 4 周 · Dart 语言基础一（变量、类型、函数与控制流）
> 姓名：容磊　学号：20251060108
> 仓库：`lecture2`（每次作业一个独立项目仓库）

本仓库是**课堂作业二**的完整提交物，包含案例复现（`dart_basics`）、自主实践三个任务、
三个独立研究任务，以及进度报告。

---

## 一、快速运行

### 环境要求

| 项目 | 要求 | 本机实测 |
| --- | --- | --- |
| Dart SDK | 3.0 以上（用到 switch 表达式与 private final 字段提升） | **3.13.4 (stable)** |
| 操作系统 | Windows / macOS / Linux | Windows |
| 编辑器 | 任意（VS Code + Dart 插件、TraeCode、命令行均可） | TraeCode |

### 运行步骤

```bash
# 1. 进入项目目录
cd lecture2

# 2. 拉取依赖（本项目只依赖 Dart SDK 自带的 lints，无第三方包）
dart pub get

# 3. 运行主入口（一次性跑完四组示例）
dart run bin/dart_basics.dart

# 4. 检查空安全是否有编译告警（检查点要求：零告警）
dart analyze

# 5. 代码规范检查
dart format --output=none --set-exit-if-changed bin research
```

**预期结果：** `dart analyze` 输出 `No issues found!`；
`dart run` 输出 255 行，末尾是「全部示例执行完毕，无编译告警」。

---

## 二、目录结构

```
lecture2/
├── bin/
│   ├── dart_basics.dart          统一入口：main() 按顺序调用全部示例
│   ├── types_demo.dart           示例一：变量、内置类型、字符串插值、空安全四件套
│   ├── func_demo.dart            示例二：箭头函数、位置可选参数、命名参数
│   ├── flow_demo.dart            示例三：运算符（含整除 ~/）、分支、循环
│   ├── null_safety_fix.dart      自主实践 1：空安全改写（隐患版 vs 安全版对照）
│   ├── report_generator.dart     自主实践 2：命名参数设计（实验报告生成器）
│   └── grade_classifier.dart     自主实践 3：成绩分级器扩展（边界值 + 非法输入）
├── research/
│   ├── const_final_research.dart    独立研究 1：const 与 final 差异实验
│   ├── type_promotion_research.dart 独立研究 2：类型提升规则验证
│   └── format_demo.dart             独立研究 3：dart format 规范实践
├── progress.md                   进度报告（与雨课堂提交内容一致）
├── pubspec.yaml                  包名：dart_basics
├── analysis_options.yaml         lint 规则（由 dart create 生成）
└── README.md                     本文件
```

**说明：** 按实践指南第五部分的要求，四组示例文件都放在 `bin/` 下，
且每一个 public 函数都被 `bin/dart_basics.dart` 的 `main()` 调用到，
不会出现"定义了但没跑"的情况。

---

## 三、每个文件演示什么

### 案例复现（必做）

| 文件 | 覆盖的知识点 | 关键输出 |
| --- | --- | --- |
| `types_demo.dart` | `var`/显式类型/`final`/`const` 的区别；字符串插值（`$` 与 `${}`）；空安全四件套 `?.`、`??`、`!`、`late`；类型提升；故意实验捕获异常 | `nickname?.length = null`（null 时短路）；`_TypeError: Null check operator used on a null value`（故意实验） |
| `func_demo.dart` | 常规函数与箭头函数等价；位置可选参数 `[String? title]`；命名参数 `{required ..., int age = 18}`；函数作为一等公民 | `enroll(name: '李华', className: '2班')` 三种调用形式 |
| `flow_demo.dart` | `7 / 2 = 3.5` 与 `7 ~/ 2 = 3` 的区别；`if/else if` 分级；`for`、`for-in`、`while`（含 `continue`/`break`）、`do-while`；`switch` 表达式形式 | 分级器对 95/85/75/65/45 分别给出 优/良/中/中/不及格 |

### 自主实践（必做）

| 文件 | 任务 | 做法要点 |
| --- | --- | --- |
| `null_safety_fix.dart` | 空安全改写 | 写出三个"隐患版"函数（滥用 `!`）与对应的"安全版"，**两个版本都真实运行**，用异常对照证明隐患 |
| `report_generator.dart` | 命名参数设计 | 为"实验报告生成器"设计 8 个命名参数（4 个 `required` + 1 个可空 + 3 个带默认值），给出三种调用 |
| `grade_classifier.dart` | 成绩分级器扩展 | 用 `Classification` 类返回结构化结果；处理 100/0 边界与超范围、负数等非法输入；批量统计时自动跳过非法值 |

### 独立研究（选做）

| 文件 | 研究问题 | 结论 |
| --- | --- | --- |
| `const_final_research.dart` | `const` 与 `final` 差在哪？ | 差别在"何时确定值"：`const` 编译期、`final` 运行期；用 `const` 接 `DateTime.now()` 会编译失败；`const` 相同内容复用同一实例（`identical(a, b) == true`），`final` 每次新建 |
| `type_promotion_research.dart` | 判空后能否直接当非空用？ | 局部变量、函数参数、**private final 字段**可提升；**public final 字段不可提升**（本次最意外的发现）；非 final 字段与集合元素也不可提升，需先取到局部变量 |
| `format_demo.dart` | `dart format` 改了哪些东西？ | 只改排版（缩进、空格、换行、括号位置），**不改语义**——格式化前后程序输出完全一致；本文件从 39 行变为 55 行，44 处有差异 |

---

## 四、检查点自查

| 检查点 | 要求 | 实测结果 |
| --- | --- | --- |
| `dart run` 输出正确 | 四组示例全部执行，无报错 | ✅ 退出码 0，255 行输出 |
| 空安全无编译告警 | `dart analyze` 零告警 | ✅ `No issues found!` |
| 空安全改写练习通过 | 能说明 `??` 与 `!` 的区别 | ✅ 三处改动各有运行证据与理由 |
| 代码规范 | `dart format` 无改动 | ✅ `Formatted 10 files (0 changed)` |
| Git 提交 | 按步骤提交，说明规范 | ✅ 见 `git log --oneline` |

---

## 五、遇到的问题与解决

**问题：`dart analyze` 一开始报了 13 个告警，其中 2 个是 warning。**

最初写完后跑 `dart analyze`，得到 2 个 warning 和 11 个 info。逐个查清原因后修正：

| 告警 | 位置 | 原因 | 解决 |
| --- | --- | --- | --- |
| `dead_code` | `types_demo.dart` | 声明 `String? nickname;` 后立刻写 `nickname?.length`，流分析已知它是 `null`，`.length` 永远不会执行 | 把可空值改为**函数参数**传入，编译器无法预知，`?.` 才真正参与运行期判断 |
| `unnecessary_non_null_assertion` | `types_demo.dart` | 赋值 `nickname = 'hu'` 之后写 `nickname!.length`，此时已被类型提升为非空，`!` 多余 | 改为在 `if (nickname != null)` 分支内直接使用（并把这个现象写成独立研究任务 2 的素材） |
| `dangling_library_doc_comments` ×7 | 所有文件 | 文件顶部只有 `///` 文档注释而没有 `library;` 指令 | 在每个文件的文档注释块后补 `library;` |
| `unnecessary_brace_in_string_interps` | `types_demo.dart` | `'身高 ${height} 米'` 中 `${}` 多余 | 改为 `'身高 $height 米'` |
| `unnecessary_null_comparison` ×2 | `type_promotion_research.dart` | 研究文件里为演示"判空"而先赋常量值，导致判空恒真 | 把值改为函数参数传入 |
| `unnecessary_string_interpolations` | `const_final_research.dart` | `'$label' * repeat` 中插值多余 | 改为 `label * repeat` |

**最终结果：** `dart analyze` → `No issues found!`（从 13 个问题降到 0）。

**这个过程中最有价值的发现**：那两个 warning 不是"写错了"，而是说明**我的写法绕过了 Dart 的流分析**——
一个说明我写了永远执行不到的代码，另一个说明我对已提升的变量多此一举地加了 `!`。
修正它们的过程直接促成了独立研究任务 2（类型提升规则验证）的选题。

---

## 六、AI 使用说明

按课堂作业要求（允许 AI 辅助，但须标注使用方式并验证），本次作业中的 AI 参与环节如下：

| 环节 | 说明 |
| --- | --- |
| 对拍练习出题 | AI 按指定范围（空安全、命名参数、整除）出 5 道预测输出题；答案由本人先写，再用真实运行核对，记录 2 处分歧 |
| 静态检查辅助 | 排查 `dart analyze` 告警时用 AI 助手协助解读告警文本；修正方案与代码由本人落实并用 `dart analyze` 验证 |

所有运行证据（`dart run` 输出、`dart analyze` 结果）都是在本机真实执行得到的，可复现。
## 七、许可与来源

- 本仓库代码为课程作业产出，仅供学习交流。
- 知识点依据：《学生实践指南二　Dart语言基础一》与 Dart 官方文档
  （https://dart.dev/language 、https://dart.cn/language ）。
- 项目骨架由 `dart create lecture2 --template=console` 生成，
  其中 `analysis_options.yaml` 与 `.gitignore` 为生成器默认内容，未作改动。
