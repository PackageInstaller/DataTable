-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/model/FanTianFmtMo.lua

module("logic.extensions.fantian.model.FanTianFmtMo", package.seeall)

local FanTianFmtMo = class("FanTianFmtMo", BaseCustomFmtMo)

function FanTianFmtMo:initParams(activityId, curSelectTierId, curSelectLevel)
	self.activityId = activityId
	self.curSelectTierId = curSelectTierId
	self.curSelectLevel = curSelectLevel

	local cfg = FanTianChallengeConfig.instance:getStageCfgById(activityId, curSelectTierId, curSelectLevel) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = FanTianChallengeConfig.instance:getMonsterCfgById(self.creepsMasterId)
	self.creeps = FanTianChallengeConfig.instance:getCreepsCfgById(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "FanTianFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function FanTianFmtMo:getMonsterConfigList()
	return self.creeps
end

function FanTianFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function FanTianFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		FanTianChallengeController.instance:sendStartFight(self.activityId, self.curSelectTierId, self.curSelectLevel, self:getCurSimpleForm())
	end, nil)
end

function FanTianFmtMo:getExtendViewName()
	return ViewName.FantianaddtipsView
end

return FanTianFmtMo
