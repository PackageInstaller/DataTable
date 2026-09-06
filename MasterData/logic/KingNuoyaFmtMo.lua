-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingnuoya/model/KingNuoyaFmtMo.lua

module("logic.extensions.kingnuoya.model.KingNuoyaFmtMo", package.seeall)

local KingNuoyaFmtMo = class("KingNuoyaFmtMo", BaseCustomFmtMo)

function KingNuoyaFmtMo:initParams(activityId, curType, curStepId, challengeId, currBuffId)
	self.activityId = activityId
	self.curType = curType
	self.curStepId = curStepId
	self.challengeId = challengeId
	self.currBuffId = currBuffId

	local cfg = KingNuoyaChallengeConfig.instance:getStageCfgById(activityId, challengeId)

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = KingNuoyaChallengeConfig.instance:getTeamCfgById(self.creepsMasterId)
	self.creeps = KingNuoyaChallengeConfig.instance:getCreepCfgById(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_First
	self.strShowRuleFlagKey = "KingNuoyaFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.WinDesc
	self.isPopRuleDesc = true
end

function KingNuoyaFmtMo:getMonsterConfigList()
	return self.creeps
end

function KingNuoyaFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function KingNuoyaFmtMo:initFightHandler()
	self:setFightHandler(function()
		KingNuoyaChallengeController.instance:sendStartFight(self.activityId, self.curType, self.curStepId, self.challengeId, self.currBuffId, self:getCurSimpleForm())
	end, nil)
end

return KingNuoyaFmtMo
