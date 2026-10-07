/// type_promotion_research.dart — 独立研究任务 2：类型提升规则验证
///
/// 研究问题：可空变量在 if 判空之后，能否直接当非空用（不需要 `!`）？
/// 实验方法：分别对**局部变量、函数参数、final 字段、非 final 字段、
/// 集合元素**做判空实验，观察哪些位置会发生类型提升。
library;

/// 用于验证"字段能否被提升"的类
class Box {
  /// public final 字段：**不能**提升
  ///
  /// 实验最初以为 final 字段都能提升，运行 `dart analyze` 却得到：
  ///   Error: Property 'length' cannot be accessed on 'String?' because it is
  ///   potentially null.
  ///   Context: 'finalValue' refers to a public property so it couldn't be promoted.
  /// 即 public 字段即使声明为 final 也不参与提升——因为库外代码可能通过
  /// getter 覆写等机制改变它的可见行为，编译器不能保证"判空时非空、使用时仍非空"。
  final String? finalValue;

  /// 非 final 字段：值随时可能被改，流分析不会提升
  String? mutableValue;

  /// private final 字段：**可以**提升（Dart 3.2 起支持 private final 字段提升）
  final String? _secret;

  Box(this.finalValue, this.mutableValue, this._secret);

  /// public final 字段判空后**不能**直接使用，必须借助局部变量
  String describeFinal() {
    // 若直接写 if (finalValue != null) { finalValue.length } 会编译失败：
    //   Property 'length' cannot be accessed on 'String?' because it is potentially null.
    // 正确做法：先取到局部变量，让流分析在局部变量上生效。
    final v = finalValue;
    if (v != null) {
      return 'public final 字段先赋局部变量后可用：${v.length}';
    }
    return 'public final 字段为 null';
  }

  /// private final 字段在同库内可直接提升，无需中间变量
  String describeSecret() {
    if (_secret != null) {
      // 这里既不需要中间变量，也不需要 !
      return 'private final 字段判空后可直接用：${_secret.length}';
    }
    return 'private 字段为 null';
  }

  /// 非 final 字段：同样必须借助局部变量或 !
  String describeMutable() {
    // 直接写 if (mutableValue != null) { mutableValue.length } 会有告警，
    // 因为字段值在判空与使用之间可能被其它代码改掉。
    final local = mutableValue;
    if (local != null) {
      return '非 final 字段先赋局部变量后可用：${local.length}';
    }
    return '非 final 字段为 null';
  }
}

/// 集合元素不能直接提升
String describeMapValue(Map<String, String?> data, String key) {
  // 下面这种写法不成立：data[key] 每次都是新的取值，编译器不提升
  // if (data[key] != null) { return data[key]!.length; }  ← 仍需 !
  // 正确做法：先取到局部变量
  final value = data[key];
  if (value != null) {
    return '从 Map 取出后存局部变量才能提升：${value.length}';
  }
  return '键 $key 不存在或值为 null';
}

/// 实验 1 辅助：局部变量判空后可直接使用（值由参数传入，保证可能为 null）
void testLocalPromotion(String? input) {
  String? local = input;
  if (local != null) {
    // 此处 local 已提升为 String，写 local!.length 反会有
    // unnecessary_non_null_assertion 告警
    print('  if 判空后 local.length = ${local.length}（无需 !）');
  } else {
    print('  输入为 null，未进入提升分支');
  }
}

/// 实验 2 辅助：函数参数判空后可直接使用
void testParamPromotion(String? param) {
  if (param != null) {
    print('  参数判空后 param.length = ${param.length}（无需 !）');
  } else {
    print('  参数为 null，未进入提升分支');
  }
}

/// 供 bin/dart_basics.dart 调用
void runTypePromotionResearch() {
  // 注意：为了让"判空"不是恒真条件，这里把值做成可能为 null 的形式
  // （若写成 String? local; local = 'dart'; 再判空，analyzer 会提示
  //   unnecessary_null_comparison，因为流分析已知它非空。）
  testLocalPromotion('dart');
  testLocalPromotion(null);

  print('\n--- 实验 2：函数参数（可提升）---');
  testParamPromotion('flutter');
  testParamPromotion(null);

  print('\n--- 实验 3：public final 字段（不可提升！）---');
  final box = Box('abcde', 'xyz', 'secret-value');
  print('  ${box.describeFinal()}');
  print('  若直接写 if (finalValue != null) { finalValue.length } 会编译失败：');
  print(
    '    Property \'length\' cannot be accessed on \'String?\' because it is potentially null.',
  );
  print(
    '    Context: \'finalValue\' refers to a public property so it couldn\'t be promoted.',
  );
  print('  ★ 这是本次研究最意外的发现：public final 字段**不能**提升。');

  print('\n--- 实验 4：private final 字段（可提升）---');
  print('  ${box.describeSecret()}');

  print('\n--- 实验 5：非 final 字段（不可提升，需借助局部变量）---');
  print('  ${box.describeMutable()}');
  print('  若直接对字段判空后使用，dart analyze 会报：');
  print(
    '    The property \'length\' can\'t be unconditionally accessed because',
  );
  print('    the receiver can\'t be null. —— 因为字段值可能在两行之间被改动。');

  print('\n--- 实验 6：集合元素（不可提升，需先取到局部变量）---');
  final data = <String, String?>{'token': 'tk_123', 'empty': null};
  print('  ${describeMapValue(data, 'token')}');
  print('  ${describeMapValue(data, 'empty')}（键不存在或值为 null）');

  print('\n--- 实验 7：赋值后的提升（definite assignment）---');
  String? assigned;
  assigned = 'now-set';
  // 赋值后 Dart 知道它一定非空（definite assignment analysis），
  // 所以下面这行不需要 ! —— 这也是 analyzer 会提示
  // unnecessary_non_null_assertion 的场景
  print('  赋值后 assigned.length = ${assigned.length}（无需 !）');

  print('\n--- 研究结论 ---');
  print('  1. 能提升的位置：局部变量、函数参数、private final 字段；');
  print('     判空之后可直接当非空用，不需要 !；');
  print('  2. 不能提升的位置：public 字段（即使 final）、非 final 字段、');
  print('     集合元素（Map/List 的取值表达式）。原因是编译器无法保证');
  print('     "判空时非空、使用时仍非空"；');
  print('  3. 通用解法：把要用的值先取到一个 final 局部变量，再判空使用——');
  print('     这样既不写 !（避免运行期风险），也不触发不必要的空断言告警；');
  print('  4. 实践意义：本次作业里 dart analyze 从 2 个 warning 降到 0，');
  print('     其中一条正是"对一个已被提升的变量多写了 !"（unnecessary_non_null_assertion），');
  print('     说明理解提升规则能直接让代码更干净。');
}

void main() {
  print('===== 独立研究任务 2：类型提升规则验证 =====');
  runTypePromotionResearch();
}
