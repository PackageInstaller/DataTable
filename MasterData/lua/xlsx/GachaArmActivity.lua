local raw = {
  [1] = ProtobufI("GachaArmActivity", {
    activityId = 97001,
    armId = 4001,
    bgPath = "Texture/Gacha/gacha_ad_97001"
  }),
  [2] = ProtobufI("GachaArmActivity", {
    activityId = 97002,
    armId = 4002,
    bgPath = "Texture/Gacha/gacha_ad_97002"
  }),
  [3] = ProtobufI("GachaArmActivity", {
    activityId = 97003,
    armId = 4003,
    bgPath = "Texture/Gacha/gacha_ad_97003"
  })
}
local indexed = {
  [97001] = 1,
  [97002] = 2,
  [97003] = 3
}
return {raw, indexed}
