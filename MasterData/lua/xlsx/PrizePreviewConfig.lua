local raw = {
  [1] = ProtobufI("PrizePreviewConfig", {
    name = "GameFlappy",
    bgWidth = 1420,
    slotName = "WidgetTitlePrize3StateSlot",
    rewardsXlsx = "MiniGamesScoreReward"
  }),
  [2] = ProtobufI("PrizePreviewConfig", {
    name = "Tower",
    bgWidth = 1420,
    slotName = "WidgetPrize3StateSlot",
    showState = true,
    showProgress = true,
    rewardsXlsx = "TowerFloorReward",
    recordPath = "fci/tower/summary/",
    getRewardPath = "fci/tower/floor-reward/",
    rewardOrderReverse = true,
    showGet = true
  }),
  [3] = ProtobufI("PrizePreviewConfig", {
    name = "GameLottery",
    bgWidth = 1590,
    widgetName = "WidgetLotteryPrize",
    rewardsXlsx = "LotteryConfig",
    rewardOrderReverse = true,
    widgetControlSelf = true
  }),
  [4] = ProtobufI("PrizePreviewConfig", {
    name = "BurstLink",
    bgWidth = 1420,
    slotName = "WidgetTitlePrize3StateSlot",
    showProgress = true,
    rewardsPath = "fci/BurstLinkPvpInfo/"
  }),
  [5] = ProtobufI("PrizePreviewConfig", {
    name = "RacePVPGrade",
    bgWidth = 1420,
    widgetName = "WidgetRacePVPGradePrize",
    rewardOrderReverse = true,
    widgetControlSelf = true
  }),
  [6] = ProtobufI("PrizePreviewConfig", {
    name = "RacePVPScore",
    bgWidth = 1420,
    slotName = "WidgetPrize3StateSlot",
    showState = true,
    showProgress = true,
    rewardsXlsx = "RacePVPBattleScoreReward",
    recordPath = "fci/RacePVPBattleScoreReward/",
    getRewardPath = "fci/RacePVPBattleScoreReward/",
    rewardOrderReverse = true,
    showGet = true,
    canGetAll = true
  }),
  [7] = ProtobufI("PrizePreviewConfig", {
    name = "EventActivityStar",
    bgWidth = 1420,
    slotName = "WidgetStarPrize3StateSlot",
    showState = true,
    rewardsXlsx = "EventReward",
    recordPath = "fci/activity/star-reward/",
    getRewardPath = "fci/activity/star-reward/",
    showGet = true
  }),
  [8] = ProtobufI("PrizePreviewConfig", {
    name = "HotPotDining",
    bgWidth = 1420,
    slotName = "WidgetCookLevelSlot",
    showState = true,
    showProgress = true,
    rewardsXlsx = "RoleCookingInfo",
    recordPath = "fci/cooking-summary/"
  }),
  [9] = ProtobufI("PrizePreviewConfig", {
    name = "Couple",
    bgWidth = 1420,
    slotName = "WidgetPrize3StateSlot",
    showState = true,
    rewardsPath = "fci/couple/",
    recordPath = "fci/couple/",
    getRewardPath = "fci/couple/reward/",
    showGet = true
  }),
  [10] = ProtobufI("PrizePreviewConfig", {
    name = "DungeonGuildContribution",
    bgWidth = 1634,
    widgetName = "WidgetDungeonGuildPrize",
    showState = true,
    rewardsXlsx = "GuildDungeonContributionReward",
    recordPath = "fci/guild-dungeon/v2/contribution/reward/",
    getRewardPath = "fci/guild-dungeon/v2/contribution/reward/",
    rewardOrderReverse = true,
    showGet = true,
    canGetAll = true
  }),
  [11] = ProtobufI("PrizePreviewConfig", {
    name = "AsyncPvpNewGrade",
    bgWidth = 1420,
    widgetName = "WidgetAsyncPvpNewGradePrize",
    rewardOrderReverse = true,
    widgetControlSelf = true
  })
}
local indexed = {
  AsyncPvpNewGrade = 11,
  BurstLink = 4,
  Couple = 9,
  DungeonGuildContribution = 10,
  EventActivityStar = 7,
  GameFlappy = 1,
  GameLottery = 3,
  HotPotDining = 8,
  RacePVPGrade = 5,
  RacePVPScore = 6,
  Tower = 2
}
return {raw, indexed}
