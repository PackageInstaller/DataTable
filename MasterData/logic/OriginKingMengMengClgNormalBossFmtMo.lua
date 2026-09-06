-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/model/OriginKingMengMengClgNormalBossFmtMo.lua

module("logic.extensions.originkingmengmengclg.model.OriginKingMengMengClgNormalBossFmtMo", package.seeall)

local OriginKingMengMengClgNormalBossFmtMo = class("OriginKingMengMengClgNormalBossFmtMo", OriginKingMengMengClgBaseFmtMo)

function OriginKingMengMengClgNormalBossFmtMo:updateCfg(activityId)
	local oldSupportPetPlan = self._supportPetPlan

	self._activityId = checknumber(activityId)
	self._stageId = -1
	self._actData = OriginKingMengMengClgConfig.instance:getActivityData(self._activityId)
	self._creepsMasterId = self._actData.normalClgCreepsMasterId
	self._mustOnFormPetFilter = self._actData.normalClgPetFilter
	self._masterData = OriginKingMengMengClgConfig.instance:getCreepsMasterData(self._creepsMasterId) or {}
	self._creepsCfg = OriginKingMengMengClgConfig.instance:getCreepsDatas(self._creepsMasterId) or {}
	self._supportPetPlan = self._actData.normalClgSupportPetPlanId
	self._supportPetCfgs = OriginKingMengMengClgConfig.instance:getSupportPetDatasByPlanId(self._activityId, self._supportPetPlan) or {}
	self.topTitleStr = self._masterData.name or ""
	self.ruleDescStr = self._masterData.ruleDesc or self._masterData.WinDesc or ""
	self.validatorDescStr = self._masterData.ruleDesc or ""

	self:setFormCondition(self._masterData.formCondition)

	if oldSupportPetPlan ~= nil and oldSupportPetPlan ~= self._supportPetPlan then
		self:clearAllPetList()
	end
end

function OriginKingMengMengClgNormalBossFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginKingMengMengClgController.instance:sendPM_OriginKingMengMengClgNormalFightReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function OriginKingMengMengClgNormalBossFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginKingMengMengClgNormalBossFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginKingMengMengClgNormalBossFmtMo:initPetList()
	OriginKingMengMengClgNormalBossFmtMo.super.initPetList(self)

	local powerPetMo = FightingPowerPetMo.New()

	for _, supportPetCfg in ipairs(self._supportPetCfgs) do
		powerPetMo:fromChallengeCreepCo(supportPetCfg)

		local petMo = powerPetMo:toBaseBagPetMo()

		petMo:setSupportedPet(true)
		self:addPetToList(self:_changePetMo(petMo))
	end
end

return OriginKingMengMengClgNormalBossFmtMo
