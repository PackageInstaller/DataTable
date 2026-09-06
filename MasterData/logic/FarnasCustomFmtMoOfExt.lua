-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/model/FarnasCustomFmtMoOfExt.lua

module("logic.extensions.farnas.model.FarnasCustomFmtMoOfExt", package.seeall)

local FarnasCustomFmtMoOfExt = class("FarnasCustomFmtMoOfExt", ICustomFmtMo)

function FarnasCustomFmtMoOfExt:onReset()
	FarnasCustomFmtMoOfExt.super.onReset(self)
end

function FarnasCustomFmtMoOfExt:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._activityType = FarnasController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._stageData = FarnasConfig.instance:getExtStageCfg(self._activityId, self._stageId)
	self._creepsMasterId = self._stageData.creepsMasterId
	self._masterData = FarnasConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = FarnasConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self._lockedRaceIdList = FarnasController.instance:getAllLockedRaceIdOfExtStage(self._activityId)
	self._lockedRaceIdMap = {}

	for i, v in ipairs(self._lockedRaceIdList) do
		self._lockedRaceIdMap[v] = v
	end
end

function FarnasCustomFmtMoOfExt:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function FarnasCustomFmtMoOfExt:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		FarnasController.instance:regFightResultInExt(self._activityId)

		local simpleForm = self:getCurSimpleForm()

		FarnasChallengeAgent.instance:sendPM_FarnasClgExtremeFightReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function FarnasCustomFmtMoOfExt:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function FarnasCustomFmtMoOfExt:getMonsterConfigList()
	return self._creepsCfg
end

function FarnasCustomFmtMoOfExt:getFmtInfoConfig()
	return self._masterData
end

function FarnasCustomFmtMoOfExt:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function FarnasCustomFmtMoOfExt:checkPetIsForbit(petMo)
	return self:_isPetNotCanUp(petMo:getDefineId())
end

function FarnasCustomFmtMoOfExt:showForbitPetAlert(petMo)
	if self:_isPetNotCanUp(petMo:getDefineId()) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function FarnasCustomFmtMoOfExt:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if FarnasCustomFmtMoOfExt.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
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

function FarnasCustomFmtMoOfExt:_isPetNotCanUp(raceId)
	if raceId > 0 then
		return self._lockedRaceIdMap[raceId] ~= nil
	else
		return false
	end
end

return FarnasCustomFmtMoOfExt
