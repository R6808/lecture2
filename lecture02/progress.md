# 课堂实践进度报告二

**移动应用软件开发实训　第 4 周 · Dart 语言基础一（变量、类型、函数与控制流）**

姓名：容磊　学号：20251060108　日期：2026 年 10 月 7 日
仓库：`lecture2`（https://github.com/R6808/lecture2）

---

## 一、任务理解

**本次作业要完成什么（用自己的话）**

这次课进入 Dart 语言基础，解决"能读懂、能写出、能解释"基础程序的问题。作业分三块：

1. **案例复现**：跟着指南把 `dart_basics` 这个基础语法合集程序从头建起来，包含三组示例——
   变量与类型（含空安全四件套）、函数（重点是把命名参数写对）、运算符与控制流（重点是 `~/` 与 `/` 的区别）。
   要求代码与指南一致、能跑通、按步骤做 Git 提交。
2. **自主实践**：三个具体任务——把一段有隐患的可空代码改写成安全版本、为"实验报告生成器"设计命名参数的函数签名、
   把成绩分级器扩展成能处理边界值与非法输入的版本；外加一组对拍练习和 AI 使用标注。
3. **独立研究（选做）**：三个小实验——`const` 与 `final` 的差异、类型提升规则、`dart format` 到底改了什么。

**验收标准是什么**

- 硬性检查点两条：`dart run` 全部输出正确；**空安全无编译告警**（`dart analyze` 零告警）。
- 代码要能口头解释，尤其是 `??` 与 `!` 的区别——这是本次课最核心的一组概念。
- Git 要按步骤分次提交，提交说明规范。
- 进度报告按模板十节填写，并存入仓库 `progress.md`。

**我理解这次作业的真正重点**

表面上是学语法，实际上是在建立两件事：一是**空安全意识**——Dart 把"可能为 null"写进类型系统，
逼着你在编译期就把 null 处理掉，而不是等运行时崩；二是**命名参数的写法**——这是 Flutter 组件构造函数的统一风格，
从第 5 课起无处不在，现在写顺了后面会省很多事。

---

## 二、环境与工具

| 项目 | 内容 |
| --- | --- |
| 操作系统 | Windows |
| Dart SDK | **3.13.4 (stable)** （`dart --version` 实测） |
| Flutter SDK | 已安装（`E:\flutter`），本次作业为纯 Dart 控制台工程，未使用 Flutter 界面部分 |
| 编辑器 | TraeCode / VS Code（含 Dart 插件） |
| 运行目标 | **命令行控制台**（`dart run`）。本次作业是纯 Dart 工程，不涉及 Web、模拟器或真机 |
| AI 工具 | TraeCode（用于对拍练习出题，详见第七节）；另使用 AI 助手协助排查 `dart analyze` 告警 |
| 项目骨架 | 由 `dart create lecture2 --template=console` 生成 |
| 依赖 | 无第三方包，只用 Dart SDK 自带的 `lints` |

**为什么用控制台工程而不是 Flutter 工程**：指南第五部分的案例就是 `dart create dart_basics` 纯 Dart 工程，
本课的重点是语言基础而不是界面，控制台工程能最快看到语法层面的输出结果。

---

## 三、过程记录

按时间线记录主要操作：

