-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/honourtower/controller/HonourTowerController.lua

module("logic.extensions.honourtower.controller.HonourTowerController", package.seeall)

local HonourTowerController = class("HonourTowerController", BaseController)

HonourTowerController.RegressPointPer = "RegressPointPer_"
HonourTowerController.ChallengePointPer = "ChallengePointPer_"

function HonourTowerController:ctor()
	return
end

function HonourTowerController:onInit()
	self:onReset()
end

function HonourTowerController:onReset()
	self._redpointList = {}
end

function HonourTowerController:openTrueOrFalseChallengeForm(periodId, challengeId, stageId)
	CustomFmtController.instance:showMissionView(HonourTowerModel.instance:getCustomTrueOrFalseFmtMo(periodId, challengeId, stageId))
end

function HonourTowerController:sendPM_HonorTowerRankViewReq(leaf)
	local challengeId = self:getChallengeIdByRankTabIdx(leaf)

	self._rankLeaf = leaf

	if challengeId > 0 then
		HonorTowerAgent.instance:sendPM_HonorTowerRankViewReq(challengeId)
	end
end

function HonourTowerController:handlePM_GloryTowerGetRankViewRes(msg)
	RankModel.instance:setRankData(msg, GameEnum.RankType.GloryTowerRank, self._rankLeaf)
	GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
end

function HonourTowerController:loadHonourTowerRedPoint()
	local periodId = HonourTowerModel.instance:getPeriodId()

	if periodId > 0 then
		RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_HONOUR_TOWER)
		HonorTowerAgent.instance:sendPM_HonorTowerInfoReq(periodId)
	end
end

function HonourTowerController:setType(params)
	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.HonourTowerChallenge, params)
end

function HonourTowerController:isStagePass(challengeId, stageId)
	local info = HonourTowerModel.instance:getChallengeInfo(challengeId)

	if not info then
		return false
	end

	return stageId <= info.curStageId
end

function HonourTowerController:isStageGainFirstPassPrize(challengeId, stageId)
	local info = HonourTowerModel.instance:getChallengeInfo(challengeId)

	if not info then
		return false
	end

	for i, v in ipairs(info.stages) do
		if v.stageId == stageId then
			return v.gainedFristPrize
		end
	end

	return false
end

function HonourTowerController:isChallengePass(challengeId)
	local info = HonourTowerModel.instance:getChallengeInfo(challengeId)

	if not info then
		return false
	end

	local cnt = #HonourTowerConfig.instance:getStageCfgs(challengeId)

	return cnt <= info.curStageId
end

function HonourTowerController:getChallengeIdByRankTabIdx(index)
	local periodId = HonourTowerModel.instance:getPeriodId()
	local cfgs = HonourTowerConfig.instance:getChallengeCfgs(periodId)

	if cfgs[index] then
		return cfgs[index].challengeId
	end

	return 0
end

function HonourTowerController:calRedPoint()
	local isActivated = false

	self._redpointList = {}
	self._regressPoint = false

	local periodId = HonourTowerModel.instance:getPeriodId()

	if periodId > 0 then
		local regressIds = HonourTowerModel.instance:getRegressChallengeIds()
		local challengeNum = HonourTowerConfig.instance:getRecallChallengeNum(periodId)

		if challengeNum > #regressIds then
			local key = HonourTowerController.RegressPointPer .. periodId

			self._regressPoint = GameUtil.getUserData(key)

			if self._regressPoint == nil then
				self._regressPoint = true
			end

			if self._regressPoint then
				local regressIds = HonourTowerConfig.instance:getRegressChallengeIds(periodId)

				isActivated = #regressIds > 0
			end
		end

		local cfgs = HonourTowerConfig.instance:getChallengeCfgs(periodId)

		for i, v in ipairs(cfgs) do
			local isInTime = GameUtil.checkIsInTimePeriod(v.startTime, v.endTime)

			if isInTime then
				local key = string.format("%s%s%s", HonourTowerController.ChallengePointPer, v.periodId, v.challengeId)
				local res = GameUtil.getUserData(key)

				if res == nil then
					self._redpointList[v.periodId] = self._redpointList[v.periodId] or {}
					self._redpointList[v.periodId][v.challengeId] = true
					isActivated = true
				end
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_HonourTower_XR, isActivated)
end

function HonourTowerController:getRedpoint(periodId, challengeId, isRegress)
	if isRegress then
		return self._regressPoint
	end

	if not self._redpointList[periodId] then
		return false
	end

	return self._redpointList[periodId][challengeId]
end

function HonourTowerController:onClickTabCell(periodId, challengeId)
	local key = string.format("%s%s%s", HonourTowerController.ChallengePointPer, periodId, challengeId)

	GameUtil.saveUserData(key, false)
	self:calRedPoint()
end

function HonourTowerController:onClickRegressCell(periodId)
	local key = HonourTowerController.RegressPointPer .. periodId

	GameUtil.saveUserData(key, false)
	self:calRedPoint()
end

function HonourTowerController:sendPM_HonorTowerChallengeReq(periodId, challengeId, stageId, form)
	self._challengePeriodId = periodId
	self._challengeChallengeId = challengeId
	self._challengeStageId = stageId
	self._form = form

	HonorTowerAgent.instance:sendPM_HonorTowerChallengeReq(periodId, challengeId, stageId, form)
end

function HonourTowerController:notifyHonorTowerChallengeFinishRes(msg)
	local changeSetId = msg.changeSetId

	HonourTowerController.instance:setType({
		isWin = msg.isWin,
		periodId = self._challengePeriodId,
		challengeId = self._challengeChallengeId,
		stageId = self._challengeStageId
	})
	MaterialController.instance:saveChangeSetToTemp(changeSetId)
	BattleSettlementModel.instance:setChangeSetId(changeSetId)

	if msg.isWin then
		HonourTowerModel.instance:setChallengeSuccessed(self._challengeChallengeId, self._challengeStageId, msg.round)
	end

	UIStateManager.instance:popByName(ViewName.BattleSettlementSuccess)
end

function HonourTowerController:onClickNextLevel()
	BattleFacade.instance:startContinuousBattle()
	self:sendPM_HonorTowerChallengeReq(self._challengePeriodId, self._challengeChallengeId, self._challengeStageId + 1, self._form)
end

HonourTowerController.instance = HonourTowerController.New()

return HonourTowerController
