/// dart_basics.dart — 统一入口
///
/// 对应实践指南二第五部分：课堂案例复现 dart_basics。
/// 本文件是 dart run 的默认入口，按顺序调用四组示例：
///   1. types_demo — 变量、类型、插值、空安全四件套
///   2. func_demo  — 箭头函数、位置可选参数、命名参数
///   3. flow_demo  — 运算符、整除、分支、循环
///   4. practice   — 自主实践（空安全改写、命名参数、成绩分级器扩展）
///
/// 注意：dart run 默认执行 bin 下的入口文件，新增的示例函数必须在这里被调用，
/// 否则会出现"定义了但没跑"的情况，不满足复现要求。
library;

import 'flow_demo.dart';
import 'func_demo.dart';
import 'types_demo.dart';

import 'grade_classifier.dart';
import 'null_safety_fix.dart';
import 'report_generator.dart';

void main(List<String> arguments) {
  print('==================================================');
  print(' 课堂作业二 · Dart 语言基础一 · 案例复现 dart_basics');
  print(' 姓名：容磊　学号：20251060108');
  print(' Dart SDK：${_sdkHint()}');
  print('==================================================\n');

  // ---------- 第一组：变量、类型与空安全 ----------
  print('【第一组】变量、类型与空安全（bin/types_demo.dart）');
  print('--------------------------------------------------');
  runTypesDemo();

  // ---------- 第二组：函数与命名参数 ----------
  print('\n【第二组】函数、箭头函数与命名参数（bin/func_demo.dart）');
  print('--------------------------------------------------');
  runFuncDemo();

  // ---------- 第三组：运算符与控制流 ----------
  print('\n【第三组】运算符、分支与循环（bin/flow_demo.dart）');
  print('--------------------------------------------------');
  runFlowDemo();

  // ---------- 第四组：自主实践 ----------
  print('\n【第四组】自主实践三个任务（bin/ 下三个 practice 文件）');
  print('--------------------------------------------------');

  print('任务 1：空安全改写（bin/null_safety_fix.dart）');
  runNullSafetyFix();

  print('\n任务 2：命名参数设计（bin/report_generator.dart）');
  runReportGenerator();

  print('\n任务 3：成绩分级器扩展（bin/grade_classifier.dart）');
  runGradeClassifier();

  print('\n==================================================');
  print(' 全部示例执行完毕，无编译告警');
  print('==================================================');
}

/// 从环境变量读取 SDK 版本提示（只用于打印，不影响逻辑）
String _sdkHint() {
  const version = String.fromEnvironment('dartVersion');
  return version.isEmpty ? '3.x（见 dart --version）' : version;
}
