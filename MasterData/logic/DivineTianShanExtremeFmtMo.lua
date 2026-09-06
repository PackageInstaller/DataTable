-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/model/DivineTianShanExtremeFmtMo.lua

module("logic.extensions.divinetianshanclg.model.DivineTianShanExtremeFmtMo", package.seeall)

local DivineTianShanExtremeFmtMo = class("DivineTianShanExtremeFmtMo", BaseCustomFmtMo)

function DivineTianShanExtremeFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._stageInfoMap = DivineTianShanClgModel.instance:getExtremeStageMap(self._activityId)
	self._actCfg = DivineTianShanClgConfig.instance:getActCfgById(self._activityId)
	self._stageCfg = DivineTianShanClgConfig.instance:getExtremeStageCfgByStageId(self._actCfg.stagePlanId, self._stageId)
	self._masterData = DivineTianShanClgConfig.instance:getTeamCfg(self._stageCfg.creepsMasterId)
	self._creepsCfg = DivineTianShanClgConfig.instance:getCreepCfgs(self._stageCfg.creepsMasterId)

	local oldZdlRatio = self._zdlRatio
	local oldSystem = self._isUseSystem

	self._isUseSystem = false
	self._zdlRatio = 0
	self._isUltTrialClg = UltimateTrialController.instance:isUltTrialClg(self._activityId)

	if self._isUltTrialClg then
		self._ultTrialActivityId = UltimateTrialController.instance:getActivityId()

		local mode = UltimateTrialController.instance:getMode(self._ultTrialActivityId, activityId)

		if mode == UltimateTrialEnum.ClgMode_Nor then
			self._isUseSystem = true
			self._zdlRatio = UltimateTrialController.instance:getFmtExtraPercent(self._ultTrialActivityId, self._activityId)
		end
	end

	self._lockedRaceMap = {}

	local cfgs = DivineTianShanClgConfig.instance:getExtremeStageCfgsByPhaseId(self._actCfg.stagePlanId, self._stageCfg.phaseId) or {}

	for i, cfg in ipairs(cfgs) do
		local stageInfo = self._stageInfoMap[cfg.stageId]

		if stageInfo then
			if not stageInfo.lockRaceIds then
				local lockedPetIds = {}

				for k, raceId in ipairs(lockedPetIds) do
					self._lockedRaceMap[raceId] = true
				end
			end
		end
	end

	if oldSystem ~= self._isUseSystem or oldZdlRatio ~= self._zdlRatio then
		self:initPetList()
	end

	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivineTianShanExtremeFmtMo:_changePetMo(petMo)
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
		return DivineTianShanExtremeFmtMo.super._changePetMo(self, petMo)
	end
end

function DivineTianShanExtremeFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DivineTianShanClgController.instance:setExBuffParam(self._stageCfg)
		BattleSettlementModel.instance:setBattleTopExtView(ViewName.DivineTianShanBattleExView)

		local simpleForm = self:getCurSimpleForm()

		DivineTianShanClgController.instance:startExtremeFight(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineTianShanExtremeFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineTianShanExtremeFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineTianShanExtremeFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedRaceMap[petMo.raceId])
end

return DivineTianShanExtremeFmtMo
