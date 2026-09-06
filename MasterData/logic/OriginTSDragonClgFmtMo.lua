-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintsdragonclg/model/OriginTSDragonClgFmtMo.lua

module("logic.extensions.origintsdragonclg.model.OriginTSDragonClgFmtMo", package.seeall)

local OriginTSDragonClgFmtMo = class("OriginTSDragonClgFmtMo", BaseCustomFmtMo)

function OriginTSDragonClgFmtMo:updateCfg(activityId, phaseId, stageId)
	self._activityId = checknumber(activityId)
	self._phaseId = checknumber(phaseId)
	self._stageId = checknumber(stageId)
	self._bePointedToMap = OriginTSDragonClgController.instance:getCurPointerMap()
	self._pointedlist = checktable(self._bePointedToMap[stageId])
	self._banPetRaceIdMap = OriginTSDragonClgController.instance:getDiePetRaceIdMap(activityId)
	self._creepsMasterId = OriginTSDragonClgConfig.instance:getCreepMasterId(self._activityId, self._phaseId, self._stageId)
	self._masterData = OriginTSDragonClgConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = OriginTSDragonClgConfig.instance:getCreepCfg(self._creepsMasterId)

	if self._masterData then
		self.topTitleStr = self._masterData.name or ""
	end

	if self._masterData then
		self.ruleDescStr = self._masterData.ruleDesc or ""
	end

	self:setFormCondition((self._masterData or nil) and (self._masterData.formCondition or 0))
end

function OriginTSDragonClgFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()
		local puzzleId = OriginTSDragonClgModel.instance:getSelectPuzId(self._activityId, self._phaseId)

		if puzzleId == 0 then
			puzzleId = -1
		end

		OriginTSDragonClgController.instance:sendPM_OriginTSDragonChallengeReq(self._activityId, self._phaseId, self._stageId, simpleForm, puzzleId)
	end, nil)
end

function OriginTSDragonClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginTSDragonClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginTSDragonClgFmtMo:getExtendViewName()
	return ViewName.OriginTSDragonClgFmtView
end

function OriginTSDragonClgFmtMo:checkPetIsForbit(petMo)
	return self:_isPetLock(petMo)
end

function OriginTSDragonClgFmtMo:showForbitPetAlert(petMo)
	if self:_isPetLock(petMo) then
		FloatWordMgr.instance:show("该精灵为疲劳状态，无法上阵")
	end
end

function OriginTSDragonClgFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if OriginTSDragonClgFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		local petMo = self:getPetMoById(petId)

		return not self:_isPetLock(petMo)
	else
		return false
	end
end

function OriginTSDragonClgFmtMo:_isPetLock(petMo)
	if petMo then
		return self._banPetRaceIdMap[petMo.raceId]
	end

	return false
end

return OriginTSDragonClgFmtMo
