-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/model/FusionSoulFmtMo.lua

module("logic.extensions.fusionsoul.model.FusionSoulFmtMo", package.seeall)

local FusionSoulFmtMo = class("FusionSoulFmtMo", BaseCustomFmtMo)

function FusionSoulFmtMo:initParams(activityId, zoneId, eventId)
	self.activityId = activityId
	self.zoneId = zoneId
	self.eventId = eventId

	local eventCfg = FusionSoulConfig.instance:getEventCfg(self.activityId, self.zoneId, self.eventId)
	local creepsMasterId = checknumber(eventCfg.eventParam)

	self._cfgEnemy = FusionSoulConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = FusionSoulConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
end

function FusionSoulFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		FusionSoulController.instance:sendPM_FusionSoulBattleReq(self.activityId, self.zoneId, self.eventId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function FusionSoulFmtMo:getMonsterConfigList()
	return self._masterList
end

function FusionSoulFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

return FusionSoulFmtMo
