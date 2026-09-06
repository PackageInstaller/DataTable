-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/config/ThrowShellsConfig.lua

module("logic.extensions.throwshells.config.ThrowShellsConfig", package.seeall)

local ThrowShellsConfig = class("ThrowShellsConfig", BaseConfig)

function ThrowShellsConfig:onInit()
	ThrowShellsConfig.super.onInit(self)

	self._paramCfg = nil
	self._actCfg = nil
	self._gameCfg = nil
	self._buyCfg = nil
	self._terrCfg = nil
	self._monsterCfg = nil
	self._propCfg = nil
end

function ThrowShellsConfig:getNames()
	return {
		"throw_shells_common",
		"throw_shells_act",
		"throw_shells_game",
		"throw_shells_buy_times",
		"throw_shells_terrain",
		"throw_shells_monster",
		"throw_shells_prop"
	}
end

function ThrowShellsConfig:handleConfig(name, content)
	if name == "throw_shells_common" then
		self._paramCfg = content
	elseif name == "throw_shells_act" then
		self._actCfg = content
	elseif name == "throw_shells_game" then
		self._gameCfg = content
	elseif name == "throw_shells_buy_times" then
		self._buyCfg = content
	elseif name == "throw_shells_terrain" then
		self._terrCfg = content
	elseif name == "throw_shells_monster" then
		self._monsterCfg = content
	elseif name == "throw_shells_prop" then
		self._propCfg = content
	end
end

function ThrowShellsConfig:getMonsterCfg(id)
	return self._monsterCfg[id]
end

function ThrowShellsConfig:getActCfg(id)
	return self._actCfg[id]
end

function ThrowShellsConfig:getCommonCfg(key)
	return self._paramCfg[key].value
end

function ThrowShellsConfig:getGameCfg(id, stageId)
	return self._gameCfg[id][stageId]
end

function ThrowShellsConfig:getGameCfgList(id)
	local list = {}

	for k, v in pairs(self._gameCfg[id]) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.stageId < b.stageId
	end)

	return list
end

function ThrowShellsConfig:getBuyCfg(id)
	return self._buyCfg[id]
end

function ThrowShellsConfig:getTerrainCfg(id)
	return self._terrCfg[id]
end

function ThrowShellsConfig:getPropCfg(id)
	return self._propCfg[id]
end

ThrowShellsConfig.instance = ThrowShellsConfig.New()

return ThrowShellsConfig
