-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/model/DragonKingFmtMo.lua

module("logic.extensions.dragonking.model.DragonKingFmtMo", package.seeall)

local DragonKingFmtMo = class("DragonKingFmtMo", BaseCustomFmtMo)

function DragonKingFmtMo:onInit()
	DragonKingFmtMo.super.onInit(self)

	self.useMaxFightPower = true
	self.isShowTab = false
end

function DragonKingFmtMo:initParams(activityId, stageId, selectPetList)
	self.activityId = activityId
	self.stageId = stageId
	self.selectPetList = selectPetList

	local stageCfg = DragonKingChallengeConfig.instance:getStageCfgById(activityId, stageId) or {}

	self.creepsMasterId = stageCfg.creepsMasterId

	local creepcfg = DragonKingChallengeConfig.instance:getCreepsConfig(self.creepsMasterId) or {}

	self.masterCfg = DragonKingChallengeConfig.instance:getMonsterCfgById(self.creepsMasterId)
	self.creeps = DragonKingChallengeConfig.instance:getCreepsConfig(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "DragonKingFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function DragonKingFmtMo:getMonsterConfigList()
	return self.creeps
end

function DragonKingFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function DragonKingFmtMo:initFightHandler()
	self:setFightHandler(function()
		DragonKingChallengeController.instance:sendStartFight(self.activityId, self.stageId, self:getCurSimpleForm(), self.selectPetList)
	end, nil)
end

function DragonKingFmtMo:getExtendViewName()
	return ViewName.DragonkingaddtipsView
end

return DragonKingFmtMo
