local raw = {
  [1] = ProtobufI("DungeonModeIndex", {
    id = 1,
    time = 99,
    maxSp = 20,
    maxMp = 10,
    changeRate = 1,
    addMp = 1
  }),
  [2] = ProtobufI("DungeonModeIndex", {
    id = 2,
    time = 30,
    maxSp = 20,
    maxMp = 10,
    changeRate = 1,
    addMp = 2
  }),
  [3] = ProtobufI("DungeonModeIndex", {
    id = 3,
    time = 30,
    maxSp = 20,
    maxMp = 10,
    changeRate = 1,
    roundMp = 4,
    infiniteSkill = 1
  }),
  [4] = ProtobufI("DungeonModeIndex", {
    id = 4,
    time = 12,
    maxSp = 20,
    maxMp = 10,
    changeRate = 1,
    addMp = 1
  }),
  [5] = ProtobufI("DungeonModeIndex", {
    id = 6,
    time = 99,
    maxSp = 30,
    maxMp = 12,
    initSp = 3,
    initMp = 6,
    changeRate = 1,
    addMp = 1
  }),
  [6] = ProtobufI("DungeonModeIndex", {
    id = 801,
    time = 99,
    maxSp = 20,
    maxMp = 10,
    initSp = 5,
    initMp = 5,
    changeRate = 1,
    addMp = 1
  }),
  [7] = ProtobufI("DungeonModeIndex", {
    id = 802,
    time = 99,
    maxSp = 20,
    maxMp = 10,
    changeRate = 1,
    addMp = 1,
    roundSp = 3
  }),
  [8] = ProtobufI("DungeonModeIndex", {
    id = 803,
    time = 99,
    maxSp = 20,
    maxMp = 10,
    changeRate = 1,
    addMp = 1,
    roundMp = 2
  }),
  [9] = ProtobufI("DungeonModeIndex", {
    id = 3100601,
    time = 99,
    maxSp = 20,
    maxMp = 10,
    changeRate = 1,
    roundMp = 10
  }),
  [10] = ProtobufI("DungeonModeIndex", {
    id = 3100602,
    time = 99,
    maxSp = 20,
    maxMp = 10,
    changeRate = 1,
    roundMp = 10
  }),
  [11] = ProtobufI("DungeonModeIndex", {
    id = 3007,
    time = 99,
    maxSp = 20,
    maxMp = 10,
    changeRate = 1,
    roundMp = 6
  })
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [6] = 5,
  [801] = 6,
  [802] = 7,
  [803] = 8,
  [3007] = 11,
  [3100601] = 9,
  [3100602] = 10
}
return {raw, indexed}
