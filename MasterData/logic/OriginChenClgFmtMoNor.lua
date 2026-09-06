-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/model/OriginChenClgFmtMoNor.lua

module("logic.extensions.originchenclg.model.OriginChenClgFmtMoNor", package.seeall)

local OriginChenClgFmtMoNor = class("OriginChenClgFmtMoNor", BaseCustomFmtMo)

function OriginChenClgFmtMoNor:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local stageCfg = OriginChenClgConfig.instance:getNorStageCfg(activityId, stageId)

	self._creepsMasterId = stageCfg.creepsMasterId
	self._creepsCfg = OriginChenClgConfig.instance:getCreepsCfg(self._creepsMasterId)
	self._masterData = OriginChenClgConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
end

function OriginChenClgFmtMoNor:updateData()
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function OriginChenClgFmtMoNor:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginChenClgAgent.instance:sendPM_OriginChenClgChallengeNormalReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginChenClgFmtMoNor:getMonsterConfigList()
	return self._creepsCfg
end

function OriginChenClgFmtMoNor:getFmtInfoConfig()
	return self._masterData
end

return OriginChenClgFmtMoNor
