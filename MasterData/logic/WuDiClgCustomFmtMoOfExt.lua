-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/model/WuDiClgCustomFmtMoOfExt.lua

module("logic.extensions.wudiclg.model.WuDiClgCustomFmtMoOfExt", package.seeall)

local WuDiClgCustomFmtMoOfExt = class("WuDiClgCustomFmtMoOfExt", ICustomFmtMo)

function WuDiClgCustomFmtMoOfExt:onReset()
	WuDiClgCustomFmtMoOfExt.super.onReset(self)
end

function WuDiClgCustomFmtMoOfExt:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._activityType = WuDiClgController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._stageData = WuDiClgConfig.instance:getWdcExtStageData(self._activityId, self._stageId)
	self._creepsMasterId = self._stageData.creepsMasterId
	self._masterData = WuDiClgConfig.instance:getWdcCreepsMasterData(self._creepsMasterId)
	self._creepsCfg = WuDiClgConfig.instance:getWdcCreepsCfg(self._creepsMasterId)
	self._lockedRaceIdList = WuDiClgController.instance:getAllLockedRaceIdOfExtStage(self._activityId)
	self._lockedRaceIdMap = {}

	for i, v in ipairs(self._lockedRaceIdList) do
		self._lockedRaceIdMap[v] = v
	end
end

function WuDiClgCustomFmtMoOfExt:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function WuDiClgCustomFmtMoOfExt:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		WuDiClgController.instance:sendPM_WuDiClgExtremeFightReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function WuDiClgCustomFmtMoOfExt:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function WuDiClgCustomFmtMoOfExt:getMonsterConfigList()
	return self._creepsCfg
end

function WuDiClgCustomFmtMoOfExt:getFmtInfoConfig()
	return self._masterData
end

function WuDiClgCustomFmtMoOfExt:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function WuDiClgCustomFmtMoOfExt:checkPetIsForbit(petMo)
	return self:_isPetNotCanUp(petMo:getDefineId())
end

function WuDiClgCustomFmtMoOfExt:showForbitPetAlert(petMo)
	if self:_isPetNotCanUp(petMo:getDefineId()) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function WuDiClgCustomFmtMoOfExt:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if WuDiClgCustomFmtMoOfExt.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
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

function WuDiClgCustomFmtMoOfExt:_isPetNotCanUp(raceId)
	if raceId > 0 then
		return self._lockedRaceIdMap[raceId] ~= nil
	else
		return false
	end
end

return WuDiClgCustomFmtMoOfExt
