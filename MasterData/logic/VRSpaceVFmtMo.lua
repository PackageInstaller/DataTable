-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/model/VRSpaceVFmtMo.lua

module("logic.extensions.vrspace.model.VRSpaceVFmtMo", package.seeall)

local VRSpaceVFmtMo = class("VRSpaceVFmtMo", BaseCustomFmtMo)

function VRSpaceVFmtMo:initParams(activityId, mode, stageId)
	self.activityId = activityId
	self.mode = mode
	self.stageId = stageId

	if mode == 0 then
		self.useMaxFightPower = true
	end

	local vplanCfg = VRSpaceConfig.instance:getPlanCfgById(activityId, mode, 0) or {}
	local vstagePlanId = checknumber(vplanCfg.stagePlanId)
	local cfg = VRSpaceConfig.instance:getStageCfgById(vstagePlanId, stageId) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = VRSpaceConfig.instance:getMonsterCfgById(self.creepsMasterId)
	self.creeps = VRSpaceConfig.instance:getCreepsCfgById(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "VRSpaceVFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function VRSpaceVFmtMo:getMonsterConfigList()
	return self.creeps
end

function VRSpaceVFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function VRSpaceVFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		VRSpaceController.instance:sendStartVFight(self.activityId, self.mode, self.stageId, self:getCurSimpleForm())
	end, nil)
end

return VRSpaceVFmtMo