| 步骤 | 操作 | 结果 |
| --- | --- | --- |
| 1 | 阅读《学生实践指南二》与《课堂作业2要求单页》，确认检查点与提交清单 | 明确要交：案例复现 + 自主实践 + 进度报告 + 仓库地址 |
| 2 | 检查环境：`dart --version`、`flutter --version` | Dart 3.13.4 可用；Flutter 已装 |
| 3 | 执行 `dart create lecture2 --template=console` 创建工程 | 生成 `bin/`、`lib/`、`pubspec.yaml`、`analysis_options.yaml` 等骨架 |
| 4 | 改 `pubspec.yaml` 的包名为 `dart_basics`（与指南案例一致） | 包名与指南对齐 |
| 5 | 写 `bin/types_demo.dart`：变量声明、字符串插值、空安全四件套、类型提升、故意实验 | 第一组示例完成 |
| 6 | 写 `bin/func_demo.dart`：箭头函数、位置可选参数、命名参数、函数作为参数 | 第二组示例完成 |
| 7 | 写 `bin/flow_demo.dart`：整除与除法对比、分级器、四种循环、switch 表达式 | 第三组示例完成 |
| 8 | 写 `bin/dart_basics.dart` 作为统一入口，`main()` 调用前三组全部函数 | 满足"每个 public 函数都被 main 调用"的要求 |
| 9 | **第一次 `dart analyze`** | **报 13 个问题（2 warning + 11 info）**——见第六节 |
| 10 | 逐个查清告警原因并修正（改参数化、补 `library;`、去多余插值） | 告警降到 0 |
| 11 | 写自主实践三个文件：`null_safety_fix.dart`、`report_generator.dart`、`grade_classifier.dart` | 三个任务完成 |
| 12 | 写独立研究三个文件：`const_final_research.dart`、`type_promotion_research.dart`、`format_demo.dart` | 三项研究完成 |
| 13 | 做对拍练习 `ai_quiz_round1.dart`：出 5 道预测输出题、手写答案、运行核对 | 记录 2 处分歧 |
| 14 | `dart format bin research` 规范化 | 格式化后输出与格式化前完全一致 |
| 15 | 最终验证：`dart analyze` → `No issues found!`；`dart run` → 255 行输出、退出码 0 | **两个检查点全部达成** |
| 16 | 写 README 与 progress.md，分步 Git 提交并推送 | 待推送 |

---

## 四、关键代码

按要求贴 1~3 段关键代码并逐行解释。**以下三段均为本人按指南手写，未使用 AI 生成**；
验证方式都是实际运行 + `dart analyze` 静态检查。

### 代码段 1：空安全四件套（`bin/types_demo.dart`）

```dart
void demoNullSafety(String? input) {
  String? nickname = input;

  // ① 安全调用 ?. —— 为 null 则短路返回 null，不抛错
  print('nickname?.length = ${nickname?.length}（null 时短路返回 null）');

  // ② 默认值 ?? —— 为 null 时取右侧
  print("nickname ?? '未填写' = ${nickname ?? '未填写'}");

  // ③ ??= ：仅当为 null 时赋值
  String? motto;
  motto ??= '每天进步一点';
  print('motto ??= 之后 = $motto');

  // ④ late：承诺使用前必赋值，把检查从编译期推迟到运行时
  late String token;
  token = 'tk_2026_dart';
  print('late token（使用前赋值）= $token');

  // ⑤ 空断言 ! 的合理位置：非 final 字段无法被类型提升
  final holder = TokenHolder()..value = 'dart-basics';
  print('holder.value! 的长度 = ${holder.value!.length}');
}
```

**逐行解释：**

- `void demoNullSafety(String? input)`：参数声明为 `String?`（可空类型）。**这里有个关键设计**——
  值从参数传入而不是在函数内声明，因为若写成 `String? nickname;` 后立刻使用，Dart 的流分析已知它必然是 null，
  `nickname?.length` 的 `.length` 部分会被判为 `dead_code` 告警（这是我实际踩过的坑，见第六节）。
- `nickname?.length`：`?.` 是**安全调用**。`nickname` 为 null 时整个表达式短路返回 null，不会抛异常。
  实测输出 `null`。
- `nickname ?? '未填写'`：`??` 是**空默认值**运算符，左边为 null 时取右边。实测输出 `未填写`。
- `motto ??= '每天进步一点'`：`??=` 是"仅当为 null 时赋值"。`motto` 此时是 null，所以被赋值成功。
- `late String token;` 之后才赋值：`late` 用于**延迟初始化**，向编译器承诺"使用前一定赋值"。
  这把检查从编译期推迟到运行期——好处是可以用在 `final` 字段依赖构造函数参数等场景，
  代价是若真的没赋值就读取，会抛 `LateInitializationError`。
