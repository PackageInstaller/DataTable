-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/model/UltimateTrialDualDragonFinalFmtMo.lua

module("logic.extensions.divinedualdragonclg.model.UltimateTrialDualDragonFinalFmtMo", package.seeall)

local UltimateTrialDualDragonFinalFmtMo = class("UltimateTrialDualDragonFinalFmtMo", DivineDualDragonClgFinalFmtMo)

function UltimateTrialDualDragonFinalFmtMo:initParams(activityId, phaseId, stageId)
	self.activityId = activityId
	self.phaseId = phaseId
	self.stageId = stageId

	local activityCfg = DivineDualDragonClgConfig.instance:getActivityCfg(activityId)
	local phaseCfg = DivineDualDragonClgConfig.instance:getPhaseCfg(activityCfg.phasePlanId, phaseId)
	local stageCfg = DivineDualDragonClgConfig.instance:getStageCfg(phaseCfg.stagePlanId, stageId)

	self._cfgEnemy = DivineDualDragonClgConfig.instance:getTeamCfg(stageCfg.creepsMasterId)
	self._masterList = DivineDualDragonClgConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)
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

	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc
	self.isOnlyUpdateExistPet = true

	self:setFormCondition(self._cfgEnemy.formCondition)

	local existPet = DivineDualDragonClgModel.instance:getFinalFightPet(self.activityId, self.phaseId)

	self._existPetList = {}

	table.clear(self._existPetList)

	for k, v in pairs(existPet) do
		table.insert(self._existPetList, k)
	end
end

function UltimateTrialDualDragonFinalFmtMo:initPetList()
	UltimateTrialDualDragonFinalFmtMo.super.initPetList(self)

	local cfg = UltimateTrialConfig.instance:getSupportPetCfg(self._supportPetPlanId)

	if cfg then
		local fmo = FightingPowerPetMo.New()

		for _, data in pairs(cfg) do
			if table.indexof(self._existPetList, data.creepsId) ~= false then
				fmo:fromChallengeCreepCo(data)

				local petMo = fmo:toBaseBagPetMo()

				petMo:setSupportedPet(true)
				self:addPetToList(self:_changePetMo(petMo))
			end
		end
	end
end

function UltimateTrialDualDragonFinalFmtMo:_changePetMo(petMo)
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

function UltimateTrialDualDragonFinalFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local result = false

	result = result or UltimateTrialController.instance:isBanInUltTrialClg(true, self._activityId)
	result = result or UltimateTrialDualDragonFinalFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)

	return result
end

return UltimateTrialDualDragonFinalFmtMo
