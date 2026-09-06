-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindragonnoah/controller/OriginDragonNoahController.lua

module("logic.extensions.origindragonnoah.controller.OriginDragonNoahController", package.seeall)

local OriginDragonNoahController = class("OriginDragonNoahController", BaseController)

OriginDragonNoahController.BuffIdx = {
	aoJiu = 2,
	noah = 1
}

function OriginDragonNoahController:ctor()
	self._activityId = 0
end

function OriginDragonNoahController:onInit()
	self:onReset()
end

function OriginDragonNoahController:onReset()
	self._lastSelectStageId = 1
	self._preNoahScore = nil
	self._preAoJiuScore = nil
end

function OriginDragonNoahController:setCurActivityId(activityId)
	self._activityId = activityId
end

function OriginDragonNoahController:getCurActivityId()
	return self._activityId
end

function OriginDragonNoahController:setLastStageId(stageId)
	self._lastSelectStageId = stageId
end

function OriginDragonNoahController:getLastStageId()
	return self._lastSelectStageId
end

function OriginDragonNoahController:setRolePreScores(noahScore, aoJiuScore)
	self._preNoahScore = noahScore
	self._preAoJiuScore = aoJiuScore
end

function OriginDragonNoahController:setScore(score, roleType)
	if roleType == OriginDragonNoahController.BuffIdx.noah then
		self._preNoahScore = score
	else
		self._preAoJiuScore = score
	end
end

function OriginDragonNoahController:getRolePreScores()
	return self._preNoahScore, self._preAoJiuScore
end

function OriginDragonNoahController:sendPM_OriginDragonNoahClgInfoReq(activityId)
	OriginDragonNoahAgent.instance:sendPM_OriginDragonNoahClgInfoReq(activityId)
end

function OriginDragonNoahController:handlePM_OriginDragonNoahClgInfoRes(msg)
	OriginDragonNoahModel.instance:handlePM_OriginDragonNoahClgInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginDragonNoahClgInfoRes)
end

function OriginDragonNoahController:sendPM_OriginDragonNoahClgResetReq(activityId, stageId)
	OriginDragonNoahAgent.instance:sendPM_OriginDragonNoahClgResetReq(activityId, stageId)
end

function OriginDragonNoahController:handlePM_OriginDragonNoahClgResetRes(msg)
	OriginDragonNoahModel.instance:handlePM_OriginDragonNoahClgResetRes(msg)

	local noahScore, aoJiuScore = OriginDragonNoahModel.instance:getNoahAoJiuTotalScore(msg.activityId)

	self:setScore(aoJiuScore, OriginDragonNoahController.BuffIdx.aoJiu)
	self:setScore(noahScore, OriginDragonNoahController.BuffIdx.noah)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginDragonNoahClgResetRes)
end

function OriginDragonNoahController:sendPM_OriginDragonNoahClgChallengeReq(activityId, stageId, form)
	OriginDragonNoahAgent.instance:sendPM_OriginDragonNoahClgChallengeReq(activityId, stageId, form)
end

function OriginDragonNoahController:handlePM_Notify_OriginDragonNoahClgChallengeRes(msg)
	if msg.win then
		local noahScore, aoJiuScore = OriginDragonNoahModel.instance:getNoahAoJiuTotalScore(msg.activityId)

		self:setScore(aoJiuScore, OriginDragonNoahController.BuffIdx.aoJiu)
		self:setScore(noahScore, OriginDragonNoahController.BuffIdx.noah)
		OriginDragonNoahModel.instance:handlePM_OriginFightNotifyBattleRes(msg)
	else
		self:setScore(nil, OriginDragonNoahController.BuffIdx.aoJiu)
		self:setScore(nil, OriginDragonNoahController.BuffIdx.noah)
	end

	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEnd, self, msg))
end

function OriginDragonNoahController:_onResFightEnd(msg)
	if msg.win then
		local pb = GameUtil.pbToTable(msg)

		UIStateManager.instance:push(ViewName.OriginDragonNoahFightEndView, pb.activityId, pb.stageInfo, pb.buffSignCount)
	else
		UIStateManager.instance:open(ViewName.BattleSettlementFail)
	end

	return true
end

function OriginDragonNoahController:enterBattleClg(activityId, stageId)
	local customFmtMo = OriginDragonNoahModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function OriginDragonNoahController:getLeftScore(activityId)
	local actCfg = OriginDragonNoahConfig.instance:getActCfg(activityId)
	local stageInfoMap = OriginDragonNoahModel.instance:getStageInfoMap(activityId)
	local passScore = actCfg.passScore
	local curTotalScore = 0

	for k, stageInfo in pairs(stageInfoMap) do
		for _, score in ipairs(stageInfo.scores) do
			curTotalScore = curTotalScore + score
		end
	end

	return (math.abs(passScore - curTotalScore))
end

function OriginDragonNoahController:getBuffsNum(activityId, stageId)
	local noahBuffNum = 0
	local aoJiuBuffNum = 0
	local noahScore = 0
	local aoJiuScore = 0
	local stageInfoMap = OriginDragonNoahModel.instance:getStageInfoMap(activityId)
	local stageInfo = stageInfoMap[stageId]

	if stageInfo then
		noahScore = stageInfo.scores[OriginDragonNoahController.BuffIdx.noah]
		aoJiuScore = stageInfo.scores[OriginDragonNoahController.BuffIdx.aoJiu]
	end

	local buffNoahCfgs = OriginDragonNoahConfig.instance:getBuffSignSortList(activityId, OriginDragonNoahController.BuffIdx.noah)
	local buffAoJiuCfgs = OriginDragonNoahConfig.instance:getBuffSignSortList(activityId, OriginDragonNoahController.BuffIdx.aoJiu)

	for i, cfg in ipairs(buffNoahCfgs) do
		if noahScore == cfg.score then
			noahBuffNum = cfg.count
		end
	end

	for i, cfg in ipairs(buffAoJiuCfgs) do
		if aoJiuScore == cfg.score then
			aoJiuBuffNum = cfg.count
		end
	end

	return noahBuffNum, aoJiuBuffNum
end

OriginDragonNoahController.instance = OriginDragonNoahController.New()

return OriginDragonNoahController
