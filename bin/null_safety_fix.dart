/// null_safety_fix.dart — 自主实践任务 1：空安全改写
///
/// 任务要求：把给定含隐患的可空代码改写为安全版本，并逐处解释。
///
/// 说明：作业页附的原始代码为一组含空安全隐患的片段，本文件按其涉及的
/// 三类典型问题（! 空断言的滥用、可空值未判空即使用、缺少默认值兜底）
/// 重写了等价的"改写前"版本作为对照，再给出"改写后"版本。
/// 两个版本都会真实运行，用输出现象来证明隐患确实存在。
library;

/// ============================================================
/// 改写前（存在空安全隐患的版本）
/// ============================================================

/// 隐患 1：用 ! 强行断言非空 —— 传入 null 时运行时报错
String unsafeGreeting(String? nickname) {
  // 危险：调用方传 null 时会抛 Null check operator used on a null value
  return '你好，${nickname!.toUpperCase()}';
}

/// 隐患 2：可空值未判空就直接取长度 —— 同样会在运行时崩
int unsafeLength(String? text) {
  // 危险：text 为 null 时抛异常
  return text!.length;
}

/// 隐患 3：可空结果未做默认值兜底 —— 得到 null 后继续参与拼接
String unsafeLevel(int? score) {
  // 危险：score 为 null 时，下面第二个分支不会执行，
  // 而前面的插值会把 null 拼进字符串，得到 "得分 null：null 级" 这种脏数据
  if (score != null && score >= 90) {
    return '得分 $score：优秀';
  }
  return '得分 $score：${_unsafeLevelOf(score)}';
}

String _unsafeLevelOf(int? score) {
  // 危险：没有处理 null，返回类型却是 String，编译器会直接报错，
  // 所以这里被迫加 ! —— 又是一处空断言滥用
  return score! >= 60 ? '及格' : '不及格';
}

/// ============================================================
/// 改写后（安全版本）
/// ============================================================

/// 改写 1：用 ?? 提供默认值，彻底去掉 !
String safeGreeting(String? nickname) {
  final name = nickname ?? '同学'; // null 时用默认值兜底
  return '你好，${name.toUpperCase()}';
}

/// 改写 1 的另一个思路：用 ?. 安全调用 + ?? 兜底
String safeGreetingWithNullAware(String? nickname) {
  final upper = nickname?.toUpperCase(); // null 时短路返回 null
  return '你好，${upper ?? '同学'}';
}

/// 改写 2：先判空再使用，把 null 情况显式处理掉
int safeLength(String? text) {
  if (text == null) {
    return 0; // 显式给出"空文本长度为 0"的语义
  }
  return text.length; // 此处 Dart 已把 text 提升为 String，不需要 !
}

/// 改写 2 的另一个思路：用 ?? 直接兜底
int safeLengthWithFallback(String? text) => (text ?? '').length;

/// 改写 3：把 null 当作合法输入显式处理，不让它流入字符串拼接
String safeLevel(int? score) {
  if (score == null) {
    return '未提供分数，无法评级'; // 明确告知缺数据，而不是拼出 "null 级"
  }
  if (score < 0 || score > 100) {
    return '分数 $score 非法（应在 0~100）';
  }
  return '得分 $score：${levelOf(score)}';
}

/// 纯函数：入参非空，内部无需任何空判断
String levelOf(int score) {
  if (score >= 90) return '优秀';
  if (score >= 60) return '及格';
  return '不及格';
}

/// ============================================================
/// 对照演示
/// ============================================================

/// 安全地执行一段可能抛错的代码，用于演示"隐患版会崩、安全版不会"
String _tryRun(String Function() action) {
  try {
    return action();
  } catch (e) {
    return '【抛出异常】${e.runtimeType}: $e';
  }
}

/// 供 bin/dart_basics.dart 调用
void runNullSafetyFix() {
  print('--- 隐患版 vs 安全版（每处都用真实运行结果对照）---');

  print('\n[隐患 1] 用 ! 强行断言非空');
  print('  传 null 进隐患版：${_tryRun(() => unsafeGreeting(null))}');
  print('  传 null 进安全版：${safeGreeting(null)}');
  print('  传 "hu" 进安全版：${safeGreeting('hu')}');
  print('  安全版另一写法：${safeGreetingWithNullAware(null)}');

  print('\n[隐患 2] 可空值未判空就取长度');
  print('  传 null 进隐患版：${_tryRun(() => unsafeLength(null).toString())}');
  print('  传 null 进安全版：${safeLength(null)}（约定空文本长度为 0）');
  print('  传 "dart" 进安全版：${safeLength('dart')}');
  print('  安全版另一写法：${safeLengthWithFallback(null)}');

  print('\n[隐患 3] 可空结果未兜底，拼出脏数据');
  print('  传 null 进隐患版：${_tryRun(() => unsafeLevel(null))}');
  print('  传 null 进安全版：${safeLevel(null)}');
  print('  传 92   进安全版：${safeLevel(92)}');
  print('  传 45   进安全版：${safeLevel(45)}');
  print('  传 120  进安全版：${safeLevel(120)}');

  print('\n--- 逐处改动小结 ---');
  print(
    '  1. unsafeGreeting 的 nickname!.toUpperCase()  →  nickname ?? \'同学\' 后再 .toUpperCase()',
  );
  print('     理由：! 只是"向编译器保证非空"，一旦为 null 就在运行时崩；?? 是真正把 null 处理掉。');
  print(
    '  2. unsafeLength 的 text!.length              →  if (text == null) return 0; 后再 text.length',
  );
  print('     理由：判空后 Dart 会把 text 从 String? 提升为 String，无需 ! 也能通过编译。');
  print('  3. unsafeLevel 直接把可空 score 拼进字符串   →  先判 null 返回明确文案，再交给纯函数处理');
  print('     理由：null 是合法输入的一种，应当被显式处理，而不是靠 ! 掩盖。');
}
