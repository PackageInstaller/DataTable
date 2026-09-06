-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/model/CrazyPartnerCustomFmtMo.lua

module("logic.extensions.crazypartner.model.CrazyPartnerCustomFmtMo", package.seeall)

local CrazyPartnerCustomFmtMo = class("CrazyPartnerCustomFmtMo", ICustomFmtMo)

function CrazyPartnerCustomFmtMo:onReset()
	CrazyPartnerCustomFmtMo.super.onReset(self)

	self._formationMoCache = {}
	self.isShowBtnCutePet = false
end

function CrazyPartnerCustomFmtMo:updateData()
	self.ruleViewName = ViewName.CrazyPartnerRuleView
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_UserSet
	self.strShowRuleFlagKey = CrazyPartnerConfig.RuleUserSetKey

	local creepConf = self:getFmtInfoConfig()

	self.topTitleStr = creepConf.name
	self.ruleDescStr = creepConf.description
	self.validatorDescStr = creepConf.description

	local fightInfo = CrazyPartnerModel.instance.fightInfo
	local curSystemPetPlanId = fightInfo.currentSystemPetPlanId

	self._formationMoCache[curSystemPetPlanId] = self._formationMoCache[curSystemPetPlanId] or FormationMO.New(GameUtil.handler(self.getPetMoById, self))
	self.formationMo = self._formationMoCache[curSystemPetPlanId]

	self:clearAllPetList()
end

function CrazyPartnerCustomFmtMo:isUseMaxStreng()
	return true
end

function CrazyPartnerCustomFmtMo:initFightHandler()
	self:setFightHandler(function()
		CrazyPartnerController.instance:reqStartFight()
	end, nil)
end

function CrazyPartnerCustomFmtMo:initPetList()
	local fightInfo = CrazyPartnerModel.instance.fightInfo
	local confs = CrazyPartnerConfig.instance:getSupportConfs(fightInfo.currentSystemPetPlanId)

	for _, data in pairs(confs) do
		local fmo = FightingPowerPetMo.New()

		fmo:fromChallengeCreepCo(data)

		local petMo = fmo:toBaseBagPetMo()

		self:addPetToList(petMo)
	end
end

function CrazyPartnerCustomFmtMo:getMonsterConfigList()
	local fightInfo = CrazyPartnerModel.instance.fightInfo

	return CrazyPartnerConfig.instance:getTeamCreeps(fightInfo.currentCreepsMasterId)
end

function CrazyPartnerCustomFmtMo:getFmtInfoConfig()
	local fightInfo = CrazyPartnerModel.instance.fightInfo

	return CrazyPartnerConfig.instance:getTeamConfs(fightInfo.currentCreepsMasterId)
end

function CrazyPartnerCustomFmtMo:getExtendViewName()
	local fightInfo = CrazyPartnerModel.instance.fightInfo
	local buffConf = CrazyPartnerConfig.instance:getBuffConf(fightInfo.currentBuffId)

	if buffConf and buffConf.type == CrazyPartnerConfig.SequenceBuffType then
		return ViewName.CrazyPartnerExtensionView
	end

	return ""
end

return CrazyPartnerCustomFmtMo
