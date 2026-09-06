-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/model/DivineInvincibleExtremeFmtMo.lua

module("logic.extensions.divineinvincible.model.DivineInvincibleExtremeFmtMo", package.seeall)

local DivineInvincibleExtremeFmtMo = class("DivineInvincibleExtremeFmtMo", BaseCustomFmtMo)

function DivineInvincibleExtremeFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._clgMo = DivineInvincibleController.instance:getClgMo(self._activityId)

	local stageData = DivineInvincibleConfig.instance:getExtStageData(self._activityId, self._stageId)

	self._creepsMasterId = stageData.creepsMasterId
	self._masterData = DivineInvincibleConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = DivineInvincibleConfig.instance:getCreepsCfg(self._creepsMasterId)

	local lockRaceIds = self._clgMo:getAllLockRaceIdsInExt()

	self._lockedRaceIdMap = {}

	for i, v in ipairs(lockRaceIds) do
		self._lockedRaceIdMap[v] = v
	end

	local oldZdlRatio = self._zdlRatio
	local oldSystem = self._isUseSystem

	self._isUseSystem = false
	self._zdlRatio = 0
	self._supportPetPlanId = 0
	self._isUltTrialClg = UltimateTrialController.instance:isUltTrialClg(activityId)

	if self._isUltTrialClg then
		self._ultTrialActivityId = UltimateTrialController.instance:getActivityId()

		local clgData = UltimateTrialConfig.instance:getChallengeData(self._ultTrialActivityId, activityId)

		self._supportPetPlanId = clgData and clgData.supportPetPlanId

		local mode = UltimateTrialController.instance:getMode(self._ultTrialActivityId, activityId)

		if mode == UltimateTrialEnum.ClgMode_Nor then
			self._zdlRatio = UltimateTrialController.instance:getFmtExtraPercent(self._ultTrialActivityId, activityId)
		end
	end

	if oldSystem ~= self._isUseSystem or oldZdlRatio ~= self._zdlRatio then
		self:initPetList()
	end

	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
	self:tryInitPetList()

	local removePetIdList = {}

	if self._lastSupportPetPlanId ~= self._supportPetPlanId then
		local cfg = UltimateTrialConfig.instance:getSupportPetCfg(self._lastSupportPetPlanId)

		if cfg then
			for _, data in pairs(cfg) do
				table.insert(removePetIdList, data.creepsId)
			end
		end
	end

	self:tryRemovePetByIds(removePetIdList)

	local newPetMoList = {}

	if self._lastSupportPetPlanId ~= self._supportPetPlanId then
		self._lastSupportPetPlanId = self._supportPetPlanId

		local cfg = UltimateTrialConfig.instance:getSupportPetCfg(self._supportPetPlanId)

		if cfg then
			local fmo = FightingPowerPetMo.New()

			for _, data in pairs(cfg) do
				fmo:fromChallengeCreepCo(data)

				local petMo = fmo:toBaseBagPetMo()

				petMo:setSupportedPet(true)
				table.insert(newPetMoList, petMo)
			end
		end
	end

	for _, petMo in ipairs(newPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function DivineInvincibleExtremeFmtMo:_changePetMo(petMo)
	if self._isUseSystem then
		local maxPetMo = FightingPowerPetMo.getMaxPetMoByData(petMo)

		for k, v in pairs(GameEnum.AttrModelType) do
			maxPetMo.attrMo.extModelBaseAttrRate[v] = self._zdlRatio
		end

		maxPetMo.isMyPackPet = false

		maxPetMo:calcAllAttr()

		maxPetMo.isMyPackPet = petMo.isMyPackPet

		return maxPetMo
	else
		return DivineInvincibleExtremeFmtMo.super._changePetMo(self, petMo)
	end
end

function DivineInvincibleExtremeFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineInvincibleController.instance:sendPM_DivineInvincibleClgExtremeFightReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function DivineInvincibleExtremeFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineInvincibleExtremeFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineInvincibleExtremeFmtMo:checkPetIsForbit(petMo)
	return self:_isPetNotCanUp(petMo:getDefineId())
end

function DivineInvincibleExtremeFmtMo:showForbitPetAlert(petMo)
	if self:_isPetNotCanUp(petMo:getDefineId()) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function DivineInvincibleExtremeFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if DivineInvincibleExtremeFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
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

function DivineInvincibleExtremeFmtMo:_isPetNotCanUp(raceId)
	if raceId > 0 then
		return self._lockedRaceIdMap[raceId] ~= nil
	else
		return false
	end
end

function DivineInvincibleExtremeFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local result = false

	result = result or UltimateTrialController.instance:isBanInUltTrialClg(true, self._activityId)

	if not result then
		local tryResult = self._clgMo:getTryResultAndTipsStartExtremeStageClg(true, self._stageId)

		result = tryResult ~= GameEnum.ResultCode.Success
	end

	result = result or DivineInvincibleExtremeFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)

	return result
end

function DivineInvincibleExtremeFmtMo:getExtendViewName()
	return ViewName.DivineInvincibleExtremeFmtView
end

return DivineInvincibleExtremeFmtMo
