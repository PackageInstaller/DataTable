local raw = {
  [1] = ProtobufI("GuildDungeonChallengeProgressReward", {
    dungeonId = 6001,
    progress = 20,
    rewards = {
      [1] = ProtobufI("STResource", {type = 7, count = 70000})
    }
  }),
  [2] = ProtobufI("GuildDungeonChallengeProgressReward", {
    dungeonId = 6001,
    progress = 50,
    rewards = {
      [1] = ProtobufI("STResource", {type = 7, count = 70000})
    }
  }),
  [3] = ProtobufI("GuildDungeonChallengeProgressReward", {
    dungeonId = 6001,
    progress = 80,
    rewards = {
      [1] = ProtobufI("STResource", {type = 7, count = 70000})
    }
  }),
  [4] = ProtobufI("GuildDungeonChallengeProgressReward", {
    dungeonId = 6001,
    progress = 100,
    rewards = {
      [1] = ProtobufI("STResource", {type = 7, count = 120000})
    }
  }),
  [5] = ProtobufI("GuildDungeonChallengeProgressReward", {
    dungeonId = 6002,
    progress = 20,
    rewards = {
      [1] = ProtobufI("STResource", {type = 7, count = 70000})
    }
  }),
  [6] = ProtobufI("GuildDungeonChallengeProgressReward", {
    dungeonId = 6002,
    progress = 50,
    rewards = {
      [1] = ProtobufI("STResource", {type = 7, count = 70000})
    }
  }),
  [7] = ProtobufI("GuildDungeonChallengeProgressReward", {
    dungeonId = 6002,
    progress = 80,
    rewards = {
      [1] = ProtobufI("STResource", {type = 7, count = 70000})
    }
  }),
  [8] = ProtobufI("GuildDungeonChallengeProgressReward", {
    dungeonId = 6002,
    progress = 100,
    rewards = {
      [1] = ProtobufI("STResource", {type = 7, count = 120000})
    }
  }),
  [9] = ProtobufI("GuildDungeonChallengeProgressReward", {
    dungeonId = 6003,
    progress = 20,
    rewards = {
      [1] = ProtobufI("STResource", {type = 7, count = 70000})
    }
  }),
  [10] = ProtobufI("GuildDungeonChallengeProgressReward", {
    dungeonId = 6003,
    progress = 50,
    rewards = {
      [1] = ProtobufI("STResource", {type = 7, count = 70000})
    }
  }),
  [11] = ProtobufI("GuildDungeonChallengeProgressReward", {
    dungeonId = 6003,
    progress = 80,
    rewards = {
      [1] = ProtobufI("STResource", {type = 7, count = 70000})
    }
  }),
  [12] = ProtobufI("GuildDungeonChallengeProgressReward", {
    dungeonId = 6003,
    progress = 100,
    rewards = {
      [1] = ProtobufI("STResource", {type = 7, count = 120000})
    }
  })
}
local indexed = {
  [6001] = {
    [20] = 1,
    [50] = 2,
    [80] = 3,
    [100] = 4
  },
  [6002] = {
    [20] = 5,
    [50] = 6,
    [80] = 7,
    [100] = 8
  },
  [6003] = {
    [20] = 9,
    [50] = 10,
    [80] = 11,
    [100] = 12
  }
}
return {raw, indexed}
