local raw = {
  [1] = ProtobufI("GuildDungeonContributionReward", {
    score = 50000,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 71714,
        count = 10
      })
    }
  }),
  [2] = ProtobufI("GuildDungeonContributionReward", {
    score = 100000,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 71714,
        count = 20
      })
    }
  }),
  [3] = ProtobufI("GuildDungeonContributionReward", {
    score = 150000,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 71714,
        count = 20
      })
    }
  }),
  [4] = ProtobufI("GuildDungeonContributionReward", {
    score = 200000,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 71714,
        count = 20
      })
    }
  }),
  [5] = ProtobufI("GuildDungeonContributionReward", {
    score = 300000,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 71714,
        count = 30
      })
    }
  })
}
local indexed = {
  [50000] = 1,
  [100000] = 2,
  [150000] = 3,
  [200000] = 4,
  [300000] = 5
}
return {raw, indexed}
