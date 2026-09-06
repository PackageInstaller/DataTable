-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpsychicji/model/OriginpsychicjiFmtMo.lua

module("logic.extensions.originpsychicji.model.OriginpsychicjiFmtMo", package.seeall)

local OriginpsychicjiFmtMo = class("OriginpsychicjiFmtMo", BaseCustomFmtMo)

function OriginpsychicjiFmtMo:initParams(activityId, clgType, stageId)
	self._activityId = activityId
	self._clgType = clgType
	self._stageId = stageId
	self._stageCfg = self._clgType == OriginpsychicjiController.ClgType.Extreme and OriginpsychicjiConfig.instance:getExtStageCfg(activityId, stageId) or OriginpsychicjiConfig.instance:getNormalStageCfg(activityId, stageId)
	self._creepsMasterId = self._stageCfg.creepsMasterId
	self._masterData = OriginpsychicjiConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = OriginpsychicjiConfig.instance:getCreepsCfgs(self._creepsMasterId)
end

function OriginpsychicjiFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = ""
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function OriginpsychicjiFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local form = self:getCurSimpleForm()

		if self._clgType == OriginpsychicjiController.ClgType.Extreme then
			OriginPsychicJiAgent.instance:sendPM_OriginPsyChicJiExtClgReq(self._activityId, form, self._stageId)
		else
			OriginPsychicJiAgent.instance:sendPM_OriginPsyChicJiCommonClgReq(self._activityId, form, self._stageId)
		end
	end

	self:setFightHandler(handler, nil)
end

function OriginpsychicjiFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginpsychicjiFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginpsychicjiFmtMo:getStageCfg()
	return self._stageCfg
end

return OriginpsychicjiFmtMo
