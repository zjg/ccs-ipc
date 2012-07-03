
namespace cpp ccs
namespace py ccs
namespace java org.zjg.ccs

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
   1: required list<CodeCompletionChunk> chunks;
   
   2: optional i32 priority;
   3: optional string parentContext;
}

struct CodeCompletionResponse {
   1: optional CodeCompletionRequest request;
   2: required list<CodeCompletionCandidate> results;
}

service CCS {
   string getVersionInfo();
   
   CodeCompletionResponse codeCompletion(1:CodeCompletionRequest request);
}
