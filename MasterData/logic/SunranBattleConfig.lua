-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/config/SunranBattleConfig.lua

module("logic.extensions.sunranbattle.config.SunranBattleConfig", package.seeall)

local SunranBattleConfig = class("SunranBattleConfig", BaseConfig)

function SunranBattleConfig:onInit()
	SunranBattleConfig.super.onInit(self)

	self._openTimeCfgs = nil
	self._allStageCfgs = nil
	self._scorePrizeCfgs = nil
	self._stageMoshiCfgs = nil
	self._moshiGroupCfgs = nil
	self._masterTeamCfgs = nil
	self._masterCreepsCfgs = nil
end

function SunranBattleConfig:getNames()
	return {
		"dark_dragon_open_time",
		"dark_dragon_stage",
		"dark_dragon_addition",
		"dark_dragon_score_prize",
		"dark_dragon_difficulty_option",
		"dark_dragon_option_group",
		"dark_dragon_team",
		"dark_dragon_creeps"
	}
end

function SunranBattleConfig:handleConfig(name, content)
	if name == "dark_dragon_open_time" then
		self._openTimeCfgs = content
	elseif name == "dark_dragon_stage" then
		self:_setAllStageCfgs(content.dataList, true)
	elseif name == "dark_dragon_addition" then
		self:_setAllStageCfgs(content.dataList)
	elseif name == "dark_dragon_score_prize" then
		self._scorePrizeCfgs = content
	elseif name == "dark_dragon_difficulty_option" then
		self._stageMoshiCfgs = content
	elseif name == "dark_dragon_option_group" then
		self._moshiGroupCfgs = content
	elseif name == "dark_dragon_team" then
		self._masterTeamCfgs = content
	elseif name == "dark_dragon_creeps" then
		self._masterCreepsCfgs = content
	end
end

function SunranBattleConfig:_setAllStageCfgs(cfgList, isMain)
	self._allStageCfgs = self._allStageCfgs or {}

	for _, cfg in pairs(cfgList or {}) do
		if cfg and checknumber(cfg.seasonId) > 0 and checknumber(cfg.stageId) > 0 then
			if self._allStageCfgs[cfg.seasonId] == nil then
				self._allStageCfgs[cfg.seasonId] = {}
			end

			if self._allStageCfgs[cfg.seasonId][cfg.stageId] == nil then
				self._allStageCfgs[cfg.seasonId][cfg.stageId] = {}
			end

			self._allStageCfgs[cfg.seasonId][cfg.stageId].seasonId = cfg.seasonId
			self._allStageCfgs[cfg.seasonId][cfg.stageId].stageId = cfg.stageId

			if isMain then
				self._allStageCfgs[cfg.seasonId][cfg.stageId].startTimeString = cfg.startTime
				self._allStageCfgs[cfg.seasonId][cfg.stageId].creepsMasterId = cfg.creepsMasterId
				self._allStageCfgs[cfg.seasonId][cfg.stageId].score = cfg.score
				self._allStageCfgs[cfg.seasonId][cfg.stageId].rankId = cfg.rankId
				self._allStageCfgs[cfg.seasonId][cfg.stageId].stageName = cfg.stageName
				self._allStageCfgs[cfg.seasonId][cfg.stageId].stageDes = cfg.stageDes
				self._allStageCfgs[cfg.seasonId][cfg.stageId].mainElves = cfg.mainElves
				self._allStageCfgs[cfg.seasonId][cfg.stageId].unlockTips = cfg.unlockTips
				self._allStageCfgs[cfg.seasonId][cfg.stageId].baseName = cfg.baseName
				self._allStageCfgs[cfg.seasonId][cfg.stageId].baseDesc = cfg.baseDesc
				self._allStageCfgs[cfg.seasonId][cfg.stageId].bestBubble = cfg.bestBubble
				self._allStageCfgs[cfg.seasonId][cfg.stageId].bestElves = cfg.bestElves
			else
				self._allStageCfgs[cfg.seasonId][cfg.stageId].raceIds = cfg.raceIds
				self._allStageCfgs[cfg.seasonId][cfg.stageId].addDes = cfg.addDes
			end

			self._allStageCfgs[cfg.seasonId][cfg.stageId].isOpen = true
			self._allStageCfgs[cfg.seasonId][cfg.stageId].bestScore = 0
		end
	end
end

function SunranBattleConfig:initStageCfgStarTime()
	for k, v in pairs(self._allStageCfgs) do
		for k1, v1 in pairs(v) do
			v1.startTime = v1.startTime or GameUtil.string2time(v1.startTimeString)
		end
	end
end

function SunranBattleConfig:getOpenTimeCfg()
	if self._openTimeCfgs == nil then
		return nil
	end

	for _, cfg in pairs(self._openTimeCfgs) do
		if cfg and GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime) then
			return cfg
		end
	end

	return nil
end

function SunranBattleConfig:getBattleStageCfg(seasonId, stageId)
	if self._allStageCfgs == nil or self._allStageCfgs[seasonId] == nil then
		return
	end

	local list = self._allStageCfgs[seasonId]

	if checknumber(stageId) <= 0 or list[stageId] == nil then
		return list
	end

	return list[stageId]
end

function SunranBattleConfig:getScorePrizeCfg(seasonId)
	if self._scorePrizeCfgs == nil or self._scorePrizeCfgs[seasonId] == nil then
		return
	end

	return self._scorePrizeCfgs[seasonId]
end

function SunranBattleConfig:getStageMoshiCfg(seasonId, stageId)
	if self._stageMoshiCfgs == nil or self._stageMoshiCfgs[seasonId] == nil then
		return
	end

	return self._stageMoshiCfgs[seasonId][stageId]
end

function SunranBattleConfig:getStageMoshiUnlockScore(seasonId, stageId, groupId)
	local list = self:getStageMoshiCfg(seasonId, stageId)

	if list == nil or list[groupId] == nil then
		return 0
	end

	local cfg = list[groupId]

	return cfg.openGroupScore
end

function SunranBattleConfig:getMoshiGroupCfg(groupId, index)
	if self._moshiGroupCfgs == nil or self._moshiGroupCfgs[groupId] == nil then
		return
	end

	local list = self._moshiGroupCfgs[groupId]

	if checknumber(index) <= 0 or list[index] == nil then
		return list
	end

	return list[index]
end

function SunranBattleConfig:getMasterTeamCfg(masterId)
	if self._masterTeamCfgs == nil or self._masterTeamCfgs[masterId] == nil then
		return
	end

	return self._masterTeamCfgs[masterId]
end

function SunranBattleConfig:getMasterCreepsCfg(masterId, creepsId)
	if self._masterCreepsCfgs == nil or self._masterCreepsCfgs[masterId] == nil then
		return
	end

	local list = self._masterCreepsCfgs[masterId]

	if list[creepsId] == nil then
		return list
	end

	return list[creepsId]
end

SunranBattleConfig.instance = SunranBattleConfig.New()

return SunranBattleConfig
