local raw = {
  [1] = ProtobufI("RecallActivityReward", {
    process = 1,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      })
    }
  }),
  [2] = ProtobufI("RecallActivityReward", {
    process = 3,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 10
      })
    }
  }),
  [3] = ProtobufI("RecallActivityReward", {
    process = 5,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 14,
        id = 10,
        count = 1
      })
    }
  })
}
local indexed = {
  [1] = 1,
  [3] = 2,
  [5] = 3
}
return {raw, indexed}
