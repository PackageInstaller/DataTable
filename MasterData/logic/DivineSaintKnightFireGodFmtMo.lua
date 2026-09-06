-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/DivineSaintKnightFireGod/model/DivineSaintKnightFireGodFmtMo.lua

module("logic.extensions.DivineSaintKnightFireGod.model.DivineSaintKnightFireGodFmtMo", package.seeall)

local DivineSaintKnightFireGodFmtMo = class("DivineSaintKnightFireGodFmtMo", BaseCustomFmtMo)

function DivineSaintKnightFireGodFmtMo:initParams(activityId, stageId, clickTimes)
	self._activityId = activityId
	self._stageId = stageId
	self._clickTimes = clickTimes
	self._stageCfg = DivineSaintKnightFireGodConfig.instance:getStageCfg(self._activityId, self._stageId)
	self._creepsMasterId = self._stageCfg.creepsMasterId
	self._masterData = DivineSaintKnightFireGodConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = DivineSaintKnightFireGodConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivineSaintKnightFireGodFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineSaintKnightFireGodFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineSaintKnightFireGodFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineSaintKnightFireGodAgent.instance:sendPM_DivineSaintKnightFireGodChallengeReq(self._activityId, simpleForm, self._clickTimes, self._stageId)
	end

	self:setFightHandler(handler, nil)
end

return DivineSaintKnightFireGodFmtMo
