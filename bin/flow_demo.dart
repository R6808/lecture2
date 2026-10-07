/// flow_demo.dart — 运算符、分支与循环
///
/// 对应实践指南二第四部分（运算符与控制流）。
/// 重点演示：整除 ~/ 与除法 / 的区别、if/else 分级、for 与 for-in、while、switch。
library;

/// ① 成绩分级器（案例复现版）
String gradeOf(int score) {
  if (score >= 90) return '优';
  if (score >= 80) return '良';
  if (score >= 60) return '中';
  return '不及格';
}

/// ② 成绩分级器（自主实践扩展版）
///
/// 相比案例版增加了两类处理：
/// - 边界值：100 分与 0 分单独判定并给出提示
/// - 非法输入：小于 0 或大于 100 返回错误说明，而不是照常分级
String gradeOfExtended(int score) {
  if (score < 0 || score > 100) {
    return '输入非法（$score 不在 0~100 范围内）';
  }
  if (score == 100) return '满分（优+）';
  if (score == 0) return '零分（需补考）';
  if (score >= 90) return '优';
  if (score >= 80) return '良';
  if (score >= 70) return '中';
  if (score >= 60) return '及格';
  return '不及格';
}

/// ③ 返回更详细的分级结果（等级 + 是否通过 + 备注）
class GradeResult {
  final String level;
  final bool passed;
  final String note;

  const GradeResult(this.level, this.passed, this.note);

  @override
  String toString() => '$level（${passed ? '通过' : '未通过'}）$note';
}

GradeResult analyzeScore(int score) {
  if (score < 0 || score > 100) {
    return GradeResult('非法', false, '：分数必须在 0~100 之间，当前为 $score');
  }
  if (score == 100) {
    return const GradeResult('优+', true, '：满分，建议挑战进阶任务');
  }
  if (score == 0) {
    return const GradeResult('F', false, '：零分，需要补考');
  }
  if (score >= 90) return const GradeResult('优', true, '');
  if (score >= 80) return const GradeResult('良', true, '');
  if (score >= 70) return const GradeResult('中', true, '');
  if (score >= 60) return const GradeResult('及格', true, '');
  return const GradeResult('不及格', false, '：低于 60 分');
}

/// ④ 整除与浮点除法的区别
void demoArithmetic() {
  print('=== 1. 除法运算符的区别 ===');
  print('7 / 2  = ${7 / 2}   （结果是 double）');
  print('7 ~/ 2 = ${7 ~/ 2}  （整除，结果是 int）');
  print('7 % 2  = ${7 % 2}   （取余）');
  print('7 / 2 的运行时类型：${(7 / 2).runtimeType}');
  print('7 ~/ 2 的运行时类型：${(7 ~/ 2).runtimeType}');
}

/// ⑤ 循环：for、for-in、while、do-while
void demoLoops() {
  print('\n=== 2. 循环 ===');

  print('for 计数循环：');
  for (var i = 1; i <= 3; i++) {
    print('  第 $i 题');
  }

  print('for-in 遍历集合：');
  const subjects = ['Dart', 'Flutter', 'Git'];
  for (final s in subjects) {
    print('  科目：$s');
  }

  print('while 循环（含 continue / break）：');
  var n = 0;
  while (n < 6) {
    n++;
    if (n == 2) continue; // 跳过 2
    if (n == 5) break; // 到 5 结束
    print('  n = $n');
  }

  print('do-while 至少执行一次：');
  var k = 10;
  do {
    print('  k = $k（先执行再判断）');
    k++;
  } while (k < 10);
}

/// ⑥ switch 表达式形式（Dart 3 模式匹配，了解即可）
String gradeBySwitch(int score) => switch (score) {
  < 0 || > 100 => '非法输入',
  100 => '满分',
  >= 90 => '优',
  >= 80 => '良',
  >= 60 => '及格',
  _ => '不及格',
};

/// 供 bin/lecture2.dart 统一调用
void runFlowDemo() {
  demoArithmetic();

  print('\n=== 3. 成绩分级器（案例复现版 gradeOf）===');
  for (final score in [95, 85, 75, 65, 45]) {
    print('  $score 分 → ${gradeOf(score)}');
  }

  print('\n=== 4. 成绩分级器扩展（含边界与非法输入）===');
  for (final score in [105, -5, 100, 0, 90, 89, 60, 59]) {
    print('  $score 分 → ${analyzeScore(score)}');
  }

  print('\n=== 5. switch 表达式版本 ===');
  for (final score in [101, 100, 92, 85, 61, 30]) {
    print('  $score 分 → ${gradeBySwitch(score)}');
  }

  demoLoops();
}
