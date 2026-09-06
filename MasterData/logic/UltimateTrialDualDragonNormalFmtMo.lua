-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/model/UltimateTrialDualDragonNormalFmtMo.lua

module("logic.extensions.divinedualdragonclg.model.UltimateTrialDualDragonNormalFmtMo", package.seeall)

local UltimateTrialDualDragonNormalFmtMo = class("UltimateTrialDualDragonNormalFmtMo", BaseCustomFmtMo)

function UltimateTrialDualDragonNormalFmtMo:initParams(activityId, phaseId, stageId)
	self._activityId = activityId
	self._phaseId = phaseId
	self._stageId = stageId

	local activityCfg = DivineDualDragonClgConfig.instance:getActivityCfg(activityId)
	local phaseCfg = DivineDualDragonClgConfig.instance:getPhaseCfg(activityCfg.phasePlanId, phaseId)
	local stageCfg = DivineDualDragonClgConfig.instance:getStageCfg(phaseCfg.stagePlanId, stageId)

	self._cfgEnemy = DivineDualDragonClgConfig.instance:getTeamCfg(stageCfg.creepsMasterId)
	self._masterList = DivineDualDragonClgConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)

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

	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
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

function UltimateTrialDualDragonNormalFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineDualDragonClgAgent.instance:sendPM_DivineDualDragonClgChallengeReq(self._activityId, self._phaseId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function UltimateTrialDualDragonNormalFmtMo:_changePetMo(petMo)
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
		local mo = petMo:GetClone()

		mo.attrMo:resetPublicAttr()
		mo.attrMo:calcTotalAttrs()
		mo:refreshAllAttr()

		return mo
	end
end

function UltimateTrialDualDragonNormalFmtMo:getMonsterConfigList()
	return self._masterList
end

function UltimateTrialDualDragonNormalFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function UltimateTrialDualDragonNormalFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local result = false

	result = result or UltimateTrialController.instance:isBanInUltTrialClg(true, self._activityId)
	result = result or UltimateTrialDualDragonNormalFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)

	return result
end

return UltimateTrialDualDragonNormalFmtMo
