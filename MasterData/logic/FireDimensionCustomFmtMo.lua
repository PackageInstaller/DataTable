-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firedimension/model/FireDimensionCustomFmtMo.lua

module("logic.extensions.firedimension.model.FireDimensionCustomFmtMo", package.seeall)

local FireDimensionCustomFmtMo = class("FireDimensionCustomFmtMo", BaseCustomFmtMo)

function FireDimensionCustomFmtMo:initParams(activityId, stageId, teamId)
	self._activityId = activityId
	self._stageId = stageId
	self._teamId = teamId
	self._cfgActivity = FireDimensionConfig.instance:getActivityCfg(self._activityId)

	local cfgTeam = FireDimensionConfig.instance:getSmallStageCfg(self._activityId, self._stageId, self._teamId)

	if cfgTeam then
		if not cfgTeam.creepsMasterId then
			local creepsMasterId = 0

			self._monsterCfg = FireDimensionConfig.instance:getMonsterCfg(creepsMasterId)
			self._creepsCfgs = FireDimensionConfig.instance:getCreepsCfgList(creepsMasterId)

			self:setFormCondition(self._monsterCfg.formCondition)

			self.isShowTab = false
			self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_DailyOnce
			self.strShowRuleFlagKey = "FireDimensionCustomFmtMo" .. self._activityId .. "_" .. self._stageId .. self._teamId
			self.topTitleStr = self._monsterCfg.name
			self.ruleDescStr = self._monsterCfg.WinDesc
			self.isPopRuleDesc = true
		end
	end
end

function FireDimensionCustomFmtMo:initFightHandler()
	local function handler()
		FireDimensionChallengeAgent.instance:sendPM_FireDimensionChallengeReq(self._activityId, self._stageId, self._teamId, self:getCurSimpleForm())
	end

	UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
	self:setFightHandler(handler, nil)
end

function FireDimensionCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function FireDimensionCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

return FireDimensionCustomFmtMo
