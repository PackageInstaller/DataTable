local raw = {
  [1] = ProtobufI("RacePVPBattleScoreReward", {
    battleScore = 2000,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40002,
        count = 20
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 10001,
        count = 20
      })
    }
  }),
  [2] = ProtobufI("RacePVPBattleScoreReward", {
    battleScore = 5000,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40003,
        count = 10
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 10002,
        count = 10
      })
    }
  }),
  [3] = ProtobufI("RacePVPBattleScoreReward", {
    battleScore = 7500,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40003,
        count = 20
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 10002,
        count = 20
      })
    }
  }),
  [4] = ProtobufI("RacePVPBattleScoreReward", {
    battleScore = 11000,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40004,
        count = 20
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 10003,
        count = 20
      })
    }
  }),
  [5] = ProtobufI("RacePVPBattleScoreReward", {
    battleScore = 13500,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40004,
        count = 10
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 10003,
        count = 10
      })
    }
  }),
  [6] = ProtobufI("RacePVPBattleScoreReward", {
    battleScore = 19000,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40005,
        count = 20
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 10003,
        count = 20
      })
    }
  }),
  [7] = ProtobufI("RacePVPBattleScoreReward", {
    battleScore = 24500,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40005,
        count = 30
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 10004,
        count = 30
      })
    }
  }),
  [8] = ProtobufI("RacePVPBattleScoreReward", {
    battleScore = 27500,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40005,
        count = 35
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 10004,
        count = 35
      })
    }
  }),
  [9] = ProtobufI("RacePVPBattleScoreReward", {
    battleScore = 33000,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40005,
        count = 40
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 10004,
        count = 40
      })
    }
  })
}
local indexed = {
  [2000] = 1,
  [5000] = 2,
  [7500] = 3,
  [11000] = 4,
  [13500] = 5,
  [19000] = 6,
  [24500] = 7,
  [27500] = 8,
  [33000] = 9
}
return {raw, indexed}
