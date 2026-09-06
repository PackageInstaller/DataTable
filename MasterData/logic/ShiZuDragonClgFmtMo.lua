-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shizudragonclg/model/ShiZuDragonClgFmtMo.lua

module("logic.extensions.shizudragonclg.model.ShiZuDragonClgFmtMo", package.seeall)

local ShiZuDragonClgFmtMo = class("ShiZuDragonClgFmtMo", BaseCustomFmtMo)

function ShiZuDragonClgFmtMo:initParams(activityId, phaseId, stageId)
	self.activityId = activityId
	self.phaseId = phaseId
	self.stageId = stageId

	local stageCfg = ShiZuDragonClgConfig.instance:getStageCfg(self.activityId, self.phaseId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self._cfgEnemy = ShiZuDragonClgConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = ShiZuDragonClgConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
end

function ShiZuDragonClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		ShiZuDragonClgAgent.instance:sendPM_ShiZuDragonClgChallengeReq(self.activityId, self.phaseId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function ShiZuDragonClgFmtMo:getMonsterConfigList()
	return self._masterList
end

function ShiZuDragonClgFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

return ShiZuDragonClgFmtMo
