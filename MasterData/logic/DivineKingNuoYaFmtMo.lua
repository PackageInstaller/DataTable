-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingnuoya/model/DivineKingNuoYaFmtMo.lua

module("logic.extensions.divinekingnuoya.model.DivineKingNuoYaFmtMo", package.seeall)

local DivineKingNuoYaFmtMo = class("DivineKingNuoYaFmtMo", BaseCustomFmtMo)

function DivineKingNuoYaFmtMo:onReset()
	DivineKingNuoYaFmtMo.super.onReset(self)
end

function DivineKingNuoYaFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._creepsMasterId = DivineKingNuoYaConfig.instance:getCreepsMasterId(activityId, stageId)
	self._masterData = DivineKingNuoYaConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = DivineKingNuoYaConfig.instance:getCreepCfg(self._creepsMasterId)

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
	self.ruleDescStr = self._masterData.ruleDesc

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

function DivineKingNuoYaFmtMo:_changePetMo(petMo)
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
		return DivineKingNuoYaFmtMo.super._changePetMo(self, petMo)
	end
end

function DivineKingNuoYaFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineKingNuoYaController.instance:sendPM_DivineKingNoahClgFightReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineKingNuoYaFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineKingNuoYaFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineKingNuoYaFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local result = false

	result = result or UltimateTrialController.instance:isBanInUltTrialClg(true, self._activityId)
	result = result or DivineKingNuoYaFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)

	return result
end

return DivineKingNuoYaFmtMo
