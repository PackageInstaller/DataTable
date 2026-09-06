-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/model/MiracleNuoyaNormalFmtMo.lua

module("logic.extensions.miraclenuoya.model.MiracleNuoyaNormalFmtMo", package.seeall)

local MiracleNuoyaNormalFmtMo = class("MiracleNuoyaNormalFmtMo", BaseCustomFmtMo)

function MiracleNuoyaNormalFmtMo:onInit()
	MiracleNuoyaNormalFmtMo.super.onInit(self)

	self.useMaxFightPower = true
end

function MiracleNuoyaNormalFmtMo:initParams(activityId, groupId)
	self.activityId = activityId
	self.groupId = groupId

	local groupCfg = MiracleNuoyaConfig.instance:getGroupCfgById(activityId, groupId) or {}

	self.creepsMasterId = groupCfg.creepsMasterId
	self.masterCfg = MiracleNuoyaConfig.instance:getMonsterCfgById(self.creepsMasterId)
	self.creeps = MiracleNuoyaConfig.instance:getCreepsCfgById(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "MiracleNuoyaNormalFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function MiracleNuoyaNormalFmtMo:getMonsterConfigList()
	return self.creeps
end

function MiracleNuoyaNormalFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function MiracleNuoyaNormalFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		MiracleNuoyaController.instance:sendNormalStartFight(self.activityId, self:getCurSimpleForm())
	end, nil)
end

return MiracleNuoyaNormalFmtMo
