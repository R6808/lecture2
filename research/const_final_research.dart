/// const_final_research.dart — 独立研究任务 1：const 与 final 差异实验
///
/// 研究问题：const 与 final 都表示"不可变"，它们的差别到底在哪？
/// 实验方法：尝试用 const 去接运行时才能确定的值，观察编译器的反应。
library;

/// 实验一：用 const 接 DateTime.now() —— 编译器直接拒绝
///
/// 下面这行如果取消注释，`dart analyze` 会报：
///   error - Const variables must be initialized with a constant value.
///   （const 变量必须用常量值初始化）
///
/// 原因：DateTime.now() 要读取系统时钟，只有在**程序运行时**才知道结果，
/// 而 const 要求值在**编译期**就能算出来并写进代码。
///
/// const nowConst = DateTime.now();   // ← 编译错误，故意保留为注释
///
/// 正确写法是用 final：
final DateTime nowFinal = DateTime.now();

/// 实验二：反过来的方向是成立的
///
/// 编译期常量**可以**赋给 final（const 是 final 的更强约束）。
final double piAsFinal = 3.14159; // 可以：常量给 final
const double piAsConst = 3.14159; // 可以：常量给 const

/// 实验三：const 的"编译期常量"特性还能用在哪些地方
///
/// 1) 集合字面量：const 列表/映射整体不可变
const List<String> keywords = ['var', 'final', 'const', 'late'];
const Map<String, int> priority = {'const': 1, 'final': 2, 'var': 3};

/// 2) 注解与默认值：命名参数的默认值必须是编译期常量
String describe({String label = 'dart', int repeat = 2}) => label * repeat;

/// 3) 类常量：static const 常用于全局配置
class Config {
  static const String appName = 'dart_basics';
  static const int maxRetry = 3;

  /// static final 可以接运行时值
  static final DateTime launchedAt = DateTime.now();
}

/// 实验四：同一份数据，const 与 final 在内存中的差别
///
/// Dart 会把 const 值做**规范化（canonicalization）**：
/// 内容相同的 const 对象在内存中是**同一个实例**，
/// 而 final 每次都创建新实例。
class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);

  @override
  String toString() => 'Point($x, $y)';
}

/// 供 bin/dart_basics.dart 调用
void runConstFinalResearch() {
  print('--- 实验一：const 接运行时值会怎样 ---');
  print('  const nowConst = DateTime.now();');
  print(
    '  → dart analyze 报错：Const variables must be initialized with a constant value.',
  );
  print('  原因：DateTime.now() 需要读系统时钟，运行时才有结果，不满足"编译期可算"。');
  print('  改用 final 即可：final now = DateTime.now();  实际值 = $nowFinal');

  print('\n--- 实验二：常量可以赋给 final ---');
  print('  final piAsFinal = $piAsFinal（常量赋给 final，合法）');
  print('  const piAsConst = $piAsConst（常量赋给 const，合法）');

  print('\n--- 实验三：const 适用的三个场景 ---');
  print('  const 集合字面量：$keywords');
  print('  常量作为默认值：describe() → ${describe()}');
  print(
    '  static const 配置：Config.appName = ${Config.appName}，maxRetry = ${Config.maxRetry}',
  );
  print('  static final 接运行时值：Config.launchedAt = ${Config.launchedAt}');

  print('\n--- 实验四：规范化（canonicalization）验证 ---');
  const a = Point(1, 2);
  const b = Point(1, 2);
  final c = Point(1, 2);
  final d = Point(1, 2);

  print('  const a = Point(1,2)，const b = Point(1,2)');
  print('  identical(a, b) = ${identical(a, b)}  ← const 相同内容复用同一实例');
  print('  final c = Point(1,2)，final d = Point(1,2)');
  print('  identical(c, d) = ${identical(c, d)}  ← final 每次都新建实例');
  print('  c == d 的值比较（未重写 == ，默认按引用）= ${c == d}');

  print('\n--- 研究结论 ---');
  print('  1. 差别的本质是"什么时候确定值"：const 在编译期，final 在运行期；');
  print('  2. 因此 const 的性能略好（常量会被内联、相同内容共用实例），');
  print('     但它有硬性限制——右边必须是编译期常量；');
  print('  3. 选择原则：能写 const 就写 const（更严格、性能更好）；');
  print('     值依赖运行时（时间、随机数、网络、用户输入）时用 final；');
  print('     值会变才用 var 或显式类型。');
  print('  4. 注意：const 对象内部也必须是常量，所以 const Point(1,2) 要求');
  print('     构造函数的字段都是 final 且构造函数本身是 const 的。');
}

void main() {
  print('===== 独立研究任务 1：const 与 final 差异实验 =====');
  runConstFinalResearch();
}
