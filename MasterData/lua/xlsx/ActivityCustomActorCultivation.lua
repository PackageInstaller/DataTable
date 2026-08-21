local raw = {
  [1] = ProtobufI("ActivityCustomActorCultivation", {
    activityType = 69,
    activityId = 69001,
    limitBan = true,
    availableActors = {},
    effectDays = 40,
    maxProgress = 100,
    activeVipCost = {
      [1] = ProtobufI("STResource", {type = 27, count = 1280})
    },
    cgItem = ProtobufI("STResource", {
      type = 11,
      id = 86003,
      count = 1
    }),
    bigCgRes = "Texture/Background/CustomizedPlan_bg",
    smallCgRes = "Texture/Welfare/CustomizedPlan_small_bg_1",
    displayRewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 86004,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 86005,
        count = 1
      }),
      [3] = ProtobufI("STResource", {
        type = 11,
        id = 124023,
        count = 1
      }),
      [4] = ProtobufI("STResource", {
        type = 11,
        id = 10004,
        count = 1
      })
    },
    titleRes = "Texture/Welfare/CustomizedPlan/CustomizedPlan_title1",
    shortTitleRes = "Texture/Welfare/CustomizedPlan/CustomizedPlan_title1"
  }),
  [2] = ProtobufI("ActivityCustomActorCultivation", {
    activityType = 69,
    activityId = 69002,
    limitBan = true,
    availableActors = {},
    effectDays = 40,
    maxProgress = 100,
    activeVipCost = {
      [1] = ProtobufI("STResource", {type = 27, count = 1280})
    },
    cgItem = ProtobufI("STResource", {
      type = 11,
      id = 86012,
      count = 1
    }),
    bigCgRes = "Texture/Background/CustomizedPlan_bg_2",
    smallCgRes = "Texture/Welfare/CustomizedPlan_small_bg_2",
    displayRewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 86004,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 86005,
        count = 1
      }),
      [3] = ProtobufI("STResource", {
        type = 11,
        id = 124023,
        count = 1
      }),
      [4] = ProtobufI("STResource", {
        type = 11,
        id = 10004,
        count = 1
      })
    },
    titleRes = "Texture/Welfare/CustomizedPlan/CustomizedPlan_title2_1",
    shortTitleRes = "Texture/Welfare/CustomizedPlan/CustomizedPlan_title2_1"
  })
}
local indexed = {
  [69] = {
    [69001] = 1,
    [69002] = 2
  }
}
return {raw, indexed}
