-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/model/SummonMasterJiExtremeFmtMo.lua

module("logic.extensions.summonmasterji.model.SummonMasterJiExtremeFmtMo", package.seeall)

local SummonMasterJiExtremeFmtMo = class("SummonMasterJiExtremeFmtMo", BaseCustomFmtMo)

function SummonMasterJiExtremeFmtMo:initParams(activityId, stageId, itemId2Score)
	self._activityId = activityId
	self._stageId = stageId
	self._itemId2Score = itemId2Score

	local cfgStage = SummonMasterJiConfig.instance:getExtremeStageCfg(activityId, stageId)

	self._monsterCfg = SummonMasterJiConfig.instance:getMonsterCfg(cfgStage.creepsMasterId)
	self._creepsCfgs = SummonMasterJiConfig.instance:getCreeps(cfgStage.creepsMasterId)
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.WinDesc

	self:setFormCondition(self._monsterCfg.formCondition)
end

function SummonMasterJiExtremeFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		SummonMasterJiAgent.instance:sendPM_SummonMasterJiChallengeExtremeReq(self._activityId, self._stageId, self._itemId2Score, form)
	end

	self:setFightHandler(handler, nil)
end

function SummonMasterJiExtremeFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function SummonMasterJiExtremeFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

return SummonMasterJiExtremeFmtMo
