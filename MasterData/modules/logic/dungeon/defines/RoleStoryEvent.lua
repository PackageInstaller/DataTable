-- chunkname: @modules/logic/dungeon/defines/RoleStoryEvent.lua

module("modules.logic.dungeon.defines.RoleStoryEvent", package.seeall)

local RoleStoryEvent = _M

RoleStoryEvent.ActStoryChange = 1000
RoleStoryEvent.ScoreUpdate = 1010
RoleStoryEvent.UpdateInfo = 1020
RoleStoryEvent.GetScoreBonus = 1030
RoleStoryEvent.ExchangeTick = 1040
RoleStoryEvent.GetChallengeBonus = 1050
RoleStoryEvent.ResidentStoryChange = 1060
RoleStoryEvent.OnClickRoleStoryReward = 1070
RoleStoryEvent.ChangeMainViewShow = 1080
RoleStoryEvent.PowerChange = 1090
RoleStoryEvent.WeekTaskChange = 1100
RoleStoryEvent.StoryNewChange = 1110
RoleStoryEvent.ChangeSelectedHero = 1200
RoleStoryEvent.ClickRightHero = 1201
RoleStoryEvent.DispatchSuccess = 1202
RoleStoryEvent.DispatchReset = 1203
RoleStoryEvent.DispatchFinish = 1204
RoleStoryEvent.ClickReviewItem = 1205
RoleStoryEvent.StoryDispatchUnlock = 1206
RoleStoryEvent.NormalDispatchRefresh = 1207
RoleStoryEvent.StoryTabChange = 1208
RoleStoryEvent.UnlockStory = 1209

return RoleStoryEvent
