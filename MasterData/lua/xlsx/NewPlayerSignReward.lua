local raw = {
  [1] = ProtobufI("NewPlayerSignReward", {
    activityId = 10201,
    day = 1,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      })
    }
  }),
  [2] = ProtobufI("NewPlayerSignReward", {
    activityId = 10201,
    day = 2,
    isBig = true,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 15,
        id = 1011,
        count = 1,
        param = 55
      })
    }
  }),
  [3] = ProtobufI("NewPlayerSignReward", {
    activityId = 10201,
    day = 3,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      })
    }
  }),
  [4] = ProtobufI("NewPlayerSignReward", {
    activityId = 10201,
    day = 4,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 8888})
    }
  }),
  [5] = ProtobufI("NewPlayerSignReward", {
    activityId = 10201,
    day = 5,
    isBig = true,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 3
      })
    }
  }),
  [6] = ProtobufI("NewPlayerSignReward", {
    activityId = 10201,
    day = 6,
    reward = {
      [1] = ProtobufI("STResource", {type = 6, count = 30})
    }
  }),
  [7] = ProtobufI("NewPlayerSignReward", {
    activityId = 10201,
    day = 7,
    isBig = true,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 74048,
        count = 1
      })
    }
  })
}
local indexed = {}
return {raw, indexed}
