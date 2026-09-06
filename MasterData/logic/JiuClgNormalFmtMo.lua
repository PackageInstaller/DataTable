-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/model/JiuClgNormalFmtMo.lua

module("logic.extensions.jiuclg.model.JiuClgNormalFmtMo", package.seeall)

local JiuClgNormalFmtMo = class("JiuClgNormalFmtMo", BaseCustomFmtMo)

function JiuClgNormalFmtMo:initParams(activityId, phaseId, stageId)
	self._activityId = activityId
	self._phaseId = phaseId
	self._stageId = stageId

	local cfgStage = JiuClgConfig.instance:getNormalStageCfg(activityId, phaseId, stageId)
	local creepsMasterId = cfgStage.creepsMasterId

	self._monsterCfg = JiuClgConfig.instance:getMonsterCfg(creepsMasterId)
	self._creepsCfgs = JiuClgConfig.instance:getCreeps(creepsMasterId)
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.ruleDesc

	self:setFormCondition(self._monsterCfg.formCondition)
end

function JiuClgNormalFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local form = self:getCurSimpleForm()

		JiuClgController.instance:sendPM_JiuClgNormalFightReq(self._activityId, form)
	end

	self:setFightHandler(handler, nil)
end

function JiuClgNormalFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function JiuClgNormalFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

return JiuClgNormalFmtMo
