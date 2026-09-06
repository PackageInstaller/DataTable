-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/model/SummonMasterJiNormalFmtMo.lua

module("logic.extensions.summonmasterji.model.SummonMasterJiNormalFmtMo", package.seeall)

local SummonMasterJiNormalFmtMo = class("SummonMasterJiNormalFmtMo", BaseCustomFmtMo)

function SummonMasterJiNormalFmtMo:initParams(activityId, stageId, blessingId)
	self._activityId = activityId
	self._stageId = stageId
	self._blessingId = blessingId

	local cfgStage = SummonMasterJiConfig.instance:getNormalStageCfg(activityId, stageId)

	self._monsterCfg = SummonMasterJiConfig.instance:getMonsterCfg(cfgStage.creepsMasterId)
	self._creepsCfgs = SummonMasterJiConfig.instance:getCreeps(cfgStage.creepsMasterId)
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.WinDesc

	self:setFormCondition(self._monsterCfg.formCondition)
end

function SummonMasterJiNormalFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		SummonMasterJiAgent.instance:sendPM_SummonMasterJiChallengeNormalReq(self._activityId, self._stageId, self._blessingId, form)
	end

	self:setFightHandler(handler, nil)
end

function SummonMasterJiNormalFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function SummonMasterJiNormalFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

return SummonMasterJiNormalFmtMo
