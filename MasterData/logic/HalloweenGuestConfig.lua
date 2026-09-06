-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/config/HalloweenGuestConfig.lua

module("logic.extensions.halloweenguest.config.HalloweenGuestConfig", package.seeall)

local HalloweenGuestConfig = class("HalloweenGuestConfig", BaseConfig)

function HalloweenGuestConfig:onInit()
	HalloweenGuestConfig.super.onInit(self)

	self._actMonsterCfgs = nil
	self._scenesCfgs = nil
	self._monstersCfgs = nil
	self._prizesCfgs = nil
	self._masterTeamCfgs = nil
	self._masterCreepsCfgs = nil
	self._actBossCfgs = nil
	self._bossTeamCfgs = nil
	self._bossCreepsCfgs = nil
	self._bossBuffsCfgs = nil
	self._bossDamagesCfgs = nil
	self._bossRanksCfgs = nil
end

function HalloweenGuestConfig:getNames()
	return {
		"halloween_scene_monster",
		"halloween_scene_monster_scene",
		"halloween_scene_monster_position",
		"halloween_scene_monster_master",
		"halloween_scene_monster_creeps",
		"halloween_scene_monster_prize",
		"halloween_boss_challenge",
		"halloween_boss_challenge_master",
		"halloween_boss_challenge_creeps",
		"halloween_boss_challenge_buff",
		"halloween_boss_challenge_damage_prize",
		"halloween_boss_challenge_rank_prize"
	}
end

function HalloweenGuestConfig:handleConfig(name, content)
	if name == "halloween_scene_monster" then
		self._actMonsterCfgs = content
	elseif name == "halloween_scene_monster_scene" then
		self._scenesCfgs = content
	elseif name == "halloween_scene_monster_position" then
		self._monstersCfgs = content
	elseif name == "halloween_scene_monster_master" then
		self._masterTeamCfgs = content
	elseif name == "halloween_scene_monster_creeps" then
		self._masterCreepsCfgs = content
	elseif name == "halloween_scene_monster_prize" then
		self._prizesCfgs = content
	elseif name == "halloween_boss_challenge" then
		self._actBossCfgs = content
	elseif name == "halloween_boss_challenge_master" then
		self._bossTeamCfgs = content
	elseif name == "halloween_boss_challenge_creeps" then
		self._bossCreepsCfgs = content
	elseif name == "halloween_boss_challenge_buff" then
		self._bossBuffsCfgs = content
	elseif name == "halloween_boss_challenge_damage_prize" then
		self._bossDamagesCfgs = content
	elseif name == "halloween_boss_challenge_rank_prize" then
		self._bossRanksCfgs = content
	end
end

function HalloweenGuestConfig:getActMonsterCfg(actId)
	if self._actMonsterCfgs == nil then
		return nil
	end

	return self._actMonsterCfgs[checknumber(actId)]
end

function HalloweenGuestConfig:getHalloweenSceneCfg(planId, baseId)
	planId = checknumber(planId)

	if self._scenesCfgs == nil or self._scenesCfgs[planId] == nil then
		return
	end

	local list = self._scenesCfgs[planId]

	baseId = checknumber(baseId)

	if list[baseId] == nil then
		return list
	end

	return list[baseId]
end

function HalloweenGuestConfig:getHalloweenMonsterCfg(planId, posId)
	planId = checknumber(planId)

	if self._monstersCfgs == nil or self._monstersCfgs[planId] == nil then
		return
	end

	local list = self._monstersCfgs[planId]

	posId = checknumber(posId)

	if list[posId] == nil then
		return list
	end

	return list[posId]
end

function HalloweenGuestConfig:getMasterTeamCfg(challId)
	if self._masterTeamCfgs == nil or self._masterTeamCfgs[challId] == nil then
		return
	end

	return self._masterTeamCfgs[challId]
end

