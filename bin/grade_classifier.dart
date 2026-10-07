/// grade_classifier.dart — 自主实践任务 3：成绩分级器扩展
///
/// 任务要求：在案例的 gradeOf 基础上扩展，处理边界值（100 / 0）与非法输入。
///
/// 相比 lib/flow_demo.dart 里的案例版，本文件把重点放在"输入校验"与
/// "结果结构化"两件事上：案例版假设输入一定是 0~100 的合法整数，
/// 而真实使用中必须处理超范围、非整数、空值等情况。
library;

/// 分级结果的完整信息
class Classification {
  /// 等级：优+ / 优 / 良 / 中 / 及格 / 不及格 / 非法
  final String level;

  /// 是否有效输入
  final bool valid;

  /// 是否通过（有效且 >= 60）
  final bool passed;

  /// 补充说明（边界提示或错误原因）
  final String note;

  const Classification({
    required this.level,
    required this.valid,
    required this.passed,
    this.note = '',
  });

  @override
  String toString() {
    if (!valid) {
      return '无效输入 —— $note';
    }
    final passText = passed ? '通过' : '未通过';
    final noteText = note.isEmpty ? '' : '　$note';
    return '$level（$passText）$noteText';
  }
}

/// 扩展版分级器：处理边界值与非法输入
Classification classify(int score) {
  // ---- 非法输入 ----
  if (score < 0) {
    return Classification(
      level: '非法',
      valid: false,
      passed: false,
      note: '分数不能为负数，收到 $score',
    );
  }
  if (score > 100) {
    return Classification(
      level: '非法',
      valid: false,
      passed: false,
      note: '分数不能超过 100，收到 $score',
    );
  }

  // ---- 边界值：100 与 0 单独处理，给出额外提示 ----
  if (score == 100) {
    return const Classification(
      level: '优+',
      valid: true,
      passed: true,
      note: '满分，建议挑战进阶任务',
    );
  }
  if (score == 0) {
    return const Classification(
      level: '不及格',
      valid: true,
      passed: false,
      note: '零分，需要补考',
    );
  }

  // ---- 常规分档（含 59/60 与 89/90 两处临界）----
  if (score >= 90) {
    return const Classification(level: '优', valid: true, passed: true);
  }
  if (score >= 80) {
    return const Classification(level: '良', valid: true, passed: true);
  }
  if (score >= 70) {
    return const Classification(level: '中', valid: true, passed: true);
  }
  if (score >= 60) {
    return const Classification(level: '及格', valid: true, passed: true);
  }
  return const Classification(level: '不及格', valid: true, passed: false);
}

/// 批量统计：一次处理一组分数，返回各等级人数
Map<String, int> tallyByLevel(List<int> scores) {
  final result = <String, int>{};
  for (final score in scores) {
    final c = classify(score);
    result[c.level] = (result[c.level] ?? 0) + 1;
  }
  return result;
}

/// 计算有效分数的平均分（自动跳过非法输入）
double averageOfValid(List<int> scores) {
  final valid = scores.where((s) => s >= 0 && s <= 100).toList();
  if (valid.isEmpty) {
    return 0;
  }
  var sum = 0;
  for (final s in valid) {
    sum += s;
  }
  return sum / valid.length;
}

/// 供 bin/dart_basics.dart 调用
void runGradeClassifier() {
  print('--- 边界值与非法输入逐项验证 ---');

  final cases = <int>[100, 99, 90, 89, 60, 59, 0, -1, 101, 150];
  for (final score in cases) {
    print('  ${score.toString().padLeft(4)} 分 → ${classify(score)}');
  }

  print('\n--- 关键临界值对照（验证 >= 而不是 > ）---');
  print('  89 与 90：${classify(89).level} / ${classify(90).level}  ← 90 应进"优"');
  print('  59 与 60：${classify(59).level} / ${classify(60).level}  ← 60 应算"及格"');

  print('\n--- 批量统计与平均分 ---');
  final classScores = <int>[92, 85, 58, 100, 0, 77, 120, -5, 63, 90];
  print('  输入：$classScores');
  print('  各等级人数：${tallyByLevel(classScores)}');
  print('  有效分数平均分：${averageOfValid(classScores).toStringAsFixed(2)}');
  print('  说明：120 与 −5 属于非法输入，已被平均分计算自动跳过，不污染统计结果。');
}