- `holder.value!`：`!` 是**空断言**。这里用它的原因是 `TokenHolder.value` 是**非 final 字段**，
  Dart 的流分析不会对它做类型提升，所以只能显式断言。

**验证方式：** 用 `null` 与 `'hu'` 两种实参各跑一遍，证明两条分支都正常；
另外写了 `demoNullCheckOperatorOnNull()` 做"故意实验"，实际捕获到
`_TypeError: Null check operator used on a null value`，确认 `!` 在 null 上的运行期行为。

### 代码段 2：命名参数设计（`bin/report_generator.dart`）

```dart
String buildLabReport({
  required String studentName,
  required String studentId,
  required String experimentName,
  required String date,
  double? score,
  String conclusion = '（待填写）',
  bool includeSignature = true,
  String gradingStandard = '百分制',
}) {
  final report = LabReport(
    studentName: studentName,
    studentId: studentId,
    experimentName: experimentName,
    date: date,
    score: score,
    conclusion: conclusion,
    includeSignature: includeSignature,
    gradingStandard: gradingStandard,
  );
  return report.render();
}
```

**逐行解释：**

- `{ ... }` 花括号表示**命名参数**：调用时必须写参数名（`studentName: '容磊'`），
  这与位置参数不同——命名参数可以任意顺序书写，实测验证过（第三题第 3 小问）。
- `required` 标记**必填**：漏传会在**编译期**报错。这是"实验报告缺主体"这类问题最好的防线。
- `double? score`：**可空类型**。这里刻意用可空而不是给默认值 0，
  因为"未评分"与"0 分"语义完全不同——用 0 冒充未评分会污染平均分统计。
- `String conclusion = '（待填写）'`：**带默认值的可选参数**。绝大多数情况不用传。
- `bool includeSignature = true`：布尔开关用命名参数，调用处写 `includeSignature: false` 一眼能懂；
  若用位置参数则变成一串 `(…, null, '', false)`，那个 `false` 指什么完全看不出来。
- 三个带默认值的参数放在最后：让最简调用只需 4 行。

**验证方式：** 给出三种调用（只传必填 / 补充成绩与结论 / 修改默认值）并实际运行，
三种输出都符合预期；`dart analyze` 对漏传必填参数的写法会直接报编译错误，也验证过。

### 代码段 3：空安全改写前后对照（`bin/null_safety_fix.dart`）

```dart
// 【改写前 · 隐患版】用 ! 强行断言非空
String unsafeGreeting(String? nickname) {
  return '你好，${nickname!.toUpperCase()}';   // 传 null 时运行期抛错
}

// 【改写后 · 安全版】用 ?? 提供默认值
String safeGreeting(String? nickname) {
  final name = nickname ?? '同学';              // null 时用默认值兜底
  return '你好，${name.toUpperCase()}';
}
```

**逐行解释与改写理由：**

- 隐患版的 `nickname!` 只是"向编译器保证非空"，**并没有真正处理 null**。
  编译器被说服了，但运行期一旦真传进 null，就会抛
  `_TypeError: Null check operator used on a null value`。
  实测：传 null 进隐患版确实抛出该异常。
- 安全版的 `nickname ?? '同学'` 是**真正把 null 处理掉**——给出一个有意义的默认值。
  实测：传 null 输出"你好，同学"，传 `'hu'` 输出"你好，HU"。
- **`!` 与 `??` 的区别（这是本次课最核心的一句）：**
  `!` 是**断言**——"我保证它不是 null"，保证错了就运行期崩；
  `??` 是**兜底**——"它是 null 就用这个值"，无论输入什么都安全。
  所以 `!` 只应该用在"逻辑上不可能为 null 但编译器无法推断"的位置，
  凡是**可能**为 null 的地方都应该用 `??`、`?.` 或显式判空。

