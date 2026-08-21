local raw = {
  [1] = ProtobufI("MiniGamesScoreReward", {
    activityId = 54008,
    gameId = 91001,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 6000}),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 2012,
        count = 20
      })
    }
  }),
  [2] = ProtobufI("MiniGamesScoreReward", {
    activityId = 54008,
    gameId = 91001,
    score = 10,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 7500}),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 2012,
        count = 20
      })
    }
  }),
  [3] = ProtobufI("MiniGamesScoreReward", {
    activityId = 54008,
    gameId = 91001,
    score = 20,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 9000}),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 2012,
        count = 20
      })
    }
  }),
  [4] = ProtobufI("MiniGamesScoreReward", {
    activityId = 54008,
    gameId = 91001,
    score = 30,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 10000}),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 2012,
        count = 20
      })
    }
  }),
  [5] = ProtobufI("MiniGamesScoreReward", {
    activityId = 54008,
    gameId = 91001,
    score = 40,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 11500}),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 2012,
        count = 20
      })
    }
  })
}
local indexed = {
  [54008] = {
    [91001] = {
      [0] = 1,
      [10] = 2,
      [20] = 3,
      [30] = 4,
      [40] = 5
    }
  }
}
return {raw, indexed}
