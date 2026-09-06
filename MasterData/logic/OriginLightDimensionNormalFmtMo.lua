-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/model/OriginLightDimensionNormalFmtMo.lua

module("logic.extensions.originlightdimension.model.OriginLightDimensionNormalFmtMo", package.seeall)

local OriginLightDimensionNormalFmtMo = class("OriginLightDimensionNormalFmtMo", BaseCustomFmtMo)

function OriginLightDimensionNormalFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId

	local stageCfg = OriginLightDimensionConfig.instance:getNormalStageCfg(self.activityId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self._cfgEnemy = OriginLightDimensionConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = OriginLightDimensionConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	self.useMaxFightPower = true
end

function OriginLightDimensionNormalFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginLightDimensionAgent.instance:sendPM_OriginLightDimensionNormalClgReq(self.activityId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginLightDimensionNormalFmtMo:getMonsterConfigList()
	return self._masterList
end

function OriginLightDimensionNormalFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

return OriginLightDimensionNormalFmtMo
