-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/model/DivineDualDragonClgModel.lua

module("logic.extensions.divinedualdragonclg.model.DivineDualDragonClgModel", package.seeall)

local DivineDualDragonClgModel = class("DivineDualDragonClgModel", BaseModel)

function DivineDualDragonClgModel:ctor()
	return
end

function DivineDualDragonClgModel:onInit()
	self:onReset()
end

function DivineDualDragonClgModel:onReset()
	self._finalFmtMo = nil
	self._normalFmtMo = nil
	self._ultimateNormalFmtMo = nil
	self._ultimateFinalFmtMo = nil
	self._info = {}
	self._stageInfo = {}
end

function DivineDualDragonClgModel:saveInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._info[msg.activityId] = info
	self._stageInfo[msg.activityId] = {}

	if info.phaseInfos then
		for i, phaseInfo in ipairs(info.phaseInfos) do
			self._stageInfo[msg.activityId][phaseInfo.phaseId] = {}

			if phaseInfo.stages then
				for j, stageInfo in ipairs(phaseInfo.stages) do
					self._stageInfo[msg.activityId][phaseInfo.phaseId][stageInfo.stageId] = stageInfo
				end
			end
		end
	end
end

function DivineDualDragonClgModel:saveChallengeInfo(msg)
	self._stageInfo[msg.activityId][msg.phaseId] = self._stageInfo[msg.activityId][msg.phaseId] or {}

	local oldStageInfo = self._stageInfo[msg.activityId][msg.phaseId][msg.stageId]
	local stageInfo = {}

	stageInfo.stageId = msg.stageId
	stageInfo.pass = true
	stageInfo.score = oldStageInfo and (msg.stageScore < oldStageInfo.score and msg.stageScore or oldStageInfo.score) or msg.stageScore
	stageInfo.score = msg.stageScore
	stageInfo.usePetIds = msg.usePetIds
	self._stageInfo[msg.activityId][msg.phaseId][msg.stageId] = stageInfo
end

function DivineDualDragonClgModel:getStagePass(activityId, phaseId, stageId)
	if self._stageInfo[activityId][phaseId] and self._stageInfo[activityId][phaseId][stageId] then
		return self._stageInfo[activityId][phaseId][stageId].pass
	end

	return false
end

function DivineDualDragonClgModel:getStageScore(activityId, phaseId, stageId)
	if self._stageInfo[activityId][phaseId] and self._stageInfo[activityId][phaseId][stageId] then
		return self._stageInfo[activityId][phaseId][stageId].score
	end

	return 0
end

function DivineDualDragonClgModel:getNormalFmtMo()
	self._normalFmtMo = self._normalFmtMo or DivineDualDragonClgNormalFmtMo.New()

	return self._normalFmtMo
end

function DivineDualDragonClgModel:getFinalFmtMo()
	self._finalFmtMo = self._finalFmtMo or DivineDualDragonClgFinalFmtMo.New()

	return self._finalFmtMo
end

function DivineDualDragonClgModel:getUltimateTrialNormalFmtMo()
	self._ultimateNormalFmtMo = self._ultimateNormalFmtMo or UltimateTrialDualDragonNormalFmtMo.New()

	return self._ultimateNormalFmtMo
end

function DivineDualDragonClgModel:getUltimateTrialFinalFmtMo()
	self._ultimateFinalFmtMo = self._ultimateFinalFmtMo or UltimateTrialDualDragonFinalFmtMo.New()

	return self._ultimateFinalFmtMo
end

function DivineDualDragonClgModel:getFinalFightPet(activityId, phaseId)
	local pet = {}
	local activityCfg = DivineDualDragonClgConfig.instance:getActivityCfg(activityId)
	local phaseCfg = DivineDualDragonClgConfig.instance:getPhaseCfg(activityCfg.phasePlanId, phaseId)

	if self._stageInfo[activityId] and self._stageInfo[activityId][phaseId] then
		for stageId, stageInfo in pairs(self._stageInfo[activityId][phaseId]) do
			local stageCfg = DivineDualDragonClgConfig.instance:getStageCfg(phaseCfg.stagePlanId, stageId)

			if not stageCfg.finalStage then
				for m, id in pairs(stageInfo.usePetIds) do
					pet[id] = true
				end
			end
		end
	end

	return pet
end

function DivineDualDragonClgModel:getTotalScore(activityId)
	local totalScore = 0
	local isInit = false

	if self._stageInfo[activityId] then
		for phaseId, phaseInfo in pairs(self._stageInfo[activityId]) do
			for stageId, stageInfo in pairs(phaseInfo) do
				totalScore = totalScore + stageInfo.score or 0
			end
		end

		isInit = true
	end

	return totalScore, isInit
end

function DivineDualDragonClgModel:setSelectPhaseId(phaseId)
	self._tempPhaseId = phaseId
end

function DivineDualDragonClgModel:getSelectPhaseId()
	return self._tempPhaseId
end

DivineDualDragonClgModel.instance = DivineDualDragonClgModel.New()

return DivineDualDragonClgModel
