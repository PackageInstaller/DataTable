-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/model/DivineAoJiuNormalFmtMo.lua

module("logic.extensions.divineaojiu.model.DivineAoJiuNormalFmtMo", package.seeall)

local DivineAoJiuNormalFmtMo = class("DivineAoJiuNormalFmtMo", BaseCustomFmtMo)

function DivineAoJiuNormalFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId

	local stageCfg = DivineAoJiuConfig.instance:getNormalStageCfg(self.activityId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self._cfgEnemy = DivineAoJiuConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = DivineAoJiuConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	self.useMaxFightPower = true
end

function DivineAoJiuNormalFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineAoJiuClgAgent.instance:sendPM_DivineAoJiuClgNormalClgReq(self.activityId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineAoJiuNormalFmtMo:getMonsterConfigList()
	return self._masterList
end

function DivineAoJiuNormalFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

return DivineAoJiuNormalFmtMo
