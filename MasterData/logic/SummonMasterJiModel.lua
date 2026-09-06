-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/model/SummonMasterJiModel.lua

module("logic.extensions.summonmasterji.model.SummonMasterJiModel", package.seeall)

local SummonMasterJiModel = class("SummonMasterJiModel", BaseModel)

function SummonMasterJiModel:onInit()
	self:onReset()
end

function SummonMasterJiModel:onReset()
	self._agentDic = {}
end

function SummonMasterJiModel:getAgentInfo(activityId)
	if not self._agentDic[activityId] then
		self._agentDic[activityId] = {}

		self:_initAgent(self._agentDic[activityId])
	end

	return self._agentDic[activityId]
end

function SummonMasterJiModel:_initAgent(info)
	info.activityId = 0
	info.extremeStageId2Score = {}
	info.dailyHasResetTimes = 0
	info.passedNormalStageId = 0
	info.gainNormalPrize = false
	info.gainExtremePrize = false
	info.activityLoginDays = 0
	info.localData = {}
	info.localData.scoreSelectPlan = {
		1,
		1,
		1
	}
end

function SummonMasterJiModel:getNormalFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info.normalFmtMo == nil then
		info.normalFmtMo = SummonMasterJiNormalFmtMo.New()
	end

	return info.normalFmtMo
end

function SummonMasterJiModel:getExtremeFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info.extremeFmtMo == nil then
		info.extremeFmtMo = SummonMasterJiExtremeFmtMo.New()
	end

	return info.extremeFmtMo
end

function SummonMasterJiModel:onSummonMasterJiGetInfoRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.activityId = msg.activityId
	info.extremeStageId2Score = GameUtil.pbToTable(msg.extremeStageId2Score) or {}
	info.dailyHasResetTimes = msg.dailyHasResetTimes
	info.passedNormalStageId = msg.passedNormalStageId
	info.gainNormalPrize = msg.gainNormalPrize
	info.activityLoginDays = msg.activityLoginDays
	info.normalFmtMo = nil
	info.extremeFmtMo = nil
end

function SummonMasterJiModel:onSummonMasterJiChallengeExtremeRes(msg)
	return
end

function SummonMasterJiModel:onSummonMasterJiResetExtremeRes(msg, activityId)
	local info = self:getAgentInfo(activityId)

	for i, v in ipairs(info.extremeStageId2Score) do
		v.right = 0
	end

	info.dailyHasResetTimes = msg.dailyHasResetTimes
end

function SummonMasterJiModel:onSummonMasterJiChallengeNormalRes(msg)
	return
end

function SummonMasterJiModel:onSummonMasterJiOneKeyPassNormalRes(msg, activityId)
	local info = self:getAgentInfo(activityId)

	info.gainNormalPrize = true

	local cfgs = SummonMasterJiConfig.instance:getNormalStageList(activityId)

	info.passedNormalStageId = cfgs[#cfgs].stageId
end

function SummonMasterJiModel:onNotify_SummonMasterJiChallengeExtremeRes(msg, activityId, stageId)
	if msg.updateMax then
		local info = self:getAgentInfo(activityId)

		for i, v in ipairs(info.extremeStageId2Score) do
			if v.left == stageId then
				v.right = msg.score
			end
		end
	end
end

function SummonMasterJiModel:onNotify_SummonMasterJiChallengeNormalRes(msg, activityId, stageId)
	if msg.win then
		local info = self:getAgentInfo(activityId)

		if stageId > info.passedNormalStageId then
			info.passedNormalStageId = stageId

			local cfgs = SummonMasterJiConfig.instance:getNormalStageList(activityId)

			if cfgs[#cfgs].stageId == stageId then
				info.gainNormalPrize = true
			end
		end
	end
end

function SummonMasterJiModel:getActivityId()
	if self._activityId then
		return self._activityId
	end

	self._activityId = checknumber(SummonMasterJiConfig.instance:getCommonValue("ACTIVITY_ID"))

	return self._activityId
end

function SummonMasterJiModel:getActivityType()
	return GameEnum.ActivityType.SummonMasterJi
end

function SummonMasterJiModel:isPassNormalChallenge(activityId)
	local info = self:getAgentInfo(activityId)

	if info.gainNormalPrize then
		return true
	end

	local stageCfgs = SummonMasterJiConfig.instance:getNormalStageList(activityId)

	return info.passedNormalStageId >= #stageCfgs
end

function SummonMasterJiModel:isPassExtremeChallenge(activityId)
	local info = self:getAgentInfo(activityId)
	local curNum = 0
	local isPassAllStage = true

	for i, v in ipairs(info.extremeStageId2Score) do
		curNum = curNum + v.right
		isPassAllStage = isPassAllStage and v.right > 0
	end

	local cfg = SummonMasterJiConfig.instance:getActivityCfg(activityId)
	local isScoreEnough = curNum >= cfg.extremePassScore

	return isScoreEnough and isPassAllStage
end

function SummonMasterJiModel:getDailyHasResetTimes(activityId)
	local info = self:getAgentInfo(activityId)

	return info.dailyHasResetTimes
end

function SummonMasterJiModel:getExtremeTotalScore(activityId)
	local info = self:getAgentInfo(activityId)
	local totalScore = 0

	for i, v in ipairs(info.extremeStageId2Score) do
		totalScore = totalScore + v.right
	end

	return totalScore
end

function SummonMasterJiModel:getExtremeScoreByStageId(activityId, stageId)
	local info = self:getAgentInfo(activityId)

	for i, v in ipairs(info.extremeStageId2Score) do
		if v.left == stageId then
			return v.right
		end
	end

	return 0
end

function SummonMasterJiModel:getNormalCurProgress(activityId)
	local info = self:getAgentInfo(activityId)

	return info.passedNormalStageId
end

function SummonMasterJiModel:saveScoreSelectPlan(activityId, index1, index2, index3)
	local info = self:getAgentInfo(activityId)

	info.localData.scoreSelectPlan[1] = index1 or 1
	info.localData.scoreSelectPlan[2] = index2 or 1
	info.localData.scoreSelectPlan[3] = index3 or 1
end

function SummonMasterJiModel:getScoreSelectPlan(activityId)
	local info = self:getAgentInfo(activityId)

	return info.localData.scoreSelectPlan
end

function SummonMasterJiModel:getActivityLoginDays(activityId)
	local info = self:getAgentInfo(activityId)

	return info.activityLoginDays
end

SummonMasterJiModel.instance = SummonMasterJiModel.New()

return SummonMasterJiModel
