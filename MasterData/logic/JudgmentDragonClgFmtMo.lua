-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/judgmentdragonclg/model/JudgmentDragonClgFmtMo.lua

module("logic.extensions.judgmentdragonclg.model.JudgmentDragonClgFmtMo", package.seeall)

local JudgmentDragonClgFmtMo = class("JudgmentDragonClgFmtMo", BaseCustomFmtMo)

function JudgmentDragonClgFmtMo:updateCfg(activityId, phaseId, stageId)
	self._activityId = activityId
	self._phaseId = phaseId
	self._stageId = stageId
	self._clgMo = JudgmentDragonClgController.instance:getClgMo(self._activityId)

	local stageData = JudgmentDragonClgConfig.instance:getStageData(activityId, phaseId, stageId)

	self._creepsMasterId = stageData.creepsMasterId

	local positionPlanId = stageData.positionPlanId
	local positionCfg = JudgmentDragonClgConfig.instance:getPositionCfg(positionPlanId)

	self._masterData = JudgmentDragonClgConfig.instance:getMonsterData(self._creepsMasterId)
	self._creepsCfg = JudgmentDragonClgConfig.instance:getCreepsCfg(self._creepsMasterId)

	local lockRaceIds = self._clgMo:getLockRaceIdsInPhase(phaseId)

	self._lockedRaceIdMap = {}

	for i, v in ipairs(lockRaceIds) do
		self._lockedRaceIdMap[v] = v
	end

	if positionCfg then
		for _, data in pairs(positionCfg) do
			self:setFixedEffect(data.posId, string.format("%s.prefab", data.effectPath))
		end
	end

	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function JudgmentDragonClgFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		JudgmentDragonClgController.instance:sendPM_JudgmentDragonClgFightReq(self._activityId, self._phaseId, self._stageId, simpleForm)
	end, nil)
end

function JudgmentDragonClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function JudgmentDragonClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function JudgmentDragonClgFmtMo:checkPetIsForbit(petMo)
	return self:_isPetNotCanUp(petMo:getDefineId())
end

function JudgmentDragonClgFmtMo:showForbitPetAlert(petMo)
	if self:_isPetNotCanUp(petMo:getDefineId()) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function JudgmentDragonClgFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if JudgmentDragonClgFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		if petId > 0 then
			local petMo = self:getPetMoById(petId)

			return not self:_isPetNotCanUp(petMo:getDefineId())
		else
			return true
		end
	else
		return false
	end
end

function JudgmentDragonClgFmtMo:_isPetNotCanUp(raceId)
	if raceId > 0 then
		return self._lockedRaceIdMap[raceId] ~= nil
	else
		return false
	end
end

return JudgmentDragonClgFmtMo
