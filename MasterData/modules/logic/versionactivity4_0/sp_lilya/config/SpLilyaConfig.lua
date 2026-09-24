-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/config/SpLilyaConfig.lua

module("modules.logic.versionactivity4_0.sp_lilya.config.SpLilyaConfig", package.seeall)

local SpLilyaConfig = class("SpLilyaConfig", BaseConfig)

function SpLilyaConfig:ctor()
	self._spLilyaGame = nil
	self._spLilyaMonster = nil
	self._spLilyaConst = nil
end

function SpLilyaConfig:reqConfigNames()
	return {
		"activity220_sp_hongnujian_game",
		"activity220_sp_hongnujian_monster",
		"activity220_sp_hongnujian_const"
	}
end

function SpLilyaConfig:onConfigLoaded(configName, configTable)
	if configName == "activity220_sp_hongnujian_game" then
		self._spLilyaGame = configTable
	elseif configName == "activity220_sp_hongnujian_monster" then
		self._spLilyaMonster = configTable
	elseif configName == "activity220_sp_hongnujian_const" then
		self._spLilyaConst = configTable
	end
end

function SpLilyaConfig:getGameCo(activityId, id)
	local episodeConfig = Activity220Config.instance:getEpisodeConfig(activityId, id)

	if not episodeConfig then
		return nil
	end

	if self._spLilyaGame and self._spLilyaGame.configDict[activityId] then
		return self._spLilyaGame.configDict[activityId][episodeConfig.gameId]
	end

	return nil
end

function SpLilyaConfig:getMonsterCo(monsterTeamId, monsterId)
	if self._spLilyaMonster and self._spLilyaMonster.configDict[monsterTeamId] then
		return self._spLilyaMonster.configDict[monsterTeamId][monsterId]
	end

	return nil
end

function SpLilyaConfig:getMonsterCos(monsterTeamId)
	if self._spLilyaMonster then
		return self._spLilyaMonster.configDict[monsterTeamId]
	end

	return nil
end

function SpLilyaConfig:getConstCo(constId)
	if self._spLilyaConst then
		return self._spLilyaConst.configDict[constId]
	end

	return nil
end

function SpLilyaConfig:getConstValue(constId, isToNumber)
	local constCo = self:getConstCo(constId)
	local value = constCo and constCo.value

	if value and isToNumber then
		return tonumber(value)
	end

	return value
end

function SpLilyaConfig:getEpisodeConfig(episodeId)
	local actId = VersionActivity4_0Enum.ActivityId.SpLilya

	return Activity220Config.instance:getEpisodeConfig(actId, episodeId)
end

function SpLilyaConfig:getEpisodeConfigList()
	local actId = VersionActivity4_0Enum.ActivityId.SpLilya

	return Activity220Config.instance:getEpisodeConfigList(actId)
end

function SpLilyaConfig:getEpisodeIndex(episodeId)
	local actId = VersionActivity4_0Enum.ActivityId.SpLilya

	return Activity220Config.instance:getEpisodeIndex(actId, episodeId)
end

SpLilyaConfig.instance = SpLilyaConfig.New()

return SpLilyaConfig
