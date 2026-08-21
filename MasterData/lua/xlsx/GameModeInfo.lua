local raw = {
  [1] = ProtobufI("GameModeInfo", {
    gameMode = 1,
    enterCondition = ProtobufI("EnterCondition", {finishedChapterId = 3001, finishedChapterIdIsOptional = true})
  }),
  [2] = ProtobufI("GameModeInfo", {
    gameMode = 2,
    enterCondition = ProtobufI("EnterCondition", {finishedChapterId = 3001, finishedChapterIdIsOptional = true})
  }),
  [3] = ProtobufI("GameModeInfo", {
    gameMode = 3,
    enterCondition = ProtobufI("EnterCondition", {finishedChapterId = 3001, finishedChapterIdIsOptional = true})
  })
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3
}
return {raw, indexed}
