-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originalchemymengmeng/model/OriginalChemyMengMengFmtMo.lua

module("logic.extensions.originalchemymengmeng.model.OriginalChemyMengMengFmtMo", package.seeall)

local OriginalChemyMengMengFmtMo = class("OriginalChemyMengMengFmtMo", BaseCustomFmtMo)

function OriginalChemyMengMengFmtMo:updateCfg(activityId, stageId)
	self._activityId = checknumber(activityId)
	self._stageId = checknumber(stageId)
	self._useReagentId = 0
	self._stageCfg = OriginalChemyMengMengConfig.instance:getStageCfg(self._activityId, self._stageId)
	self._creepsMasterId = OriginalChemyMengMengConfig.instance:getCreepMasterId(self._activityId, self._stageId)
	self._masterData = OriginalChemyMengMengConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = OriginalChemyMengMengConfig.instance:getCreepsCfgs(self._creepsMasterId)

	if self._masterData then
		self.topTitleStr = self._masterData.name or ""
	end

	if self._masterData then
		self.ruleDescStr = self._masterData.ruleDesc or ""
	end

	self:setFormCondition((self._masterData or nil) and (self._masterData.formCondition or 0))
end

function OriginalChemyMengMengFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginalChemyMengMengController.instance:sendPM_OriginAlchemyMengMengChallengeReq(self._activityId, self._stageId, self._useReagentId, simpleForm)
	end, nil)
end

function OriginalChemyMengMengFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginalChemyMengMengFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginalChemyMengMengFmtMo:getExtendViewName()
	return ViewName.OriginAlchemyMengMengFmtView
end

function OriginalChemyMengMengFmtMo:getActivityId()
	return self._activityId
end

function OriginalChemyMengMengFmtMo:getStageId()
	return self._stageId
end

function OriginalChemyMengMengFmtMo:setUseReagentId(reagentId)
	self._useReagentId = checknumber(reagentId)
end

function OriginalChemyMengMengFmtMo:getUseReagentId()
	return checknumber(self._useReagentId)
end

return OriginalChemyMengMengFmtMo
