import 'package:blackbox/core/renderer/node.dart';
import 'package:blackbox/core/renderer/statement.dart';

abstract class Renderer{
  List<Node> findNodes();
  List<Statement> findStatements();
  String renderNodes();
  String renderStatements();
  String render();
}