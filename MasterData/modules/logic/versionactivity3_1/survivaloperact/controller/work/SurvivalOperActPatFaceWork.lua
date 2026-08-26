-- chunkname: @modules/logic/versionactivity3_1/survivaloperact/controller/work/SurvivalOperActPatFaceWork.lua

module("modules.logic.versionactivity3_1.survivaloperact.controller.work.SurvivalOperActPatFaceWork", package.seeall)

local SurvivalOperActPatFaceWork = class("SurvivalOperActPatFaceWork", Activity101SignPatFaceWork)

function SurvivalOperActPatFaceWork:checkCanPat()
	local actId = self:_actId()
	local isOpen = ActivityType101Model.instance:isOpen(actId)

	if not isOpen then
		return false
	end

	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SurvivalOperActPat)
	local hasPat = PlayerPrefsHelper.getNumber(key, 0)

	if hasPat ~= 0 then
		return false
	end

	local rewardGet = self:isType101RewardCouldGetAnyOne()

	if rewardGet then
		PlayerPrefsHelper.setNumber(key, 1)

		return false
	end

	PlayerPrefsHelper.setNumber(key, 1)

	return true
end

return SurvivalOperActPatFaceWork
