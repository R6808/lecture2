/// types_demo.dart — 变量、内置类型、字符串插值与空安全四件套
///
/// 对应实践指南二第二部分（变量与类型系统）。
/// 本文件演示三组内容：变量声明与类型推断、字符串插值、空安全四件套。
library;

/// 用于演示空断言 `!` 的持有者类。
///
/// 这里刻意把 [value] 声明为**非 final 字段**：Dart 的流分析不会对
/// 非 final 字段做类型提升（因为字段值随时可能被改），
/// 所以访问它时必须显式处理可空性，`!` 在这种位置才有真实意义。
class TokenHolder {
  String? value;
}

/// 第一组：变量声明与类型推断
void demoVariables() {
  print('=== 1. 变量声明与类型推断 ===');

  // var：由编译器推断类型，推断为 int 之后不能再赋字符串
  var count = 10;
  print('var count = $count  → 推断为 ${count.runtimeType}');

  // 显式写法与 var 等价
  int year = 2026;
  double score = 92.5;
  print('int year = $year，double score = $score');

  // final：运行时确定一次，之后不可改
  final now = DateTime.now();
  print('final now = $now（运行时确定）');

  // const：编译期常量
  const pi = 3.14159;
  print('const pi = $pi（编译期常量）');

  // var 推断为 int 后赋字符串会编译错误，这里用注释保留证据：
  // count = 'hello';
  // ↑ 编译错误：A value of type 'String' can't be assigned to a variable of type 'int'
}

/// 第二组：内置类型与字符串插值
void demoInterpolation() {
  print('\n=== 2. 内置类型与字符串插值 ===');

  String name = '容磊';
  int age = 20;
  double height = 1.75;
  bool isStudent = true;

  // 简单变量直接用 $，表达式才需要花括号
  print('你好，$name，今年 $age 岁');
  print('身高 $height 米，是学生吗？$isStudent');
  print('明年年龄 ${age + 1} 岁（表达式需要花括号）');

  // 多行字符串用三引号
  const multiLine = '''
这是三引号多行字符串，
可以跨行书写，保留换行。''';
  print(multiLine);

  // bool 没有 "truthy" 隐式转换，下面这行是编译错误：
  // if (name) { }
  // ↑ 编译错误：A value of type 'String' can't be assigned to a condition of type 'bool'
  print('提醒：Dart 的 if 条件必须是 bool，字符串不能当布尔用');
}

/// 第三组：空安全四件套（?. 、?? 、! 、late）
///
/// 参数 [input] 从外部传入，编译器**无法**推断它是否为 null，
/// 因此这里的 `?.` 与 `??` 都是真实参与运行期判断的，不会出现
/// "dead_code" 之类的告警。
void demoNullSafety(String? input) {
  print('\n=== 3. 空安全四件套 ===');

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
  print('  说明：holder.value 是非 final 字段，流分析不会提升它，');
  print('  所以这里必须用 ! 断言，或者在取值前先判空。');
}

/// 判空后的类型提升演示（对应独立研究任务 2）
///
/// 判空之后 Dart 会把变量从 `String?` 提升为 `String`，
/// 此时**不需要** `!` 也能直接调用 String 的方法。
void demoTypePromotion(String? input) {
  print('\n=== 4. 类型提升（判空后无需 ! ）===');

  String? text = input;
  print('提升前：text 的静态类型是 String?');

  if (text != null) {
    // 这个分支内 text 已被提升为 String，写 text!.length 反而会有
    // unnecessary_non_null_assertion 告警
    print('判空分支内：text.length = ${text.length}（类型提升生效）');
    return;
  }
  print('输入为 null，已走兜底分支');
}

/// 故意实验：把 ! 用在仍为 null 的地方，观察抛出的错误类型
///
/// 对应指南 2.3 的"故意实验"。
void demoNullCheckOperatorOnNull() {
  print('\n=== 5. 故意实验：! 用在 null 上 ===');

  final holder = TokenHolder(); // value 保持 null
  try {
    print(holder.value!.length);
  } catch (e) {
    print('捕获到异常类型：${e.runtimeType}');
    print('异常信息：$e');
  }
}

/// 供 bin/dart_basics.dart 统一调用
void runTypesDemo() {
  demoVariables();
  demoInterpolation();

  // 分别用 null 与非 null 各跑一遍，证明两条路径都正常
  print('\n--- 空安全：输入为 null 时 ---');
  demoNullSafety(null);
  print('\n--- 空安全：输入有值时 ---');
  demoNullSafety('hu');

  demoTypePromotion(null);
  demoTypePromotion('dart');
  demoNullCheckOperatorOnNull();
}