本次共改写三处，另两处是：`text!.length` → 先 `if (text == null) return 0;` 再用 `text.length`
（判空后 Dart 会把 `text` 提升为 `String`，无需 `!`）；
可空分数直接拼进字符串 → 先判 null 返回明确文案再交给纯函数处理。

**验证方式：** 隐患版与安全版**都真实运行**，隐患版用 `try...catch` 包住以捕获异常并打印异常类型，
用"一个崩、一个不崩"的对照来证明改写确实解决了问题。

---

## 五、检查点结果

### 检查点 1：`dart run` 全部输出正确 ✅

**命令：** `dart run bin/dart_basics.dart`
**结果：** 退出码 **0**，输出 **255 行**，末尾为「全部示例执行完毕，无编译告警」。

四组示例全部执行到位：

| 组别 | 文件 | 覆盖内容 | 是否有输出 |
| --- | --- | --- | --- |
| 第一组 | `bin/types_demo.dart` | 变量与类型推断、字符串插值、空安全四件套、类型提升、故意实验 | ✅ |
| 第二组 | `bin/func_demo.dart` | 箭头函数、位置可选参数、命名参数三种调用、函数作为参数 | ✅ |
| 第三组 | `bin/flow_demo.dart` | 整除与除法对比、分级器、四种循环、switch 表达式 | ✅ |
| 第四组 | `bin/` 下三个 practice 文件 | 空安全改写、命名参数设计、成绩分级器扩展 | ✅ |

**关键输出摘录：**

```
=== 1. 变量声明与类型推断 ===
var count = 10  → 推断为 int
final now = 2026-10-07 15:52:27.298948（运行时确定）
const pi = 3.14159（编译期常量）

=== 3. 空安全四件套 ===
nickname?.length = null（null 时短路返回 null）
nickname ?? '未填写' = 未填写
late token（使用前赋值）= tk_2026_dart

=== 5. 故意实验：! 用在 null 上 ===
捕获到异常类型：_TypeError
异常信息：Null check operator used on a null value

=== 1. 除法运算符的区别 ===
7 / 2  = 3.5   （结果是 double）
7 ~/ 2 = 3  （整除，结果是 int）
```

**关于"每个 public 函数都被调用"**：指南提醒"新增文件中的 public 函数记得被 main 调用，
否则'定义了但没跑'不满足复现要求"。我按这个要求写了 `bin/dart_basics.dart` 作为统一入口，
`main()` 里依次调用三个 demo 文件的 `runXxxDemo()` 与三个 practice 文件的 `runXxx()`，
所以 255 行输出里能看到全部示例的结果，没有"定义了但没跑"的情况。

### 检查点 2：空安全无编译告警 ✅

**命令：** `dart analyze`
**结果：** `No issues found!`（退出码 0）——**零告警**。

这个检查点不是一次就过的。第一次运行时报了 **13 个问题**（2 warning + 11 info），
逐个查清原因并修正后降到 0。完整过程见第六节。

**附带达成的一项：** `dart format --output=none --set-exit-if-changed bin research`
→ `Formatted 11 files (0 changed)`，说明全部代码符合 Dart 官方格式规范。

---

## 六、问题与调试

### 问题：`dart analyze` 报了 13 个告警，其中 2 个是 warning

**现象：** 代码写完后自认为没问题，`dart run` 也确实能跑出正确输出；
但跑 `dart analyze` 得到 13 个问题：

```
warning - bin\types_demo.dart:62:39 - Dead code. ... - dead_code
warning - bin\types_demo.dart:70:43 - The '!' will have no effect because the receiver
                                       can't be null. ... - unnecessary_non_null_assertion
   info - bin\*.dart:1:1 - Dangling library doc comment. ... - dangling_library_doc_comments  （7 处）
   info - bin\types_demo.dart:42:13 - Unnecessary braces in a string interpolation. ...
```

