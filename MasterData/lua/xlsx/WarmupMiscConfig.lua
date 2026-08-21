local raw = {
  [1] = ProtobufI("WarmupMiscConfig", {
    diceCost = ProtobufI("STResource", {type = 11, id = 1025}),
    secretPlanCost = ProtobufI("STResource", {type = 27, count = 980}),
    delayRewards = {},
    dungeonProbability = 2000,
    dungeonForceCount = 4,
    dungeonCdCount = 1,
    dungeonMaxCountPerChapter = 6,
    cartoonId = 3007,
    taskRefreshCost = ProtobufI("STResource", {type = 5, count = 10})
  })
}
local indexed = {}
return {raw, indexed}
