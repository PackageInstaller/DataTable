-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/model/DivineKunlunNorFmtMo.lua

module("logic.extensions.divinekunlun.model.DivineKunlunNorFmtMo", package.seeall)

local DivineKunlunNorFmtMo = class("DivineKunlunNorFmtMo", BaseCustomFmtMo)

function DivineKunlunNorFmtMo:onInit()
	DivineKunlunNorFmtMo.super.onInit(self)

	self.isOnlyUpdateExistPet = true
end

function DivineKunlunNorFmtMo:initParams(activityId, stageArrIndex, stageId)
	self.activityId = activityId
	self.stageArrIndex = stageArrIndex
	self.stageId = stageId
	self._activityCfg = DivineKunlunConfig.instance:getActivityCfgById(self.activityId) or {}

	local cfg = DivineKunlunConfig.instance:getNormalCfgById(activityId, stageId) or {} or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = DivineKunlunConfig.instance:getMonsterCfg(self.creepsMasterId)
	self.creeps = DivineKunlunConfig.instance:getCreeps(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "DivineKunlunNorFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function DivineKunlunNorFmtMo:initPetList()
	self:clearAllPetList()

	local fmo = FightingPowerPetMo.New()
	local list = DivineKunlunConfig.instance:getAllPet() or {}
	local planId = checknumber(self._activityCfg.sysPetPlanId)

	for i, v in ipairs(list) do
		if v.planId == planId then
			fmo:fromChallengeCreepCo(v)

			local petMo = fmo:toBaseBagPetMo()

			petMo:setSupportedPet(true)
			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function DivineKunlunNorFmtMo:getMonsterConfigList()
	return self.creeps
end

function DivineKunlunNorFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function DivineKunlunNorFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DivineKunlunController.instance:sendStartNorFight(self.activityId, self.stageArrIndex, self:getCurSimpleForm())
	end, nil)
end

return DivineKunlunNorFmtMo
