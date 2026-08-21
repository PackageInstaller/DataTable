local raw = {
  [1] = ProtobufI("PopupInfo", {
    activityId = 93001,
    shareRewardable = true,
    shareReward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      })
    },
    bgTextureName = "Coffee_banner",
    titleTextureName = "coffee_banner_title",
    popuptype = 1,
    priority = 3,
    minLevel = 9,
    maxLevel = 99,
    flyTarget = "Welfare",
    effect = "UI_CoverJump"
  })
}
local indexed = {
  [93001] = 1
}
return {raw, indexed}
