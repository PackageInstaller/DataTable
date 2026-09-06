-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/config/DDragonKConfig.lua

module("logic.extensions.darkdragonknife.config.DDragonKConfig", package.seeall)

local DDragonKConfig = class("DDragonKConfig", BaseConfig)

function DDragonKConfig:onInit()
	DDragonKConfig.super.onInit(self)

	self._actCfg = nil
	self._paramCfg = nil
	self._gameCfg = nil
	self._actorCfg = nil
	self._propCfg = nil
	self._scoreCfg = nil
	self._buyCfg = nil
	self._prizeCfg = nil
end

function DDragonKConfig:getNames()
	return {
		"dark_dragon_knife",
		"dark_dragon_knife_params_define",
		"dark_dragon_knife_game",
		"dark_dragon_knife_actor",
		"dark_dragon_knife_prop",
		"dark_dragon_knife_score",
		"dark_dragon_knife_buy",
		"dark_dragon_knife_prize"
	}
end

function DDragonKConfig:handleConfig(name, content)
	if name == "dark_dragon_knife" then
		self._actCfg = content
	elseif name == "dark_dragon_knife_params_define" then
		self._paramCfg = content
	elseif name == "dark_dragon_knife_game" then
		self._gameCfg = content
	elseif name == "dark_dragon_knife_actor" then
		self._actorCfg = content
	elseif name == "dark_dragon_knife_prop" then
		self._propCfg = content
	elseif name == "dark_dragon_knife_score" then
		self._scoreCfg = content
	elseif name == "dark_dragon_knife_buy" then
		self._buyCfg = content
	elseif name == "dark_dragon_knife_prize" then
		self._prizeCfg = content
	end
end

function DDragonKConfig:getActCfg(id)
	return self._actCfg[id]
end

function DDragonKConfig:getCommonCfg(key)
	return self._paramCfg[key].value
end

function DDragonKConfig:getGameCfgList(id)
	local list = {}

	for k, v in pairs(self._gameCfg[id]) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.gameId < b.gameId
	end)

	return list
end

function DDragonKConfig:getActorCfg(id)
	return self._actorCfg[id]
end

function DDragonKConfig:getPropCfg(planId, id)
	return self._propCfg[planId][id]
end

function DDragonKConfig:getPropList(planId)
	return self._propCfg[planId]
end

function DDragonKConfig:getBuyCfg(planId)
	return self._buyCfg[planId]
end

function DDragonKConfig:getPrizeCfg(id)
	return self._prizeCfg[id]
end

function DDragonKConfig:getScoreCfg(scorePlan)
	return self._scoreCfg[scorePlan]
end

DDragonKConfig.instance = DDragonKConfig.New()

return DDragonKConfig
