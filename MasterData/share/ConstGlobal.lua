local System = require("System.System")
local M = {}
M.ResourceTypes = System.NewEnum({
  DiamondCharge = 1,
  Diamond = 2,
  Gold = 3,
  Energy = 4
})
M.ResourceTidConstant = System.NewEnum({
  [M.ResourceTypes.DiamondCharge] = "DiamondChargeItemTid",
  [M.ResourceTypes.Diamond] = "DiamondItemTid",
  [M.ResourceTypes.Gold] = "GoldItemTid",
  [M.ResourceTypes.Energy] = "EnergyItemTid"
})
M.DefaultBagPageBoxLimit = 9999999
M.ResourceLimitConstant = System.NewEnum({
  [M.ResourceTypes.Energy] = "Energy_Max"
})
M.ActivityTimeType = {
  Permanent = "Permanent",
  FixedTime = "FixedTime",
  Duration = "Duration",
  DurationHourAfterTrigger = "DurationHourAfterTrigger",
  TaskDrivenEnd = "TaskDrivenEnd"
}
M.ActivityType = {
  SevenDayLogin = "SevenDayLoginActivity",
  TaskList = "TaskListActivity",
  DoubleOutput = "DoubleOutputActivity",
  AwakerTrial = "AwakerTrialActivity",
  Subplot = "SubplotActivity",
  DoubleExp = "DoubleExperienceActivity",
  MagicStory = "MagicStoryActivity",
  SpecialTaskList = "SpecialTaskList",
  Wangda = "WandaActivity",
  ConfessionEventDiscount = "ConfessionEventDiscountActivity",
  HomologyDouble = "HomologyDoubleActivity",
  DailyChallengeExp = "DailyChallengeExpActivity",
  FiveDaySignActivity = "FiveDaySignActivity",
  SignReceiveWeaponActivity = "SignReceiveWeaponActivity",
  SignReceiveAwakerActivity = "SignReceiveAwakerActivity",
  WorldBossActivity = "WorldBossActivity"
}
M.ActivityState = {
  NotOpen = "NotOpen",
  Running = "Running",
  End = "End"
}
M.CommonState = {
  Ready = 1,
  Running = 2,
  Confirm = 8,
  GainPrize = 9,
  Finish = 10
}
M.ItemAttrIndex = {Main = 1, Sub = 2}
M.PvpSettleRewardType = {Normail = 1, BattleStyle = 2}
M.PvpRankRewardType = {
  BattleRst = 1,
  SeasonBonus = 2,
  StreakBonus = 3,
  FirstWin = 4
}
M.BPPrivilege = {
  Ordinary = 0,
  Advanced = 1,
  Core = 2
}
M.GearTriggerType = {
  Not = 0,
  Client = 1,
  Move = 2
}
M.AwakerType = {Origin = 1, Normal = 0}
return M
