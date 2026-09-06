-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/model/NightFeastNormalCustomFmtMo.lua

module("logic.extensions.nightfeastbosschallenge.model.NightFeastNormalCustomFmtMo", package.seeall)

local NightFeastNormalCustomFmtMo = class("NightFeastNormalCustomFmtMo", BaseCustomFmtMo)

function NightFeastNormalCustomFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local cfg = NightFeastBossConfig.instance:getDailyStageCfg(activityId, stageId)

	self._monsterCfg = NightFeastBossConfig.instance:getMonster(cfg.creepsMasterId)
	self._creepsCfgs = NightFeastBossConfig.instance:getCreeps(cfg.creepsMasterId)
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = ""

	self:setFormCondition(self._monsterCfg.formCondition)
end

function NightFeastNormalCustomFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		BattleFacade.instance:startNightFeastBossBattle(false, self._activityId)
		NightFeastBossChallengeAgent.instance:sendPM_NightFeastBossClgFight4BuffReq(self._activityId, self._stageId, form)
	end

	self:setFightHandler(handler, nil)
end

function NightFeastNormalCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function NightFeastNormalCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

return NightFeastNormalCustomFmtMo