function HalloweenGuestConfig:getMasterCreepsCfg(challId, creepsId)
	if self._masterCreepsCfgs == nil or self._masterCreepsCfgs[challId] == nil then
		return
	end

	local list = self._masterCreepsCfgs[challId]

	if list[creepsId] == nil then
		return list
	end

	return list[creepsId]
end

function HalloweenGuestConfig:getHalloweenPrizesCfg(planId)
	if self._prizesCfgs == nil then
		return nil
	end

	planId = planId or 1

	return self._prizesCfgs[planId]
end

function HalloweenGuestConfig:getOpenMonsterActivityId()
	HalloweenGuestModel.instance.monsterActId = nil

	if self._actMonsterCfgs == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(HalloweenGuestModel.instance.monsterActType)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			HalloweenGuestModel.instance.monsterActId = item.activityId

			return item.activityId
		end
	end

	return -3
end

function HalloweenGuestConfig:getActBossCfg(actId)
	if self._actBossCfgs == nil then
		return nil
	end

	return self._actBossCfgs[checknumber(actId)]
end

function HalloweenGuestConfig:getBossTeamCfg(planId, challId)
	planId = checknumber(planId)

	if self._bossTeamCfgs == nil or self._bossTeamCfgs[planId] == nil then
		return
	end

	local list = self._bossTeamCfgs[planId]

	challId = checknumber(challId)

	if list[challId] == nil then
		return list
	end

	return list[challId]
end

function HalloweenGuestConfig:getBossCreepsCfg(bossId, creepsId)
	if self._bossCreepsCfgs == nil or self._bossCreepsCfgs[bossId] == nil then
		return
	end

	local list = self._bossCreepsCfgs[bossId]

	if list[creepsId] == nil then
		return list
	end

	return list[creepsId]
end

function HalloweenGuestConfig:getBossBuffCfg(planId, buffId)
	planId = checknumber(planId)

	if self._bossBuffsCfgs == nil or self._bossBuffsCfgs[planId] == nil then
		return
	end

	local list = self._bossBuffsCfgs[planId]

	buffId = checknumber(buffId)

	if list[buffId] == nil then
		return list
	end

	return list[buffId]
end

function HalloweenGuestConfig:getBossDamagesCfg(planId)
	if self._bossDamagesCfgs == nil then
		return
	end

	planId = checknumber(planId)

	return self._bossDamagesCfgs[planId]
end

function HalloweenGuestConfig:getBossRanksCfg(planId)
	if self._bossRanksCfgs == nil then
		return nil
	end

	planId = planId or 1

	return self._bossRanksCfgs[planId]
end

function HalloweenGuestConfig:isSetBossOpenInfo()
	HalloweenGuestModel.instance:setBossOpenInfo(nil, nil, nil)

	local actId = self:_getOpenBossActivityId()

	if checknumber(actId) <= 0 then
		return false
	end

	local cfg = self:getActBossCfg(actId)

	if cfg == nil then
		return false
	end

	local allCfg = self:getBossTeamCfg(cfg.challengePlanId)

	if allCfg == nil then
		return false
	end

	local nowTime = ServerTime.now()
	local startTime

	for _, item in pairs(allCfg) do
		if item and not string.nilorempty(item.openTime) then
			startTime = GameUtil.string2time(item.openTime)

			if nowTime >= checknumber(startTime) and nowTime < checknumber(startTime) + 86400 then
				HalloweenGuestModel.instance:setBossOpenInfo(actId, item.id, item.challengePlanId)

				return true
			end
		end
	end

	return false
end

function HalloweenGuestConfig:_getOpenBossActivityId()
	if self._actBossCfgs == nil then
		return -1
	end

	local info = HalloweenGuestModel.instance:getBossOpenInfo()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(info.actType)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			RecallTaskModel.instance.bossActId = item.activityId

			return item.activityId
		end
	end

	return -3
end

HalloweenGuestConfig.instance = HalloweenGuestConfig.New()

return HalloweenGuestConfig
