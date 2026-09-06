-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/model/OriginAshlessDragonFmtMo.lua

module("logic.extensions.originashlessdragon.model.OriginAshlessDragonFmtMo", package.seeall)

local OriginAshlessDragonFmtMo = class("OriginAshlessDragonFmtMo", BaseCustomFmtMo)

function OriginAshlessDragonFmtMo:onReset()
	OriginAshlessDragonFmtMo.super.onReset(self)
end

function OriginAshlessDragonFmtMo:updateCfg(activityId, phaseId, stageId, investBudget)
	self._activityId = activityId
	self._phaseId = phaseId
	self._stageId = stageId
	self._investBudget = investBudget

	local stageData = OriginAshlessDragonConfig.instance:getStageData(self._activityId, self._phaseId, self._stageId)

	self._creepsMasterId = stageData.creepsMasterId
	self._subMo = OriginAshlessDragonController.instance:getSubMo(self._activityId)
	self._creepsTeamData = OriginAshlessDragonConfig.instance:getMonsterData(self._creepsMasterId)
	self._creepsCfg = OriginAshlessDragonConfig.instance:getCreepsDatas(self._creepsMasterId)
	self.topTitleStr = self._creepsTeamData.name
	self.validatorDescStr = self._creepsTeamData.missionDesc
	self.ruleDescStr = self._creepsTeamData.WinDesc

	self:setFormCondition(self._creepsTeamData.formCondition)

	local lockRaceIds = self._subMo:getLockRaceIdsInPhase(self._phaseId)

	self._lockedRaceIdMap = {}

	for i, v in ipairs(lockRaceIds) do
		self._lockedRaceIdMap[v] = true
	end

	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_First
	self.strShowRuleFlagKey = string.format("OriginAshlessDragonFmtMo_%s_%s_%s", self._activityId, self._phaseId, self._stageId)
	self.isPopRuleDesc = true
end

function OriginAshlessDragonFmtMo:getActivityId()
	return self._activityId
end

function OriginAshlessDragonFmtMo:getPhaseId()
	return self._phaseId
end

function OriginAshlessDragonFmtMo:getStageId()
	return self._stageId
end

function OriginAshlessDragonFmtMo:getInvestBudget()
	return self._investBudget
end

function OriginAshlessDragonFmtMo:initFightHandler()
	local function handler()
		BattleFacade.instance:registerResultHandler(function()
			BattleFacade.instance:registerResultHandler(nil, nil)

			local result = false
			local subMo = OriginAshlessDragonController.instance:getSubMo(self._activityId)
			local fightResultMsg = subMo:getFightResultMsg()

			if fightResultMsg and fightResultMsg.win then
				UIStateManager.instance:push(ViewName.OriginAshlessDragonResultSurePopView, self)

				result = true
			end

			return result
		end)
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginAshlessDragonController.instance:sendPM_OriginAshlessDragonChallengeReq(self._activityId, self._phaseId, self._stageId, simpleForm, self._investBudget)
	end

	self:setFightHandler(handler, nil)
end

function OriginAshlessDragonFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginAshlessDragonFmtMo:getFmtInfoConfig()
	return self._creepsTeamData
end

function OriginAshlessDragonFmtMo:checkPetIsForbit(petMo)
	return self:_isPetLock(petMo)
end

function OriginAshlessDragonFmtMo:showForbitPetAlert(petMo)
	if self:_isPetLock(petMo) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function OriginAshlessDragonFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if OriginAshlessDragonFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		local petMo = self:getPetMoById(petId)

		return not self:_isPetLock(petMo)
	else
		return false
	end
end

function OriginAshlessDragonFmtMo:_isPetLock(petMo)
	local raceId = petMo and petMo:getDefineId() or 0

	return self._lockedRaceIdMap[raceId]
end

function OriginAshlessDragonFmtMo:getExtendViewName()
	return ViewName.OriginAshlessDragonFmtExView
end

return OriginAshlessDragonFmtMo
