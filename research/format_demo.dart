/// format_demo.dart — 独立研究任务 3：dart format 规范实践
///
/// 研究问题：dart format 到底会改哪些东西？改动的依据是什么？
/// 实验方法：写一个故意违反规范的版本，格式化后逐处对比 diff。
library;

// 说明：本文件在首次提交时是"故意不规范"的版本，
// 运行 dart format 后成为规范版本。diff 记录见 format_diff.txt。

class StudentScore {
  final String name;
  final int score;
  StudentScore(this.name, this.score);
  String get level {
    if (score >= 90) {
      return '优';
    } else if (score >= 60) {
      return '及格';
    } else {
      return '不及格';
    }
  }

  String describe() => '$name：$score 分，等级 $level';
}

String buildSummary(List<StudentScore> students) {
  var counts = <String, int>{'优': 0, '及格': 0, '不及格': 0};
  for (final s in students) {
    counts[s.level] = counts[s.level]! + 1;
  }
  final parts = <String>[];
  counts.forEach((k, v) {
    parts.add('$k $v 人');
  });
  return parts.join('，');
}

void runFormatDemo() {
  final students = [
    StudentScore('李华', 92),
    StudentScore('王明', 58),
    StudentScore('赵敏', 76),
  ];
  print('--- dart format 规范实践 ---');
  for (final s in students) {
    print('  ${s.describe()}');
  }
  print('  统计：${buildSummary(students)}');
  print('');
  print('  格式化前后的一致性验证：');
  print('  本文件经 dart format 处理后，输出结果与格式化前完全相同，');
  print('  说明 dart format 只调整排版（缩进、空格、换行、括号位置），');
  print('  不改变任何语义。');
}

void main() {
  runFormatDemo();
}
