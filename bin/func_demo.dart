/// func_demo.dart — 函数声明、箭头函数、可选参数与命名参数
///
/// 对应实践指南二第三部分（函数）。
/// 重点演示 Flutter 组件构造函数统一使用的命名参数风格。
library;

/// ① 常规函数声明
int add(int a, int b) {
  return a + b;
}

/// ① 箭头函数：单表达式简写，等价于上面的 add
int add2(int a, int b) => a + b;

/// ② 位置可选参数：用方括号，调用时可省略
String greet(String name, [String? title]) {
  if (title == null) {
    return '你好，$name';
  }
  return '你好，$title$name';
}

/// ③ 命名参数：用花括号，required 标记必填，其余可给默认值
///
/// 这是 Flutter 组件构造函数的统一风格（第 5 课起无处不在）。
void enroll({required String name, int age = 18, String? className}) {
  final classInfo = className ?? '未分班';
  print('报名成功：$name，$age 岁，班级：$classInfo');
}

/// ④ 函数是一等公民：可以赋给变量、作为参数传递
int Function(int, int) pickOperation(bool useAdd) =>
    useAdd ? add : (a, b) => a - b;

/// 把函数作为参数传入
int applyTwice(int Function(int, int) op, int x, int y) => op(op(x, y), y);

/// ⑤ 演示命名参数的实际用法：实验报告生成器（自主实践任务 2 的函数签名）
///
/// 设计要点：
/// - 必填项用 required（学生姓名、实验名称）
/// - 可选项给合理默认值（日期默认今天由调用方传入，成绩默认未评分）
/// - 布尔开关用命名参数，调用处可读性远高于位置参数
String buildReport({
  required String studentName,
  required String experimentName,
  required String date,
  double? score,
  String conclusion = '（待填写）',
  bool includeSignature = true,
}) {
  final buffer = StringBuffer();
  buffer.writeln('实验报告');
  buffer.writeln('学生：$studentName');
  buffer.writeln('实验：$experimentName');
  buffer.writeln('日期：$date');
  buffer.writeln('成绩：${score == null ? '未评分' : '$score 分'}');
  buffer.writeln('结论：$conclusion');
  if (includeSignature) {
    buffer.writeln('签名：$studentName');
  }
  return buffer.toString();
}

/// 供 bin/lecture2.dart 统一调用
void runFuncDemo() {
  print('=== 1. 箭头函数与常规函数 ===');
  print('add(3, 4) = ${add(3, 4)}');
  print('add2(3, 4) = ${add2(3, 4)}（箭头函数，与 add 等价）');

  print('\n=== 2. 位置可选参数 ===');
  print(greet('李华'));
  print(greet('李华', '博士'));

  print('\n=== 3. 命名参数（Flutter 风格）===');
  enroll(name: '李华');
  enroll(name: '李华', className: '2班');
  enroll(name: '李华', age: 21, className: '2班');

  print('\n=== 4. 函数作为参数传递 ===');
  final op = pickOperation(true);
  print('pickOperation(true)(10, 3) = ${op(10, 3)}');
  print('applyTwice(add2, 2, 3) = ${applyTwice(add2, 2, 3)}');

  print('\n=== 5. 命名参数实战：实验报告生成器 ===');
  print(
    buildReport(
      studentName: '容磊',
      experimentName: 'Dart 语言基础一',
      date: '2026-10-07',
      score: 92.5,
    ),
  );
}
