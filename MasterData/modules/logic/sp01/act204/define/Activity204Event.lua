-- chunkname: @modules/logic/sp01/act204/define/Activity204Event.lua

module("modules.logic.sp01.act204.define.Activity204Event", package.seeall)

local Activity204Event = _M

Activity204Event.UpdateInfo = 1
Activity204Event.FinishTask = 2
Activity204Event.LocalKeyChange = 3
Activity204Event.FinishGame = 4
Activity204Event.GetDailyCollection = 5
Activity204Event.SpBonusStageChange = 6
Activity204Event.PlayGame = 7
Activity204Event.GetOnceBonus = 8
Activity204Event.GetMilestoneReward = 9
Activity204Event.PlayTalk = 10
Activity204Event.UpdateTask = 11
Activity204Event.RefreshRed = 12

return Activity204Event
