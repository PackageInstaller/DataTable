-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/model/OriginPowersClgNormalFmtMo.lua

module("logic.extensions.originpowersclg.model.OriginPowersClgNormalFmtMo", package.seeall)

local OriginPowersClgNormalFmtMo = class("OriginPowersClgNormalFmtMo", BaseCustomFmtMo)

function OriginPowersClgNormalFmtMo:onInit()
	OriginPowersClgNormalFmtMo.super.onInit(self)

	self.useMaxFightPower = true
end

function OriginPowersClgNormalFmtMo:initParams(activityId, day, index)
	self.activityId = activityId
	self.day = day
	self.index = index

	local stageCfg = OriginPowersClgConfig.instance:getNormalStageCfgs(self.activityId, self.day)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId[self.index])

	self._cfgEnemy = OriginPowersClgConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = OriginPowersClgConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.WinDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
end

function OriginPowersClgNormalFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginPowersClgAgent.instance:sendPM_OriginPowersCommonFightReq(self.activityId, self.day, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginPowersClgNormalFmtMo:getMonsterConfigList()
	return self._masterList
end

function OriginPowersClgNormalFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

return OriginPowersClgNormalFmtMo
