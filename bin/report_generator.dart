/// report_generator.dart — 自主实践任务 2：命名参数设计
///
/// 任务要求：为"实验报告生成器"设计函数签名，并给出三种调用。
///
/// 设计思路：
/// - 必填项用 required（学生姓名、实验名称、实验日期）—— 缺了报告就没有主体
/// - 有合理默认值的给默认值（评分标准、是否附签名）—— 大多数情况不用传
/// - 可缺省且语义上"可能没有"的用可空类型（成绩、评语）—— 允许"未评分"这种状态
/// - 布尔开关一律用命名参数 —— 调用处 `includeSignature: false` 比传位置参数 `false` 可读得多
library;

/// 实验报告数据结构
class LabReport {
  final String studentName;
  final String studentId;
  final String experimentName;
  final String date;
  final double? score;
  final String conclusion;
  final bool includeSignature;
  final String gradingStandard;

  const LabReport({
    required this.studentName,
    required this.studentId,
    required this.experimentName,
    required this.date,
    this.score,
    this.conclusion = '（待填写）',
    this.includeSignature = true,
    this.gradingStandard = '百分制',
  });

  /// 渲染为文本报告
  String render() {
    final buffer = StringBuffer();
    buffer.writeln('┌─────────────────────────────────────');
    buffer.writeln('│ 实验报告');
    buffer.writeln('├─────────────────────────────────────');
    buffer.writeln('│ 学生姓名：$studentName（$studentId）');
    buffer.writeln('│ 实验名称：$experimentName');
    buffer.writeln('│ 实验日期：$date');
    buffer.writeln('│ 评分标准：$gradingStandard');
    buffer.writeln('│ 实验成绩：${score == null ? '未评分' : '$score 分'}');
    buffer.writeln('│ 实验结论：$conclusion');
    if (includeSignature) {
      buffer.writeln('│ 学生签名：$studentName');
    }
    buffer.writeln('└─────────────────────────────────────');
    return buffer.toString();
  }
}

/// 便捷构造：用命名参数一次性生成报告文本
///
/// 这是本任务设计的核心函数签名，共 8 个命名参数：
///   3 个 required（姓名、学号、实验名称、日期）
///   4 个可选（成绩可为空、结论有默认、签名开关、评分标准）
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

/// 供 bin/dart_basics.dart 调用
void runReportGenerator() {
  print('--- 函数签名 ---');
  print('''String buildLabReport({
  required String studentName,          // 必填：报告主体
  required String studentId,            // 必填：报告主体
  required String experimentName,       // 必填：报告主体
  required String date,                 // 必填：报告主体
  double? score,                        // 可选：允许"未评分"
  String conclusion = '（待填写）',      // 可选：有默认值
  bool includeSignature = true,         // 可选：开关，默认附签名
  String gradingStandard = '百分制',     // 可选：有默认值
})''');

  print('\n--- 三种调用方式 ---');

  print('\n【调用 1】只传必填参数（最简调用）');
  print(
    buildLabReport(
      studentName: '容磊',
      studentId: '20251060108',
      experimentName: 'Dart 语言基础一',
      date: '2026-10-07',
    ),
  );

  print('【调用 2】补充成绩与结论（常见调用）');
  print(
    buildLabReport(
      studentName: '容磊',
      studentId: '20251060108',
      experimentName: 'Dart 语言基础一',
      date: '2026-10-07',
      score: 92.5,
      conclusion: '变量与空安全机制理解到位，命名参数是 Flutter 组件构造函数的核心风格。',
    ),
  );

  print('【调用 3】修改默认值：换评分标准、不附签名（定制调用）');
  print(
    buildLabReport(
      studentName: '容磊',
      studentId: '20251060108',
      experimentName: 'Dart 语言基础一',
      date: '2026-10-07',
      score: 88,
      conclusion: 'switch 表达式形式还需多练。',
      gradingStandard: '五级制（优/良/中/及格/不及格）',
      includeSignature: false,
    ),
  );

  print('--- 为什么这样设计签名 ---');
  print('  1. 必填项用 required：漏传直接编译报错，把"报告缺主体"这类问题挡在编译期；');
  print('  2. 成绩用可空 double?：真实场景就是"可能还没评分"，用可空类型让这个状态合法，');
  print('     而不是用 0 分冒充（0 分是有意义的成绩，与"未评分"语义完全不同）；');
  print('  3. 布尔开关用命名参数：调用处写 includeSignature: false 一眼能看懂，');
  print(
    '     若用位置参数则变成 buildLabReport(\'容磊\', \'20251060108\', \'实验\', \'日期\', null, \'\', false)，',
  );
  print('     那个 false 指什么完全看不出来；');
  print('  4. 有默认值的参数放最后：让最简调用只需写 4 行，常见调用只需写 6 行。');
}
