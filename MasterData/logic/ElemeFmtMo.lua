-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eleme/model/ElemeFmtMo.lua

module("logic.extensions.eleme.model.ElemeFmtMo", package.seeall)

local ElemeFmtMo = class("ElemeFmtMo", BaseCustomFmtMo)

function ElemeFmtMo:initParams(activityId, index, orderId)
	self.activityId = activityId
	self.index = index

	local cfg = ElemeConfig.instance:getOrderByActId(activityId, orderId) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = ElemeConfig.instance:getMonsterCfgById(self.creepsMasterId) or {}
	self.creeps = ElemeConfig.instance:getCreepsCfgById(self.creepsMasterId) or {}

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "ElemeFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function ElemeFmtMo:getMonsterConfigList()
	return self.creeps
end

function ElemeFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function ElemeFmtMo:initFightHandler()
	self:setFightHandler(function()
		ElemeController.instance:sendStartFight(self.activityId, self.index, self:getCurSimpleForm())
	end, nil)
end

return ElemeFmtMo
