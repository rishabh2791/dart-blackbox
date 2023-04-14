const Set<String> _statementKeywords = {
  "for",
  "if",
  "block",
  "extends",
  "print",
  "macro",
  "include",
  "from",
  "import",
  "set",
  "with",
  "autoescape",
};
const Set<String> _compareOperators = {
  "eq", 
  "ne", 
  "lt", 
  "lteq", 
  "gt", 
  "gteq",
};
const Set<String> _mathNodes = {
  "add",
  "mul",
  "sub",
  "div",
  "floordiv",
  "mod",
};

class Parser{
}

/*
  Parsing involves identifying the nodes and parsing nodes recursively. This follows prototype pattern of design.
  Each Node can just be a set of statements or sub nodes.

  1. Nodes - Nodes start with one of statement keywords listed under set _statementKeywords and end with end statement
  2. Statements - Fundamental Unit for parsing and displaying

*/