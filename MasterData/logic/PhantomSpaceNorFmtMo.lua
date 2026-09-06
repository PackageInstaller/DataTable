-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/model/PhantomSpaceNorFmtMo.lua

module("logic.extensions.phantomspace.model.PhantomSpaceNorFmtMo", package.seeall)

local PhantomSpaceNorFmtMo = class("PhantomSpaceNorFmtMo", BaseCustomFmtMo)

function PhantomSpaceNorFmtMo:initParams(activityId, mode, buffLv, stageId)
	self.activityId = activityId
	self.mode = mode
	self.buffLv = buffLv
	self.stageId = stageId

	local cfg = PhantomSpaceConfig.instance:getStageCfgById(activityId, mode, stageId) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = PhantomSpaceConfig.instance:getMonsterCfgById(self.creepsMasterId) or {}
	self.creeps = PhantomSpaceConfig.instance:getCreeps(self.creepsMasterId) or {}

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "PhantomSpaceNorFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function PhantomSpaceNorFmtMo:getMonsterConfigList()
	return self.creeps
end

function PhantomSpaceNorFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function PhantomSpaceNorFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		PhantomSpaceController.instance:sendFight(self.activityId, self.mode, self.buffLv, self.stageId, self:getCurSimpleForm())
	end, nil)
end

return PhantomSpaceNorFmtMo