**定位过程：**

1. **先读告警原文，不猜。** 前两条 warning 的文本很具体，直接说明了原因。
2. **定位到具体行**，发现 `dead_code` 出现在我写空安全演示的那几行：
   ```dart
   String? nickname;                          // 声明，未赋值 → 必然是 null
   print('${nickname?.length}');              // ← 流分析已知它是 null，.length 永远不执行
   nickname = 'hu';
   print('${nickname!.length}');              // ← 此时已被提升为非空，! 多余
   ```
   **根因**：我为了让演示代码"看起来完整"，在同一段里先声明后使用，
   结果 Dart 的**流分析（flow analysis）**把这些都算清楚了——
   它知道第一处必然是 null、第二处必然非 null，所以判定"代码有冗余"。
3. **`dangling_library_doc_comments` 的 7 处**：查证后明白，文件顶部的 `///` 文档注释
   在没有 `library;` 指令时是"悬空"的——Dart 不知道该注释属于什么。补上 `library;` 即可。
4. **`unnecessary_brace_in_string_interps`**：`'身高 ${height} 米'` 里 `height` 是简单变量，
   用 `${}` 多余，应写 `$height`。

**解决方案：**

| 告警 | 解决方式 |
| --- | --- |
| `dead_code` + `unnecessary_non_null_assertion` | **把可空值改为函数参数传入**（`void demoNullSafety(String? input)`），编译器无法预知实参，`?.` 与 `!` 才真实参与运行期判断；判空后的使用改为在 `if (x != null)` 分支内直接调用 |
| `dangling_library_doc_comments` ×7 | 在每个文件的文档注释块后补 `library;` 指令 |
| `unnecessary_brace_in_string_interps` | `'${height}'` → `'$height'` |

**修正过程中又出现同类问题（第二轮）：**

我在写独立研究任务 2（类型提升验证）与对拍练习时，**又踩了同一个坑三次**：

- 研究文件里为了让"判空"可演示，先赋常量再判空 → `unnecessary_null_comparison`（判空恒真）；
- 对拍题里声明 `String? a;` 后立刻 `a?.length` → 又是 `dead_code`；
- 对拍题第 5 题连着写两次 `v ??= ...` → 第一次之后编译器已知 `v` 非空，第二次成了 `dead_code`。

解决办法都是同一个思路：**让值来自编译器无法追踪的地方**——函数参数，或 Map 元素
（Map 元素无法被类型提升，见研究任务 2）。

**结果：** `dart analyze` → `No issues found!`，从 13 个问题降到 0。

**这个问题的价值超过它本身：**

那两个 warning 不是"我写错了语法"，而是**说明我的写法绕过了 Dart 的流分析**——
一个说明我写了永远执行不到的代码，另一个说明我对一个已被提升的变量多此一举地加了 `!`。
查清它们的过程让我真正理解了"类型提升"和"final 变量才能提升"这些规则。
这直接促成了我把**独立研究任务 2（类型提升规则验证）**作为选题，
而研究结果里那个"public final 字段竟然不能提升"的发现，也是从这次调试延伸出来的。

---

## 七、AI 使用记录

### 对拍练习（第一轮）

**用途**：按指南要求做"AI 出题、本人作答、复核记录"的对拍练习。
**指令摘要**：请按本次课知识点出 5 道"预测输出"题，范围限定为**空安全、命名参数、整除**，
每题给出代码片段，不给答案。

**出题清单与我方作答：**

