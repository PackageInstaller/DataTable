-- chunkname: @modules/logic/achievement/controller/AchievementEvent.lua

module("modules.logic.achievement.controller.AchievementEvent", package.seeall)

local AchievementEvent = _M

AchievementEvent.UpdateAchievements = 1001
AchievementEvent.SelectViewUpdated = 2001
AchievementEvent.LevelViewUpdated = 3001
AchievementEvent.AchievementMainViewUpdate = 4001
AchievementEvent.OnSwitchCategory = 4002
AchievementEvent.OnFocusAchievementFinished = 4003
AchievementEvent.OnClickGroupFoldBtn = 4004
AchievementEvent.OnPlayGroupFadeAnim = 4005
AchievementEvent.OnSwitchViewType = 4006
AchievementEvent.OnGroupUpGrade = 6001
AchievementEvent.AchievementSaveSucc = 8001
AchievementEvent.UpdateAchievementState = 9001
AchievementEvent.LoginShowToast = GameUtil.getEventId()

return AchievementEvent
