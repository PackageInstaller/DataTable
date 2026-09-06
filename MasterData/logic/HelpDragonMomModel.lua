-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/helpdragonmom/model/HelpDragonMomModel.lua

module("logic.extensions.helpdragonmom.model.HelpDragonMomModel", package.seeall)

local HelpDragonMomModel = class("HelpDragonMomModel", BaseModel)

function HelpDragonMomModel:ctor()
	return
end

function HelpDragonMomModel:onInit()
	self:onReset()
end

function HelpDragonMomModel:onReset()
	self._activityId = 160001
	self._playerProgress = 0
	self._playerReceiveIds = {}
	self._worldProgress = 0
	self._worldReceiveIds = {}
	self._pageIndex = 0
end

function HelpDragonMomModel:setPageIndex(index)
	self._pageIndex = index
end

function HelpDragonMomModel:getPageIndex()
	return self._pageIndex
end

function HelpDragonMomModel:onHelpDragonMomGetInfoRes(msg)
	self._playerProgress = msg.selfInfo.progress
	self._playerReceiveIds = GameUtil.pbToTable(msg.selfInfo.receiveIds) or {}
	self._worldProgress = msg.worldInfo.progress
	self._worldReceiveIds = GameUtil.pbToTable(msg.worldInfo.receiveIds) or {}
end

function HelpDragonMomModel:onHelpDragonMomChallengeRes(msg)
	self._playerProgress = msg.selfInfo.progress
	self._playerReceiveIds = GameUtil.pbToTable(msg.selfInfo.receiveIds) or {}
end

function HelpDragonMomModel:onHelpDragonMomSelfAwardRes(msg)
	self._playerProgress = msg.selfInfo.progress
	self._playerReceiveIds = GameUtil.pbToTable(msg.selfInfo.receiveIds) or {}
end

function HelpDragonMomModel:onHelpDragonMomWorldAwardRes(msg)
	self._worldProgress = msg.worldInfo.progress
	self._worldReceiveIds = GameUtil.pbToTable(msg.worldInfo.receiveIds) or {}
end

function HelpDragonMomModel:getActivityId()
	return self._activityId
end

function HelpDragonMomModel:getTaskActivityId()
	return 17042
end

function HelpDragonMomModel:getWorldRewardPlanId()
	local cfg = HelpDragonMomConfig.instance:getActivityCfg(self._activityId)

	return (cfg or nil) and (cfg.worldRewardPlanId or 0)
end

function HelpDragonMomModel:getPlayerRewardPlanId()
	local cfg = HelpDragonMomConfig.instance:getActivityCfg(self._activityId)

	return (cfg or nil) and (cfg.playerRewardPlanId or 0)
end

function HelpDragonMomModel:isWorldRewardCanGet(prizeId, needScore)
	local isScoreEnough = needScore <= self._worldProgress

	if isScoreEnough then
		local isGeted = self:isWorldRewardGeted(prizeId)

		return not isGeted
	else
		return false
	end
end

function HelpDragonMomModel:isWorldRewardGeted(prizeId)
	return TableUtil.isHad(self._worldReceiveIds, prizeId)
end

function HelpDragonMomModel:isAnyWorldRewardCanGet()
	local cfgs = HelpDragonMomConfig.instance:getRewardWorldCfgList(self:getWorldRewardPlanId())

	if cfgs then
		for i, v in ipairs(cfgs) do
			if self:isWorldRewardCanGet(v.id, v.progress) then
				return true
			end
		end

		return false
	else
		return false
	end
end

function HelpDragonMomModel:getWorldProgress()
	return self._worldProgress
end

function HelpDragonMomModel:isPlayerRewardCanGet(prizeId, needScore)
	local isScoreEnough = needScore <= self._playerProgress

	if isScoreEnough then
		local isGeted = self:isPlayerRewardGeted(prizeId)

		return not isGeted
	else
		return false
	end
end

function HelpDragonMomModel:isPlayerRewardGeted(prizeId)
	return TableUtil.isHad(self._playerReceiveIds, prizeId)
end

function HelpDragonMomModel:isAnyPlayerRewardCanGet()
	local cfgs = HelpDragonMomConfig.instance:getRewardPlayerCfgList(self:getPlayerRewardPlanId())

	if cfgs then
		for i, v in ipairs(cfgs) do
			if self:isPlayerRewardCanGet(v.id, v.progress) then
				return true
			end
		end

		return false
	else
		return false
	end
end

function HelpDragonMomModel:getPlayerProgress()
	return self._playerProgress
end

HelpDragonMomModel.instance = HelpDragonMomModel.New()

return HelpDragonMomModel
