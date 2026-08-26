-- chunkname: @modules/logic/toughbattle/config/ToughBattleConfig.lua

module("modules.logic.toughbattle.config.ToughBattleConfig", package.seeall)

local ToughBattleConfig = class("ToughBattleConfig", BaseConfig)

function ToughBattleConfig:onInit()
	self._diffcultToCOs = nil
	self._storyCOs = nil
	self._allActEpisodeIds = nil
	self._episodeIdToCO = nil
end

function ToughBattleConfig:reqConfigNames()
	return {
		"activity158_challenge",
		"activity158_const",
		"activity158_evaluate",
		"siege_battle",
		"siege_battle_word",
		"siege_battle_hero"
	}
end

function ToughBattleConfig:getRoundDesc(round)
	for _, co in ipairs(lua_activity158_evaluate.configList) do
		if round <= co.round then
			return co.desc
		end
	end

	return ""
end

function ToughBattleConfig:isActEleCo(elementCo)
	if not elementCo then
		return false
	end

	if elementCo.type ~= DungeonEnum.ElementType.ToughBattle then
		return false
	end

	local actId = tonumber(elementCo.param) or 0

	if actId ~= 0 then
		return true
	end

	return false
end

function ToughBattleConfig:getConstValue(id, isNumber)
	local value = ""
	local co = lua_activity158_const.configDict[id]

	if co then
		value = co.value
	end

	if isNumber then
		return tonumber(value) or 0
	else
		return value
	end
end

function ToughBattleConfig:_initActInfo()
	if not self._episodeIdToCO then
		self._allActEpisodeIds = {}
		self._episodeIdToCO = {}

		for _, co in ipairs(lua_activity158_challenge.configList) do
			self._allActEpisodeIds[co.episodeId] = true
			self._episodeIdToCO[co.episodeId] = co
		end

		for _, co in ipairs(lua_siege_battle.configList) do
			self._episodeIdToCO[co.episodeId] = co
		end
	end
end

function ToughBattleConfig:isActStage2EpisodeId(episodeId)
	local co = self:getCoByEpisodeId(episodeId)

	if not co then
		return false
	end

	return co.stage == 2 and self._allActEpisodeIds[co.episodeId]
end

function ToughBattleConfig:isStage1EpisodeId(episodeId)
	local co = self:getCoByEpisodeId(episodeId)

	if not co then
		return false
	end

	return co.stage == 1
end

function ToughBattleConfig:isActEpisodeId(episodeId)
	self:_initActInfo()

	return self._allActEpisodeIds[episodeId]
end

function ToughBattleConfig:getCoByEpisodeId(episodeId)
	self:_initActInfo()

	return self._episodeIdToCO[episodeId]
end

function ToughBattleConfig:getCOByDiffcult(diffcultId)
	if not self._diffcultToCOs then
		self._diffcultToCOs = {}

		for _, co in ipairs(lua_activity158_challenge.configList) do
			if not self._diffcultToCOs[co.difficulty] then
				self._diffcultToCOs[co.difficulty] = self._diffcultToCOs[co.difficulty]

				if co.stage == 2 then
					self._diffcultToCOs[co.difficulty].stage2 = co
				else
					self._diffcultToCOs[co.difficulty].stage1 = self._diffcultToCOs[co.difficulty].stage1 or {}
					self._diffcultToCOs[co.difficulty].stage1[co.sort] = co
				end
			end
		end
	end

	return self._diffcultToCOs[diffcultId]
end

function ToughBattleConfig:getStoryCO()
	if not self._storyCOs then
		self._storyCOs = {}

		for _, co in ipairs(lua_siege_battle.configList) do
			if co.stage == 2 then
				self._storyCOs.stage2 = co
			else
				self._storyCOs.stage1 = self._storyCOs.stage1 or {}
				self._storyCOs.stage1[co.sort] = co
			end
		end
	end

	return self._storyCOs
end

ToughBattleConfig.instance = ToughBattleConfig.New()

return ToughBattleConfig
