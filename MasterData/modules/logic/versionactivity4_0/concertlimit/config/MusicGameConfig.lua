-- chunkname: @modules/logic/versionactivity4_0/concertlimit/config/MusicGameConfig.lua

module("modules.logic.versionactivity4_0.concertlimit.config.MusicGameConfig", package.seeall)

local MusicGameConfig = class("MusicGameConfig", BaseConfig)

function MusicGameConfig:reqConfigNames()
	return {
		"musicgame_const",
		"musicgame_note",
		"musicgame_settlement",
		"musicgame_level"
	}
end

function MusicGameConfig:onInit()
	return
end

function MusicGameConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function MusicGameConfig:getConst(constId)
	return lua_musicgame_const.configDict[constId]
end

function MusicGameConfig:getConstValue(constId)
	if not lua_musicgame_const.configDict[constId] then
		return ""
	end

	local value = lua_musicgame_const.configDict[constId].strValue

	return value or ""
end

function MusicGameConfig:getConstNumberValue(id)
	if not lua_musicgame_const.configDict[id] then
		return 0
	end

	local value = tonumber(lua_musicgame_const.configDict[id].strValue)

	return value or 0
end

function MusicGameConfig:getNote(noteId)
	return lua_musicgame_note.configDict[noteId]
end

function MusicGameConfig:getSettlementCos()
	return lua_musicgame_settlement.configDict
end

function MusicGameConfig:getSettlementCo(id)
	return lua_musicgame_settlement.configDict[id]
end

function MusicGameConfig:getCtrlCo()
	local actId = VersionActivity4_0Enum.ActivityId.ConcertMusicGame

	return (Activity234Config.instance:getCtrlCo(actId))
end

function MusicGameConfig:getBonusCos(actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertMusicGame

	return (Activity234Config.instance:getBonusCos(actId))
end

function MusicGameConfig:getBonusLvs(actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertMusicGame

	local bonusCos = self:getBonusCos(actId)
	local lvs = {}

	for _, bonusCo in ipairs(bonusCos) do
		if bonusCo.isBigReward and bonusCo.isBigReward == 1 then
			table.insert(lvs, bonusCo.level)
		end
	end

	return lvs
end

function MusicGameConfig:getBonusCo(bonusId, actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertMusicGame

	return (Activity234Config.instance:getBonusCo(bonusId, actId))
end

function MusicGameConfig:getLevelCos()
	return lua_musicgame_level.configDict
end

function MusicGameConfig:getLevelCo(lv)
	return lua_musicgame_level.configDict[lv]
end

MusicGameConfig.instance = MusicGameConfig.New()

return MusicGameConfig
