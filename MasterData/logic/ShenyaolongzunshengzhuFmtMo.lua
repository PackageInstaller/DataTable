-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaolongzunshengzhu/model/ShenyaolongzunshengzhuFmtMo.lua

module("logic.extensions.shenyaolongzunshengzhu.model.ShenyaolongzunshengzhuFmtMo", package.seeall)

local ShenyaolongzunshengzhuFmtMo = class("ShenyaolongzunshengzhuFmtMo", BaseCustomFmtMo)

function ShenyaolongzunshengzhuFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.curStageId = stageId

	local cfg = ShenyaolongzunshengzhuConfig.instance:getStageCfgById(activityId, stageId) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = ShenyaolongzunshengzhuConfig.instance:getMonsterCfgById(self.creepsMasterId)
	self.creeps = ShenyaolongzunshengzhuConfig.instance:getCreepsCfgById(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "ShenyaolongzunshengzhuFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function ShenyaolongzunshengzhuFmtMo:getMonsterConfigList()
	return self.creeps
end

function ShenyaolongzunshengzhuFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function ShenyaolongzunshengzhuFmtMo:initFightHandler()
	self:setFightHandler(function()
		ShenyaolongzunshengzhuController.instance:sendStartFight(self.activityId, self.curStageId, self:getCurSimpleForm())
	end, nil)
end

function ShenyaolongzunshengzhuFmtMo:getExtendViewName()
	return ViewName.ShenyaolongzunshengzhuextView
end

return ShenyaolongzunshengzhuFmtMo
