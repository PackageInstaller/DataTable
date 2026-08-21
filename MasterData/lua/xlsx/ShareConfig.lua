local raw = {
  [1] = ProtobufI("ShareConfig", {
    shareName = "ActorCultivationComplete",
    widgets = {},
    logoColor = "white"
  }),
  [2] = ProtobufI("ShareConfig", {
    shareName = "ActorEquipCompare",
    isDynamicContent = true,
    widgets = {
      [1] = "WidgetShareEquip"
    }
  }),
  [3] = ProtobufI("ShareConfig", {
    shareName = "ActorMain",
    widgets = {},
    logoColor = "white",
    playerBg = "black"
  }),
  [4] = ProtobufI("ShareConfig", {
    shareName = "ArmDetail",
    isDynamicContent = true,
    widgets = {
      [1] = "WidgetShareArm"
    }
  }),
  [5] = ProtobufI("ShareConfig", {
    shareName = "DungeonBalanceBurstLink",
    isDynamicContent = true,
    widgets = {
      [1] = "WidgetShareBurstLinkResult"
    }
  }),
  [6] = ProtobufI("ShareConfig", {
    shareName = "ChristmasParty",
    widgets = {},
    logoColor = "white",
    playerBg = "black"
  }),
  [7] = ProtobufI("ShareConfig", {
    shareName = "ChristmasPartyInviteResult",
    widgets = {},
    logoColor = "white",
    playerBg = "black"
  }),
  [8] = ProtobufI("ShareConfig", {
    shareName = "CollectionsActor",
    isDynamicContent = true,
    widgets = {
      [1] = "WidgetShareCollectionsActor"
    },
    isHideLogoAndPlayer = true,
    logoColor = "white",
    playerBg = "black"
  }),
  [9] = ProtobufI("ShareConfig", {
    shareName = "CollectionsNovel",
    widgets = {},
    logoColor = "white",
    playerBg = "black"
  }),
  [10] = ProtobufI("ShareConfig", {
    shareName = "CoverJumpShareReward",
    isDynamicContent = true,
    widgets = {
      [1] = "WidgetShareCoverJumpShareReward"
    },
    isHideLogoAndPlayer = true
  }),
  [11] = ProtobufI("ShareConfig", {
    shareName = "CustomActorCultivationComplete",
    widgets = {},
    logoColor = "white"
  }),
  [12] = ProtobufI("ShareConfig", {
    shareName = "Default",
    widgets = {},
    logoColor = "black",
    logoX = 200,
    logoY = -70,
    playerBg = "white",
    playerX = -220,
    playerY = -115
  }),
  [13] = ProtobufI("ShareConfig", {
    shareName = "Dorm",
    widgets = {},
    logoColor = "white"
  }),
  [14] = ProtobufI("ShareConfig", {
    shareName = "EquipDetail",
    isDynamicContent = true,
    widgets = {
      [1] = "WidgetShareEquip"
    }
  }),
  [15] = ProtobufI("ShareConfig", {
    shareName = "GachaResult",
    isDynamicContent = true,
    widgets = {
      [1] = "WidgetShareGachaResult"
    },
    logoX = 200,
    logoY = -960,
    playerBg = "transparent",
    playerX = -220,
    playerY = -1000
  }),
  [16] = ProtobufI("ShareConfig", {
    shareName = "GameFlappy",
    widgets = {}
  }),
  [17] = ProtobufI("ShareConfig", {
    shareName = "ItemDetail/Medal",
    isDynamicContent = true,
    widgets = {
      [1] = "WidgetShareMedalDetail"
    }
  }),
  [18] = ProtobufI("ShareConfig", {
    shareName = "MaidCafeRecruitMent",
    isDynamicContent = true,
    widgets = {
      [1] = "WidgetShareMaidCafeRecruitMent"
    }
  }),
  [19] = ProtobufI("ShareConfig", {
    shareName = "NewActorGet",
    widgets = {},
    logoColor = "white",
    playerX = -220,
    playerY = -1025
  }),
  [20] = ProtobufI("ShareConfig", {
    shareName = "NewArmGet",
    isDynamicContent = true,
    widgets = {
      [1] = "WidgetShareArm"
    }
  }),
  [21] = ProtobufI("ShareConfig", {
    shareName = "RacePVP",
    isDynamicContent = true,
    widgets = {
      [1] = "WidgetShareRacePvp"
    },
    logoColor = "white",
    playerBg = "black"
  }),
  [22] = ProtobufI("ShareConfig", {
    shareName = "RoleNotepadDetail",
    widgets = {},
    logoColor = "white",
    playerBg = "black"
  }),
  [23] = ProtobufI("ShareConfig", {
    shareName = "TowerNewPrepare",
    isDynamicContent = true,
    widgets = {
      [1] = "WidgetShareTowerNewPrepare"
    },
    logoColor = "white",
    playerBg = "black"
  }),
  [24] = ProtobufI("ShareConfig", {
    shareName = "WelfarePostcard",
    widgets = {},
    playerBg = "black"
  }),
  [25] = ProtobufI("ShareConfig", {
    shareName = "WidgetMySpaceReal",
    isDynamicContent = true,
    widgets = {
      [1] = "WidgetShareMySpaceReal"
    }
  }),
  [26] = ProtobufI("ShareConfig", {
    shareName = "WlfHalfYearBack",
    isDynamicContent = true,
    widgets = {
      [1] = "WidgetShareWlfHalfYearBack"
    },
    isHideLogoAndPlayer = true
  }),
  [27] = ProtobufI("ShareConfig", {
    shareName = "City",
    widgets = {}
  })
}
local indexed = {
  ActorCultivationComplete = 1,
  ActorEquipCompare = 2,
  ActorMain = 3,
  ArmDetail = 4,
  ChristmasParty = 6,
  ChristmasPartyInviteResult = 7,
  City = 27,
  CollectionsActor = 8,
  CollectionsNovel = 9,
  CoverJumpShareReward = 10,
  CustomActorCultivationComplete = 11,
  Default = 12,
  Dorm = 13,
  DungeonBalanceBurstLink = 5,
  EquipDetail = 14,
  GachaResult = 15,
  GameFlappy = 16,
  ["ItemDetail/Medal"] = 17,
  MaidCafeRecruitMent = 18,
  NewActorGet = 19,
  NewArmGet = 20,
  RacePVP = 21,
  RoleNotepadDetail = 22,
  TowerNewPrepare = 23,
  WelfarePostcard = 24,
  WidgetMySpaceReal = 25,
  WlfHalfYearBack = 26
}
return {raw, indexed}