| 题号 | 考点 | 我手写的预测答案 | 实测结果 | 是否一致 |
| --- | --- | --- | --- | --- |
| 1(1) | `a?.length`（a 为 null） | `null` | `null` | ✅ |
| 1(2) | `b?.length`（b='dart'） | `4` | `4` | ✅ |
| 1(3) | `a?.length ?? -1` | `-1` | `-1` | ✅ |
| 1(4) | `b?.length ?? -1` | `4` | `4` | ✅ |
| 1(5) | `a ?? b ?? 'fallback'` | `dart` | `dart` | ✅ |
| 2(1) | `x!.length`（x='ok'） | `2`，不抛错 | `2` | ✅ |
| 2(2) | `y!.length`（y 为 null） | 抛 `_TypeError` | `_TypeError: Null check operator used on a null value` | ✅ |
| 2(3) | `y?.length ?? 0` | `0` | `0` | ✅ |
| 3(1) | 只传 `name` | `A / 18 / 未分班` | 同预测 | ✅ |
| 3(2) | 传 `name` + `age` | `B / 20 / 未分班` | 同预测 | ✅ |
| 3(3) | 传全部（顺序打乱） | `C / 19 / 2班` | 同预测 | ✅ |
| 4(1) | `7 / 2` | `3.5`，类型 `double` | `3.5` / `double` | ✅ |
| 4(2) | `7 ~/ 2` | `3`，类型 `int` | `3` / `int` | ✅ |
| 4(3) | `-7 ~/ 2` | **不确定**：-3 还是 -4，倾向 -4 | **`-3`** | ❌ **分歧** |
| 4(4) | `7 % 2` | `1` | `1` | ✅ |
| 4(5) | `7.0 ~/ 2` | **不确定**：double 能否用 `~/`，倾向编译失败 | **可以，`3`，类型 `int`** | ❌ **分歧** |
| 5(1) | 初始值 | `null` | `null` | ✅ |
| 5(2)-(3) | 连续两次 `??=` | 第二次不生效，仍是 `first` | 同预测 | ✅ |
| 5(4) | `late` 赋值后读取 | `tk` | `tk` | ✅ |

**分歧复核（2 处）：**

1. **`-7 ~/ 2`**：我倾向认为 Dart 会向下取整得到 `-4`，实测是 **`-3`**。
   结论：Dart 的 `~/` 是**向零截断**（truncating division），与 C 语言整数除法一致，
   而不是 Python 的向下取整（Python 里 `-7 // 2` 得 `-4`）。这个差异对跨语言迁移的人很容易踩。
2. **`7.0 ~/ 2`**：我以为 `~/` 是整数专用运算符，double 上用会编译失败，实测**可以用**，
   输出 `3` 且结果类型是 `int`。结论：`~/` 对 `num` 族（`int` 与 `double`）都适用，返回值总是 `int`。

**本人的验证方式（这一点最关键）：**

我**没有依赖 AI 给出的参考答案**，而是把 5 道题写成一个真实的 Dart 程序
（`research/ai_quiz_round1.dart`），用 `dart run` 跑出实际结果来核对预测。
理由很直接：**"预测输出题"的唯一权威是运行结果**——AI 的答案也可能记错，
但编译器不会。两处分歧正是靠真实运行才纠正过来的；如果只看参考答案，
我很可能就把 `-7 ~/ 2` 当成 `-4` 记进脑子了。

**AI 使用的其他环节与边界：**

| 环节 | 是否用 AI | 说明 |
| --- | --- | --- |
| 案例复现三个示例文件 | 否 | 按指南手写 |
| 自主实践三个任务 | 否 | 手写，用真实运行验证 |
| 独立研究三项 | 否 | 手工编程 + 官方文档检索，结论来自实际运行 |
| 对拍练习出题 | **是** | AI 按指定范围出题；**答案由我先写**，再用真实运行核对 |
| 排查 `dart analyze` 告警 | **部分** | 用 AI 助手协助解读告警文本与查证规则含义；修正方案与代码由我自己落实并验证 |
| 代码格式化 / 静态检查 | 工具 | `dart format`、`dart analyze`（Dart SDK 自带，非 AI） |

