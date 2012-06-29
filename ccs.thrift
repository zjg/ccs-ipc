
namespace cpp ccs
namespace py ccs
namespace java org.zjg.ccs

struct CodeCompletionRequest {
   1: required string filename;
   2: required i32 line;
   3: required i32 column;
}

// todo - handle Optional chunks somehow (can't do recursive structs in thrift)

enum CodeCompletionChunkKind {

   /* note - TypedText is not in this enum since it is a required field
    * of the candidate
    */
   //TypedText,
   
   /* these kinds have an associated text string */
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
   1: required string typedText;
   2: optional i32 priority;
   3: optional string parentContext;
   4: optional list<CodeCompletionChunk> chunks;
}

struct CodeCompletionResponse {
   1: optional CodeCompletionRequest request;
   2: required list<CodeCompletionCandidate> results;
}

service CCS {

   void ping();
   
   CodeCompletionResponse codeCompletion(1:CodeCompletionRequest request);

}
