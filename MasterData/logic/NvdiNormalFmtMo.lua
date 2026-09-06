-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/model/NvdiNormalFmtMo.lua

module("logic.extensions.nvdi.model.NvdiNormalFmtMo", package.seeall)

local NvdiNormalFmtMo = class("NvdiNormalFmtMo", BaseCustomFmtMo)

function NvdiNormalFmtMo:initParams(activityId, groupId, dataBitId)
	self.activityId = activityId
	self.groupId = groupId
	self.dataBitId = dataBitId
	self.useMaxFightPower = true

	local cfg = NvdiChallengeConfig.instance:getGroupCfgById(activityId, groupId, dataBitId) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = NvdiChallengeConfig.instance:getMonsterCfgById(self.creepsMasterId)
	self.creeps = NvdiChallengeConfig.instance:getCreepsCfgById(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "NvdiNormalFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function NvdiNormalFmtMo:getMonsterConfigList()
	return self.creeps
end

function NvdiNormalFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function NvdiNormalFmtMo:initPetList()
	NvdiNormalFmtMo.super.initPetList(self)

	local supportCfgs = NvdiChallengeConfig.instance:getSupportPetCfgById(self.activityId) or {}

	for k, v in pairs(supportCfgs) do
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(v)

		local petMo = fMo:toBaseBagPetMo()

		petMo.isSupportedPet = true

		self:addPetToList(self:_changePetMo(petMo))
	end
end

function NvdiNormalFmtMo:initFightHandler()
	self:setFightHandler(function()
		NvdiChallengeController.instance:sendStartFightNormal(self.activityId, self.dataBitId, self:getCurSimpleForm())
	end, nil)
end

return NvdiNormalFmtMo
