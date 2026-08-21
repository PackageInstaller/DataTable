local raw = {
  [1] = ProtobufI("WeekActivePointReward", {
    activePoint = 99999,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      })
    }
  })
}
local indexed = {
  [99999] = 1
}
return {raw, indexed}
