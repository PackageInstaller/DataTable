local raw = {
  [1] = ProtobufI("GachaEntranceModification", {
    activityId = 4008,
    activityType = 4,
    showHint = true,
    effectName = "UI_MaidTips_01",
    replaceTexture = true,
    texturePath = "egg_mode_1"
  }),
  [2] = ProtobufI("GachaEntranceModification", {
    activityId = 14043,
    activityType = 14,
    showHint = true,
    effectName = "UI_MaidTips_02",
    replaceTexture = true,
    texturePath = "egg_mode_3"
  }),
  [3] = ProtobufI("GachaEntranceModification", {
    activityId = 4010,
    activityType = 4,
    showHint = true,
    effectName = "UI_MaidTips_03",
    replaceTexture = true,
    texturePath = "egg_mode_4"
  })
}
local indexed = {
  [4008] = {
    [4] = 1
  },
  [4010] = {
    [4] = 3
  },
  [14043] = {
    [14] = 2
  }
}
return {raw, indexed}
