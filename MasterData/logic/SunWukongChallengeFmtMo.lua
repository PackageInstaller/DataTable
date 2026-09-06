-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/model/SunWukongChallengeFmtMo.lua

module("logic.extensions.sunwukongchallenge.model.SunWukongChallengeFmtMo", package.seeall)

local SunWukongChallengeFmtMo = class("SunWukongChallengeFmtMo", BaseCustomFmtMo)

function SunWukongChallengeFmtMo:initParams(activityId, stageId, isHidden)
	self._activityId = activityId
	self._stageId = stageId
	self._actCfg = SunWuKongChallengeConfig.instance:getActivityCfg(self._activityId)
	self._stageInfoCfg = SunWuKongChallengeConfig.instance:getStageCfg(self._actCfg.stagePlanId, self._stageId)

	local creepsMasterId = self:_getRealCreepsMasterId(isHidden, self._stageInfoCfg)

	self._cfgEnemy = SunWuKongChallengeConfig.instance:getMasterTeamCfg(creepsMasterId)
	self._masterList = SunWuKongChallengeConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name

	self:setFormCondition(self._cfgEnemy.formCondition)

	self.ruleDescStr = self._cfgEnemy.ruleDesc
end

function SunWukongChallengeFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurFormation():createFormPb()

		if self._stageId == SunWuKongChallengeModel.instance:getCurStageId(self._activityId) then
			SunWuKongChallengeController.instance:sendPM_SunWuKongChallengeReq(self._activityId, simpleForm)
		else
			SunWuKongChallengeController.instance:sendPM_SunWuKongChallengeReq(self._activityId, simpleForm, self._stageId)
		end
	end

	self:setFightHandler(handler, nil)
end

function SunWukongChallengeFmtMo:getMonsterConfigList()
	return self._masterList
end

function SunWukongChallengeFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function SunWukongChallengeFmtMo:_getRealCreepsMasterId(isHidden, stageCfg)
	if isHidden and stageCfg.hiddenTaskId > 0 then
		local hTaskCfg = SunWuKongChallengeConfig.instance:getHiddendTaskInfo(stageCfg.hiddenTaskId)

		if hTaskCfg.taskType == "Battle" then
			return checknumber(hTaskCfg.taskParams.creepsMasterId)
		else
			return stageCfg.hiddenTaskId
		end
	else
		return stageCfg.creepsMasterId
	end
end

return SunWukongChallengeFmtMo
