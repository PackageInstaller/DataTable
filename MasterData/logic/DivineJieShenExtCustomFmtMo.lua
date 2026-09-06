-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/model/DivineJieShenExtCustomFmtMo.lua

module("logic.extensions.divinejieshen.model.DivineJieShenExtCustomFmtMo", package.seeall)

local DivineJieShenExtCustomFmtMo = class("DivineJieShenExtCustomFmtMo", ICustomFmtMo)

function DivineJieShenExtCustomFmtMo:onReset()
	DivineJieShenExtCustomFmtMo.super.onReset(self)
end

function DivineJieShenExtCustomFmtMo:updateCfg(activityId, towerId, stageId, teamId)
	self._activityId = activityId
	self._towerId = towerId
	self._stageId = stageId
	self._teamId = teamId

	local stageData = DivineJieShenConfig.instance:getExtStageData(self._activityId, self._towerId, self._stageId)

	self._creepsMasterId = teamId == GameEnum.BattleTeam.Left and stageData.creepsMasterIdLeft or stageData.creepsMasterIdRight
	self._divineJieShenMo = DivineJieShenModel.instance:getDivineJieShenMo(self._activityId)
	self._masterData = DivineJieShenConfig.instance:getClgMonsterData(self._creepsMasterId)
	self._creepsCfg = DivineJieShenConfig.instance:getClgCreepsCfg(self._creepsMasterId)

	local lockRaceIds = self._divineJieShenMo:getLocakRaceIdsInStageInExt(self._towerId, self._stageId)

	self._lockedRaceIdMap = {}

	for i, v in ipairs(lockRaceIds) do
		self._lockedRaceIdMap[v] = v
	end
end

function DivineJieShenExtCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivineJieShenExtCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineJieShenController.instance:sendPM_DivineJieShenClgExtremeChallengeReq(self._activityId, self._towerId, self._stageId, (self._teamId == GameEnum.BattleTeam.Left or nil) and true, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineJieShenExtCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineJieShenExtCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineJieShenExtCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function DivineJieShenExtCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function DivineJieShenExtCustomFmtMo:checkPetIsForbit(petMo)
	return self:_isPetNotCanUp(petMo:getDefineId())
end

function DivineJieShenExtCustomFmtMo:showForbitPetAlert(petMo)
	if self:_isPetNotCanUp(petMo:getDefineId()) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function DivineJieShenExtCustomFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if DivineJieShenExtCustomFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
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

function DivineJieShenExtCustomFmtMo:_isPetNotCanUp(raceId)
	if raceId > 0 then
		return self._lockedRaceIdMap[raceId] ~= nil
	else
		return false
	end
end

return DivineJieShenExtCustomFmtMo
