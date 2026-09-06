-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/model/DivineZhongFeiClgNormalFmtMo.lua

module("logic.extensions.divinezhongfeiclg.model.DivineZhongFeiClgNormalFmtMo", package.seeall)

local DivineZhongFeiClgNormalFmtMo = class("DivineZhongFeiClgNormalFmtMo", BaseCustomFmtMo)

function DivineZhongFeiClgNormalFmtMo:initParams(activityId)
	self.activityId = activityId

	local activityCfg = DivineZhongFeiClgConfig.instance:getActivityCfg(self.activityId)
	local creepsMasterId = checknumber(activityCfg.creepsMasterId)

	self._cfgEnemy = DivineZhongFeiClgConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = DivineZhongFeiClgConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	self.useMaxFightPower = true
end

function DivineZhongFeiClgNormalFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineZhongFeiClgAgent:sendPM_DivineZhongFeiClgNormalChallengeReq(self.activityId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineZhongFeiClgNormalFmtMo:getMonsterConfigList()
	return self._masterList
end

function DivineZhongFeiClgNormalFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

return DivineZhongFeiClgNormalFmtMo
