local raw = {
  [1] = ProtobufI("TaskActivePointReward", {
    targetActivePoint = 20,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10001,
        count = 5
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 40002,
        count = 5
      })
    }
  }),
  [2] = ProtobufI("TaskActivePointReward", {
    targetActivePoint = 40,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10001,
        count = 10
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 40002,
        count = 10
      })
    }
  }),
  [3] = ProtobufI("TaskActivePointReward", {
    targetActivePoint = 60,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10002,
        count = 5
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 40003,
        count = 5
      })
    }
  }),
  [4] = ProtobufI("TaskActivePointReward", {
    targetActivePoint = 80,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 51002,
        count = 2
      })
    }
  }),
  [5] = ProtobufI("TaskActivePointReward", {
    targetActivePoint = 100,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 12000})
    }
  }),
  [6] = ProtobufI("TaskActivePointReward", {
    targetActivePoint = 120,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 6, count = 150}),
      [3] = ProtobufI("STResource", {
        type = 11,
        id = 61000,
        count = 1
      })
    }
  })
}
local indexed = {
  [20] = 1,
  [40] = 2,
  [60] = 3,
  [80] = 4,
  [100] = 5,
  [120] = 6
}
return {raw, indexed}
