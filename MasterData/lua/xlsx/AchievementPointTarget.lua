local raw = {
  [1] = ProtobufI("AchievementPointTarget", {trophy = 1, level = 1}),
  [2] = ProtobufI("AchievementPointTarget", {
    trophy = 1,
    level = 2,
    targetAchievementPoint = 50
  }),
  [3] = ProtobufI("AchievementPointTarget", {
    trophy = 1,
    level = 3,
    targetAchievementPoint = 100
  }),
  [4] = ProtobufI("AchievementPointTarget", {
    trophy = 1,
    level = 4,
    targetAchievementPoint = 150
  }),
  [5] = ProtobufI("AchievementPointTarget", {
    trophy = 1,
    level = 5,
    targetAchievementPoint = 200
  }),
  [6] = ProtobufI("AchievementPointTarget", {
    trophy = 1,
    level = 6,
    targetAchievementPoint = 250
  }),
  [7] = ProtobufI("AchievementPointTarget", {
    trophy = 2,
    level = 1,
    targetAchievementPoint = 300
  }),
  [8] = ProtobufI("AchievementPointTarget", {
    trophy = 2,
    level = 2,
    targetAchievementPoint = 400
  }),
  [9] = ProtobufI("AchievementPointTarget", {
    trophy = 2,
    level = 3,
    targetAchievementPoint = 500
  }),
  [10] = ProtobufI("AchievementPointTarget", {
    trophy = 3,
    level = 1,
    targetAchievementPoint = 600
  }),
  [11] = ProtobufI("AchievementPointTarget", {
    trophy = 3,
    level = 2,
    targetAchievementPoint = 700
  }),
  [12] = ProtobufI("AchievementPointTarget", {
    trophy = 3,
    level = 3,
    targetAchievementPoint = 800
  }),
  [13] = ProtobufI("AchievementPointTarget", {
    trophy = 4,
    level = 1,
    targetAchievementPoint = 900
  }),
  [14] = ProtobufI("AchievementPointTarget", {
    trophy = 4,
    level = 2,
    targetAchievementPoint = 1000
  }),
  [15] = ProtobufI("AchievementPointTarget", {
    trophy = 4,
    level = 3,
    targetAchievementPoint = 1100
  }),
  [16] = ProtobufI("AchievementPointTarget", {
    trophy = 4,
    level = 4,
    targetAchievementPoint = 1200
  }),
  [17] = ProtobufI("AchievementPointTarget", {
    trophy = 5,
    level = 1,
    targetAchievementPoint = 1300
  })
}
local indexed = {
  [1] = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6
  },
  [2] = {
    [1] = 7,
    [2] = 8,
    [3] = 9
  },
  [3] = {
    [1] = 10,
    [2] = 11,
    [3] = 12
  },
  [4] = {
    [1] = 13,
    [2] = 14,
    [3] = 15,
    [4] = 16
  },
  [5] = {
    [1] = 17
  }
}
return {raw, indexed}