**红线自查：** 没有直接提交未经验证的 AI 生成代码；没有抄袭他人仓库；
所有运行证据（`dart run` 输出、`dart analyze` 结果）都是在本机真实执行得到的，可复现。

---

## 八、证据截图

> 截图说明：以下截图均为全屏截图，文件名对应仓库中的图片文件。
> 若雨课堂答题区无法直接粘贴图片，将在此处手工重新上传。

**图 1：`dart run bin/dart_basics.dart` 的完整输出（前 60 行）**
——展示第一组示例：变量声明与类型推断（`var count = 10` 推断为 `int`、`final now` 运行时确定、
`const pi` 编译期常量）、字符串插值、空安全四件套的 null 与非 null 两条路径。
【此处插入图片：images/01-dart-run-输出前段.png】

**图 2：`dart run` 输出的空安全与故意实验部分**
——展示 `nickname?.length = null`（短路）、`nickname ?? '未填写' = 未填写`（兜底）、
以及故意实验中捕获到的 `_TypeError: Null check operator used on a null value`。
【此处插入图片：images/02-dart-run-空安全与故意实验.png】

**图 3：自主实践三任务的输出**
——空安全改写"隐患版抛异常 / 安全版正常"的对照、命名参数三种调用生成的实验报告、
成绩分级器对 100/0/-1/101 等边界与非法输入的判定结果。
【此处插入图片：images/03-自主实践输出.png】

**图 4：`dart analyze` 输出 `No issues found!`**
——检查点 2 的直接证据：空安全无编译告警。
【此处插入图片：images/04-检查点-dart-analyze-无告警.png】

**图 5：`dart --version` 与 `dart format` 结果**
——环境证据：Dart SDK 3.13.4；`Formatted 11 files (0 changed)` 说明代码符合官方格式规范。
【此处插入图片：images/05-环境与格式化.png】

**图 6：独立研究任务 2（类型提升）的运行输出**
——展示局部变量、函数参数、private final 字段可提升，而 public final 字段不可提升的实验结果。
【此处插入图片：images/06-独立研究-类型提升验证.png】

**图 7：Git 提交记录（`git log --oneline`）**
——按"创建工程 → 三组示例 → 自主实践 → 独立研究 → 文档"分步提交，提交说明规范。
【此处插入图片：images/07-Git提交记录.png】

---

## 九、自评

对照本次作业要求逐项自查：

### 案例复现

| 要求 | 完成情况 | 说明 |
| --- | --- | --- |
| 代码与实践指南一致 | ☑ 完成 | 三组示例（types/func/flow）与指南第五部分要求对应；四组示例文件均在 `bin/` 下 |
| 可运行 | ☑ 完成 | `dart run` 退出码 0，255 行输出 |
| 按步骤 Git 提交 | ☑ 完成 | 见第八节图 7 |
| 检查点：`dart run` 输出正确 | ☑ 完成 | 四组示例全部执行到位，无"定义了但没跑" |
| 检查点：空安全无编译告警 | ☑ 完成 | `dart analyze` → `No issues found!`（从 13 个问题修正到 0） |

### 自主实践基本要求

| 序号 | 任务 | 完成情况 | 说明 |
| --- | --- | --- | --- |
| 1 | 空安全改写：改安全版本并解释 | ☑ 完成 | 三处改写，隐患版与安全版都真实运行，附逐处理由 |
| 2 | 命名参数设计：为功能函数设计签名 | ☑ 完成 | 为"实验报告生成器"设计 8 个命名参数，给出三种调用 |
| 3 | 控制流小程序：成绩分级器 | ☑ 完成 | 扩展版处理 100/0 边界与超范围、负数等非法输入；含批量统计 |
| 4 | TraeCode 对拍一组 | ☑ 完成 | 5 道预测输出题，记录 2 处分歧并用真实运行纠正 |
| 5 | AI 使用标注 | ☑ 完成 | 见第七节完整清单，逐环节标注是否使用 AI |

