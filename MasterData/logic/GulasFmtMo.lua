-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gulas/model/GulasFmtMo.lua

module("logic.extensions.gulas.model.GulasFmtMo", package.seeall)

local GulasFmtMo = class("GulasFmtMo", BaseCustomFmtMo)

function GulasFmtMo:initParams(activityId, phaseId, stageId, extView)
	self.activityId = activityId
	self.phaseId = phaseId
	self.stageId = stageId
	self._extView = extView
	self._lockedRaceMap = GulasModel.instance:getAllLimitPetMap(self.activityId)

	local cfg = GulasConfig.instance:getPhaseCfgById(activityId, phaseId) or {}
	local stagePlanId = cfg.stagePlanId
	local groupCfg = GulasConfig.instance:getStageCfgById(stagePlanId, stageId) or {}

	self.creepsMasterId = groupCfg.creepsMasterId
	self.masterCfg = GulasConfig.instance:getMonsterCfgById(self.creepsMasterId)
	self.creeps = GulasConfig.instance:getCreepsById(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "GulasFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true

	if checknumber(groupCfg.posId) > 0 then
		local actCfg = GulasConfig.instance:getActivityCfgById(activityId) or {}

		self:setFixedEffect(checknumber(groupCfg.posId), actCfg.effPath)
	end
end

function GulasFmtMo:getMonsterConfigList()
	return self.creeps
end

function GulasFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function GulasFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		GulasController.instance:sendStartFight(self.activityId, self.phaseId, self.stageId, self:getCurSimpleForm())
	end, nil)
end

function GulasFmtMo:getExtendViewName()
	return self._extView
end

function GulasFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedRaceMap[petMo.raceId])
end

function GulasFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已封印")
end

return GulasFmtMo
