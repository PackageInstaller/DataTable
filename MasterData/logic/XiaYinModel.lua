-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/model/XiaYinModel.lua

module("logic.extensions.xiayin.model.XiaYinModel", package.seeall)

local XiaYinModel = class("XiaYinModel", BaseModel)

function XiaYinModel:onInit()
	self:onReset()
end

function XiaYinModel:onReset()
	self._agentDic = {}
end

function XiaYinModel:getAgentInfo(activityId)
	if not self._agentDic[activityId] then
		self._agentDic[activityId] = {}

		self:_initAgent(self._agentDic[activityId])
	end

	return self._agentDic[activityId]
end

function XiaYinModel:_initAgent(info)
	info.activityId = 0
	info.passedTierId = 0
	info.passedStageIds = {}
	info.gainedPrizeIds = {}
	info.win = false
	info.customFmtMo = nil
end

function XiaYinModel:getCustomFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info.customFmtMo == nil then
		info.customFmtMo = XiaYinCustomFmtMo.New()
	end

	return info.customFmtMo
end

function XiaYinModel:onXiaYinGetInfoRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.activityId = msg.activityId
	info.passedTierId = msg.passedTierId
	info.passedStageIds = GameUtil.pbToTable(msg.passedStageIds) or {}
	info.gainedPrizeIds = GameUtil.pbToTable(msg.gainedPrizeIds) or {}
	info.signInBuffLv = msg.signInBuffLv
	info.hasSignInToday = msg.hasSignInToday
end

function XiaYinModel:onXiaYinChallengeRes(msg)
	return
end

function XiaYinModel:onXiaYinGainProgressPrizeRes(msg, activityId, prizeId)
	if prizeId and prizeId > 0 then
		local info = self:getAgentInfo(activityId)

		if not TableUtil.isHad(info.gainedPrizeIds, prizeId) then
			table.insert(info.gainedPrizeIds, prizeId)
		end
	end
end

function XiaYinModel:onNotifyXiaYinChallengeRes(msg, activityId, tierId, stageId)
	local info = self:getAgentInfo(activityId)

	info.win = msg.win

	if info.win and activityId and tierId and stageId then
		local cfg = XiaYinConfig.instance:getTierCfg(activityId, tierId)
		local maxNum = #cfg.stages
		local curNum = #info.passedStageIds + 1

		if maxNum <= curNum then
			info.passedTierId = info.passedTierId + 1

			table.clear(info.passedStageIds)
		elseif not TableUtil.isHad(info.passedStageIds, stageId) then
			table.insert(info.passedStageIds, stageId)
		end
	end
end

function XiaYinModel:getActivityId()
	if self._activityId then
		return self._activityId
	end

	self._activityId = checknumber(XiaYinConfig.instance:getCommonValue("ACTIVITY_ID"))

	return self._activityId
end

function XiaYinModel:getActivityType()
	return GameEnum.ActivityType.XiaYin
end

function XiaYinModel:getRewardProgress(activityId)
	local info = self:getAgentInfo(activityId)
	local passTier = info.passedTierId
	local progress = 0

	for tierId = 1, passTier do
		local cfg = XiaYinConfig.instance:getTierCfg(activityId, tierId)

		progress = progress + #cfg.stages
	end

	progress = progress + #info.passedStageIds

	return progress
end

function XiaYinModel:isPlayerRewardGeted(activityId, prizeId)
	local info = self:getAgentInfo(activityId)

	return TableUtil.isHad(info.gainedPrizeIds, prizeId)
end

function XiaYinModel:isPlayerRewardCanGet(activityId, prizeId, progress)
	local isScoreEnough = progress <= self:getRewardProgress(activityId)

	return isScoreEnough and not self:isPlayerRewardGeted(activityId, prizeId)
end

function XiaYinModel:isAllStagePass(activityId)
	local maxTiers = self:getMaxTier(activityId)
	local info = self:getAgentInfo(activityId)

	return maxTiers <= info.passedTierId
end

function XiaYinModel:isTierPass(activityId, tierId)
	local info = self:getAgentInfo(activityId)

	return tierId <= info.passedTierId
end

function XiaYinModel:isTierLock(activityId, tierId)
	local info = self:getAgentInfo(activityId)

	return tierId > info.passedTierId + 1
end

function XiaYinModel:isStagePass(activityId, tierId, stageId)
	local info = self:getAgentInfo(activityId)
	local passTier = info.passedTierId

	if tierId <= passTier then
		return true
	elseif tierId == passTier + 1 then
		return TableUtil.isHad(info.passedStageIds, stageId)
	else
		return false
	end
end

function XiaYinModel:getMaxTier(activityId)
	local cfgs = XiaYinConfig.instance:getTierCfgList(activityId)

	return #cfgs
end

function XiaYinModel:getCurTier(activityId)
	local info = self:getAgentInfo(activityId)
	local passTier = info.passedTierId
	local maxTiers = self:getMaxTier(activityId)

	return (Mathf.Clamp(passTier + 1, 1, maxTiers))
end

function XiaYinModel:isWinBattle(activityId)
	local info = self:getAgentInfo(activityId)

	return info.win
end

function XiaYinModel:upgradeBuffRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	if info then
		info.signInBuffLv = msg.signInBuffLv
		info.hasSignInToday = true
	end
end

function XiaYinModel:setJumpViews(mainViewName, levelViewName, resultViewName)
	self._mainViewName, self._levelViewName, self._resultViewName = mainViewName, levelViewName, resultViewName
end

function XiaYinModel:getJumpMainViewName()
	return self._mainViewName
end

function XiaYinModel:getJumpLevelViewName()
	return self._levelViewName
end

function XiaYinModel:getJumpResultViewName()
	return self._resultViewName
end

XiaYinModel.instance = XiaYinModel.New()

return XiaYinModel