### 独立研究任务（选做）

| 序号 | 任务 | 完成情况 | 核心结论 |
| --- | --- | --- | --- |
| 1 | `const` 与 `final` 差异实验 | ☑ 完成 | 差别在"何时确定值"；`const` 接 `DateTime.now()` 编译失败；`const` 相同内容复用同一实例（`identical` 验证） |
| 2 | 类型提升规则验证 | ☑ 完成 | 局部变量 / 函数参数 / **private final 字段**可提升；**public final 字段不可提升**（最意外的发现）；非 final 字段与集合元素不可提升 |
| 3 | `dart format` 规范实践 | ☑ 完成 | 只改排版不改语义——格式化前后输出完全一致；同一文件从 39 行变 55 行，44 处差异 |

### 提交清单

| 项目 | 状态 |
| --- | --- |
| 进度报告（本文，十节） | ☑ 完成 |
| 仓库地址（3 次以上提交） | ☑ 完成（`lecture2`，分步提交） |
| `dart run` 输出截图 | ☑ 完成（第八节图 1~3） |
| 对拍记录 | ☑ 完成（第七节，含 2 处分歧复核） |
| 同一内容存入 `lecture2/progress.md` | ☑ 完成 |

### 自评结论

**做得比较好的**：两个检查点都达成，而且 `dart analyze` 是**从 13 个问题修正到 0** 而不是一开始就干净——
修正过程反而让我搞懂了流分析与类型提升，还把踩坑经历转化成了独立研究的选题。
对拍练习也坚持用真实运行核对而非照抄参考答案，纠正了 2 处预测偏差。

**还需要加强的**：独立研究任务 2 里"public final 字段不可提升"这个结论，
我只验证了现象，还没查证官方文档中"为什么"这样设计（推测与库外代码可能覆写 getter 有关，
但没找到明确出处）。这属于"知道是什么、不清楚为什么"，下次课要补上文档依据。

---

## 十、一句话收获与下一步计划

### 本课一句话收获

**`!` 是"我保证它不为 null"（保证错了运行期就崩），`??` 是"它若为 null 就用这个值"（无论输入什么都安全）**——
空安全的正确姿势是**处理 null 而不是断言 null**；而 `dart analyze` 里那些看起来"多此一举"的告警，
恰恰是编译器在提醒我：我写的代码绕过了它的流分析。

### 遗留问题

1. **类型提升的设计原因没查清**：已确认 public final 字段不可提升，但没找到官方文档里"为什么"的说明，
   只有编译器的报错提示（"refers to a public property so it couldn't be promoted"）。
2. **`late` 的适用场景只见过简单例子**：指南提到它常用于"final 字段依赖构造函数参数"，
   我还没在真实类里用过这种写法。
3. **`switch` 表达式形式只是"了解"**：`flow_demo.dart` 里写了但没深究模式匹配的其他用法。
4. **对拍练习只做了第一轮**：指南说"第一轮"，我还没做第二轮针对薄弱点的题目
   （尤其是 `~/` 的负数行为这类跨语言差异）。

### 下次课的预习要点

1. **集合（List / Map / Set）**：指南第 2.2 节提到集合在第 3 课展开，提前看 `dart.dev/language` 的 Collections 章节。
2. **函数的进阶用法**：回调与高阶函数——第 3 课的函数是一等公民会与集合方法（`map`/`where`/`reduce`）结合使用。
3. **查证类型提升的官方依据**：去 `dart.dev` 搜 field promotion 相关文档，把遗留问题 1 补上。
4. **把 `late` 用起来**：在写类的时候刻意用一次 `late final` 字段，体会它解决的问题。
5. **补做对拍第二轮**：专门针对"跨语言行为差异"出题（整除负数、类型转换、判等语义），
   把 Python / JavaScript 与 Dart 的不同点列成一张对照表。
