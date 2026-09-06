-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolammgame/config/DuoLaMMGameConfig.lua

module("logic.extensions.duolammgame.config.DuoLaMMGameConfig", package.seeall)

local DuoLaMMGameConfig = class("DuoLaMMGameConfig", BaseConfig)

function DuoLaMMGameConfig:onInit()
	DuoLaMMGameConfig.super.onInit(self)
end

function DuoLaMMGameConfig:getNames()
	return {
		"duo_la_mm_game_activity",
		"duo_la_mm_game_piece",
		"duo_la_mm_buy_game_times",
		"duo_la_mm_buy_relive_times",
		"duo_la_mm_single_game_plan",
		"duo_la_mm_single_drop_plan"
	}
end

function DuoLaMMGameConfig:handleConfig(name, content)
	if name == "duo_la_mm_game_activity" then
		self._actCfgs = content
	elseif name == "duo_la_mm_game_piece" then
		self._pieceCfgs = content
	elseif name == "duo_la_mm_buy_game_times" then
		self._buyGameTimeCfgs = content
	elseif name == "duo_la_mm_buy_relive_times" then
		self._buyReliveTimeCfgs = content
	elseif name == "duo_la_mm_single_game_plan" then
		self._gameCfgs = content
	elseif name == "duo_la_mm_single_drop_plan" then
		self._dropCfgs = content
	end
end

function DuoLaMMGameConfig:getActCfg(actId)
	return self._actCfgs[actId]
end

function DuoLaMMGameConfig:getGamePieceCfgs(actId)
	return self._pieceCfgs[actId]
end

function DuoLaMMGameConfig:getBuyGameTimesCfgs(actId)
	return self._buyGameTimeCfgs[actId]
end

function DuoLaMMGameConfig:getBuyReliveTimesCfgs(actId)
	return self._buyReliveTimeCfgs[actId]
end

function DuoLaMMGameConfig:getGameCfgs(planId)
	return self._gameCfgs[planId]
end

function DuoLaMMGameConfig:getDropCfgs()
	return self._dropCfgs
end

DuoLaMMGameConfig.instance = DuoLaMMGameConfig.New()

return DuoLaMMGameConfig
