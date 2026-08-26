-- chunkname: @modules/logic/main/controller/work/Activity101SignSpRewardPatFaceWork.lua

module("modules.logic.main.controller.work.Activity101SignSpRewardPatFaceWork", package.seeall)

local Activity101SignSpRewardPatFaceWork = class("Activity101SignSpRewardPatFaceWork", Activity101SignPatFaceWork)

function Activity101SignSpRewardPatFaceWork:isType101RewardCouldGetAnyOne()
	local ok = Activity101SignSpRewardPatFaceWork.super.isType101RewardCouldGetAnyOne(self)

	if ok then
		return true
	end

	local actId = self:_actId()

	return ActivityType101Model.instance:isType101SpRewardCouldGetAnyOne(actId)
end

return Activity101SignSpRewardPatFaceWork
