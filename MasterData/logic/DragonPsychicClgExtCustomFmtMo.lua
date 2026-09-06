-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/model/DragonPsychicClgExtCustomFmtMo.lua

module("logic.extensions.dragonpsychicclg.model.DragonPsychicClgExtCustomFmtMo", package.seeall)

local DragonPsychicClgExtCustomFmtMo = class("DragonPsychicClgExtCustomFmtMo", ICustomFmtMo)

function DragonPsychicClgExtCustomFmtMo:onReset()
	DragonPsychicClgExtCustomFmtMo.super.onReset(self)
end

function DragonPsychicClgExtCustomFmtMo:updateCfg(activityId, stageId, teamId)
	self._activityId = activityId
	self._stageId = stageId
	self._teamId = teamId
	self._stageData = DragonPsychicClgConfig.instance:getDpcExtremeStageData(self._activityId, self._stageId, self._teamId)
	self._creepsMasterId = self._stageData.creepsMasterId
	self._masterData = DragonPsychicClgConfig.instance:getDpcMasterData(self._creepsMasterId)
	self._creepsCfg = DragonPsychicClgConfig.instance:getDpcCreepsCfg(self._creepsMasterId)

	local lockRaceIds = DragonPsychicClgController.instance:getLockRaceIdsOfExt(self._activityId)

	self._lockedRaceIdMap = {}

	for i, v in ipairs(lockRaceIds) do
		self._lockedRaceIdMap[v] = v
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
end

function DragonPsychicClgExtCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DragonPsychicClgExtCustomFmtMo:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, activityType, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DragonPsychicClgController.instance:sendPM_DPClgExtremeChallengeReq(self._activityId, simpleForm, self._stageId, self._teamId)
	end

	self:setFightHandler(handler, nil)
end

function DragonPsychicClgExtCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DragonPsychicClgExtCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DragonPsychicClgExtCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function DragonPsychicClgExtCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function DragonPsychicClgExtCustomFmtMo:checkPetIsForbit(petMo)
	return self:_isPetNotCanUp(petMo:getDefineId())
end

function DragonPsychicClgExtCustomFmtMo:showForbitPetAlert(petMo)
	if self:_isPetNotCanUp(petMo:getDefineId()) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function DragonPsychicClgExtCustomFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if DragonPsychicClgExtCustomFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
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

function DragonPsychicClgExtCustomFmtMo:_isPetNotCanUp(raceId)
	if raceId > 0 then
		return self._lockedRaceIdMap[raceId] ~= nil
	else
		return false
	end
end

return DragonPsychicClgExtCustomFmtMo
