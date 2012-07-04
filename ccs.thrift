
namespace cpp ccs
namespace py ccs
namespace java org.zjg.ccs

enum CursorKind {
   // declarations
   UnexposedDecl,
   StructDecl,
   UnionDecl,
   ClassDecl,
   EnumDecl,
   FieldDecl,
   EnumConstantDecl,
   FunctionDecl,
   VarDecl,
   ParmDecl,
   ObjCInterfaceDecl,
   ObjCCategoryDecl,
   ObjCProtocolDecl,
   ObjCPropertyDecl,
   ObjCIvarDecl,
   ObjCInstanceMethodDecl,
   ObjCClassMethodDecl,
   ObjCImplementationDecl,
   ObjCCategoryImplDecl,
   TypedefDecl,
   CXXMethod,
   Namespace,
   LinkageSpec,
   Constructor,
   Destructor,
   ConversionFunction,
   TemplateTypeParameter,
   NonTypeTemplateParameter,
   TemplateTemplateParameter,
   FunctionTemplate,
   ClassTemplate,
   ClassTemplatePartialSpecialization,
   NamespaceAlias,
   UsingDirective,
   UsingDeclaration,
   TypeAliasDecl,
   ObjCSynthesizeDecl,
   ObjCDynamicDecl,
   CXXAccessSpecifier,
   
   // references
   ObjCSuperClassRef,
   ObjCProtocolRef,
   ObjCClassRef,
   TypeRef,
   CXXBaseSpecifier,
   TemplateRef,
   NamespaceRef,
   MemberRef,
   LabelRef,
   OverloadedDeclRef,
   VariableRef,
   
   // error conditions
   InvalidFile,
   NoDeclFound,
   NotImplemented,
   InvalidCode,
   
   // expressions
   UnexposedExpr,
   DeclRefExpr,
   MemberRefExpr,
   CallExpr,
   ObjCMessageExpr,
   BlockExpr,
   IntegerLiteral,
   FloatingLiteral,
   ImaginaryLiteral,
   StringLiteral,
   CharacterLiteral,
   ParenExpr,
   UnaryOperator,
   ArraySubscriptExpr,
   BinaryOperator,
   CompoundAssignOperator,
   ConditionalOperator,
   CStyleCastExpr,
   CompoundLiteralExpr,
   InitListExpr,
   AddrLabelExpr,
   StmtExpr,
   GenericSelectionExpr,
   GNUNullExpr,
   CXXStaticCastExpr,
   CXXDynamicCastExpr,
   CXXReinterpretCastExpr,
   CXXConstCastExpr,
   CXXFunctionalCastExpr,
   CXXBoolLiteralExpr,
   CXXNullPtrLiteralExpr,
   CXXThisExpr,
   CXXThrowExpr,
   CXXNewExpr,
   CXXDeleteExpr,
   UnaryExpr,
   ObjCStringLiteral,
   ObjCEncodeExpr,
   ObjCSelectorExpr,
   ObjCProtocolExpr,
   ObjCBridgedCastExpr,
   ObjCBoolLiteralExpr,
   
   // statements
   UnexposedStmt,
   LabelStmt,
   CaseStmt,
   DefaultStmt,
   IfStmt,
   SwitchStmt,
   WhileStmt,
   DoStmt,
   ForStmt,
   GotoStmt,
   IndirectGotoStmt,
   ContinueStmt,
   BreakStmt,
   ReturnStmt,
   AsmStmt,
   ObjCAtTryStmt,
   ObjCAtCatchStmt,
   ObjCAtFinallyStmt,
   ObjCAtThrowStmt,
   ObjCAtSynchronizedStmt,
   ObjCAutoreleasePoolStmt,
   ObjCForCollectionStmt,
   CXXCatchStmt,
   CXXTryStmt,
   CXXForRangeStmt,
   SEHTryStmt,
   SEHExceptStmt,
   SEHFinallyStmt,
   MSAsmStmt,
   NullStmt,
   DeclStmt,
   
   // attributes
   UnexposedAttr,
   IBActionAttr,
   IBOutletAttr,
   IBOutletCollectionAttr,
   CXXFinalAttr,
   CXXOverrideAttr,
   AnnotateAttr,
   AsmLabelAttr,
   
   // preprocessing
   PreprocessingDirective,
   MacroDefinition,
   MacroExpansion,
   MacroInstantiation,
   InclusionDirective,
   
   // other
   TranslationUnit,
}

struct CodeCompletionRequest {
   1: required string filename;
   2: required i32 line;
   3: required i32 column;
}

enum CodeCompletionChunkKind {

   // todo - handle Optional chunks somehow (can't do recursive structs in thrift)

   /* these kinds have an associated text string */
   TypedText,
   Text,
   Placeholder,
   Informative,
   CurrentParameter,
   ResultType,
   
   /* these kinds won't have an associated text string */
   LeftParen,
   RightParen,
   LeftBracket,
   RightBracket,
   LeftBrace,
   RightBrace,
   LeftAngle,
   RightAngle,
   Comma,
   Colon,
   SemiColon,
   Equal,
   Space,
   Newline,
}

struct CodeCompletionChunk {
   1: required CodeCompletionChunkKind kind;
   2: optional string text;
}

// todo - annotations ?

struct CodeCompletionCandidate {
   // all candidates should have a TypedText chunk
   1: required list<CodeCompletionChunk> chunks;   // don't use a map, order is important!
   
   2: optional i32 priority;
   3: optional string parentContext;
   4: optional CursorKind parentKind;
}

struct CodeCompletionResponse {
   1: optional CodeCompletionRequest request;
   2: required list<CodeCompletionCandidate> results;
}

service CCS {
   string getVersionInfo();
   
   CodeCompletionResponse codeCompletion(1:CodeCompletionRequest request);
}
