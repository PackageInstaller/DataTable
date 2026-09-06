-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/model/NightFeastBossCustomFmtMo.lua

module("logic.extensions.nightfeastbosschallenge.model.NightFeastBossCustomFmtMo", package.seeall)

local NightFeastBossCustomFmtMo = class("NightFeastBossCustomFmtMo", BaseCustomFmtMo)

function NightFeastBossCustomFmtMo:initParams(activityId, bossId)
	self._activityId = activityId

	local cfg = NightFeastBossConfig.instance:getActivityCfg(self._activityId)

	self._bossId = bossId

	local cfgBoss = NightFeastBossConfig.instance:getBossCfg(self._activityId, self._bossId)

	self._creepsMasterId = cfgBoss.creepsMasterId
	self._monsterCfg = NightFeastBossConfig.instance:getMonster(self._creepsMasterId)
	self._creepsCfgs = NightFeastBossConfig.instance:getCreeps(self._creepsMasterId)
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = ""
	self.useMaxFightPower = true

	self:setFormCondition(self._monsterCfg.formCondition)
end

function NightFeastBossCustomFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		BattleFacade.instance:startNightFeastBossBattle(true, self._activityId)
		NightFeastBossChallengeAgent.instance:sendPM_NightFeastBossClgFightBossReq(self._activityId, form, self._bossId)
	end

	self:setFightHandler(handler, nil)
end

function NightFeastBossCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function NightFeastBossCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function NightFeastBossCustomFmtMo:checkPetIsForbit(petMo, baseCheck)
	return NightFeastBossModel.instance:isPetLock(self._activityId, petMo:getDefineId())
end

function NightFeastBossCustomFmtMo:showForbitPetAlert(petMo)
	FloatWordMgr.instance:show("使用过的精灵当日不可再次使用")
end

return NightFeastBossCustomFmtMo
