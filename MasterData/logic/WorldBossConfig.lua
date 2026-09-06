-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/config/WorldBossConfig.lua

module("logic.extensions.worldboss.config.WorldBossConfig", package.seeall)

local WorldBossConfig = class("WorldBossConfig", BaseConfig)

function WorldBossConfig:onInit()
	WorldBossConfig.super.onInit(self)

	self._worldBossLayout = nil
	self._worldBossType = nil
	self._worldBossChallengePrize = nil
	self._worldBossRankPrize = nil
	self._worldBossTeam = nil
	self._worldBossCreeps = nil
	self._worldBossCommonConfig = nil
	self._worldBossBuyTimesDefine = nil
end

function WorldBossConfig:getNames()
	return {
		"world_boss_layout",
		"world_boss_type",
		"world_boss_challenge_prize",
		"world_boss_rank_prize",
		"world_boss_team",
		"world_boss_creeps",
		"world_boss_common_config",
		"world_boss_buy_times_define"
	}
end

function WorldBossConfig:handleConfig(name, content)
	if name == "world_boss_layout" then
		self._worldBossLayout = content
		self._worldbossMap = {}

		for i, v in ipairs(content.dataList) do
			self._worldbossMap[v.date] = self._worldbossMap[v.date] or {}

			table.insert(self._worldbossMap[v.date], v.id)
		end
	elseif name == "world_boss_type" then
		self._worldBossType = content
	elseif name == "world_boss_challenge_prize" then
		self._worldBossChallengePrize = content
	elseif name == "world_boss_team" then
		self._worldBossTeam = content
	elseif name == "world_boss_creeps" then
		self._worldBossCreeps = content
	elseif name == "world_boss_common_config" then
		self._worldBossCommonConfig = content
	elseif name == "world_boss_buy_times_define" then
		self._worldBossBuyTimesDefine = content
	elseif name == "world_boss_rank_prize" then
		self._bigRankPrize = content
	end
end

function WorldBossConfig:getWorldBossLayout(date)
	if date then
		local x = {}

		for i, v in ipairs(self._worldbossMap[date] or {}) do
			table.insert(x, self._worldBossLayout[v])
		end

		return x
	end

	return self._worldBossLayout
end

function WorldBossConfig:getWorldBossLayoutByGameDay(now)
	return WorldBossConfig.instance:getWorldBossLayout(GameUtil.formatTimeStamp("%Y-%m-%d", now - 18000))
end

function WorldBossConfig:getWorldBossType()
	return self._worldBossType
end

function WorldBossConfig:getWorldBossChallengePrize(_bossId)
	if not _bossId then
		return
	end

	return self._worldBossChallengePrize[_bossId]
end

function WorldBossConfig:getWorldBossTeam()
	return self._worldBossTeam
end

function WorldBossConfig:getWorldBossTeamCo(id)
	return self._worldBossTeam[id]
end

function WorldBossConfig:getWorldBossCreepsById(creepsMasterId)
	return self._worldBossCreeps[creepsMasterId]
end

function WorldBossConfig:getWorldBossCreeps()
	return self._worldBossCreeps
end

function WorldBossConfig:getWorldBossCommonConfigValueByKey(key)
	if self._worldBossCommonConfig[key] then
		return self._worldBossCommonConfig[key].value
	end

	return ""
end

function WorldBossConfig:getWorldBossCommonConfig()
	return self._worldBossCommonConfig
end

function WorldBossConfig:getWorldBossBuyTimesDefine()
	return self._worldBossBuyTimesDefine
end

function WorldBossConfig:getBigRankPrize(id)
	return self._bigRankPrize[id]
end

WorldBossConfig.instance = WorldBossConfig.New()

return WorldBossConfig
