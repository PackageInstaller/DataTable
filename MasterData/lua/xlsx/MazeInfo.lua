local raw = {
  [1] = ProtobufI("MazeInfo", {
    id = 1,
    difficulty = 1,
    unlockLevel = 45,
    maxActorCountMain = 4,
    maxActorCountSub = 4,
    maxFloor = 3,
    cost = ProtobufI("STResource", {
      type = 11,
      id = 80007,
      count = 1
    }),
    activityId = 34001,
    chaosBuyLimit = 1
  }),
  [2] = ProtobufI("MazeInfo", {
    id = 2,
    difficulty = 2,
    unlockLevel = 52,
    maxActorCountMain = 5,
    maxActorCountSub = 5,
    maxFloor = 3,
    cost = ProtobufI("STResource", {
      type = 11,
      id = 80007,
      count = 1
    }),
    activityId = 34001,
    chaosBuyLimit = 1,
    unlockMazeId = 1
  }),
  [3] = ProtobufI("MazeInfo", {
    id = 3,
    difficulty = 3,
    unlockLevel = 60,
    maxActorCountMain = 6,
    maxActorCountSub = 6,
    maxFloor = 3,
    cost = ProtobufI("STResource", {
      type = 11,
      id = 80007,
      count = 1
    }),
    activityId = 34001,
    chaosBuyLimit = 1,
    unlockMazeId = 2
  }),
  [4] = ProtobufI("MazeInfo", {
    id = 4,
    difficulty = 4,
    unlockLevel = 60,
    maxActorCountMain = 6,
    maxActorCountSub = 6,
    maxFloor = 3,
    cost = ProtobufI("STResource", {
      type = 11,
      id = 80007,
      count = 1
    }),
    activityId = 34001,
    chaosBuyLimit = 1,
    unlockMazeId = 3
  }),
  [5] = ProtobufI("MazeInfo", {
    id = 5,
    difficulty = 5,
    unlockLevel = 60,
    maxActorCountMain = 6,
    maxActorCountSub = 6,
    maxFloor = 3,
    cost = ProtobufI("STResource", {
      type = 11,
      id = 80007,
      count = 1
    }),
    activityId = 34001,
    chaosBuyLimit = 1,
    unlockMazeId = 4
  })
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5
}
return {raw, indexed}
