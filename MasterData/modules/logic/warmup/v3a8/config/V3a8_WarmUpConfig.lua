-- chunkname: @modules/logic/warmup/v3a8/config/V3a8_WarmUpConfig.lua

module("modules.logic.warmup.v3a8.config.V3a8_WarmUpConfig", package.seeall)

local V3a8_WarmUpConfig = class("V3a8_WarmUpConfig", BaseConfig)

local function _constCO(id)
	return lua_v3a8_warmup_const.configDict[id]
end

function V3a8_WarmUpConfig:reqConfigNames()
	return {
		"v3a8_warmup_play",
		"v3a8_warmup_const"
	}
end

function V3a8_WarmUpConfig:actId()
	return ActivityEnum.Activity.V3a8_WarmUp or 13818
end

function V3a8_WarmUpConfig:onConfigLoaded(configName, configTable)
	if configName == "v3a8_warmup_play" then
		self.__v3a8_warmup_play = nil
		self.__markSet = nil

		self:__init_v3a8_warmup_play(configTable)
	end
end

function V3a8_WarmUpConfig:__init_v3a8_warmup_play(configTable)
	if self.__v3a8_warmup_play then
		return
	end

	self.__v3a8_warmup_play = {}

	for _, CO in ipairs(lua_v3a8_warmup_play.configList) do
		local activityId = CO.activityId

		self.__v3a8_warmup_play[activityId] = self.__v3a8_warmup_play[activityId] or {}

		table.insert(self.__v3a8_warmup_play[activityId], CO)
	end

	for _, list in pairs(self.__v3a8_warmup_play) do
		table.sort(list, function(a, b)
			return a.day < b.day
		end)
	end
end

function V3a8_WarmUpConfig:getCOListCount(actId)
	local list = self:getCOList(actId)

	return #list
end

function V3a8_WarmUpConfig:getCOList(actId)
	self:__init_v3a8_warmup_play()

	return self.__v3a8_warmup_play[actId] or {}
end

function V3a8_WarmUpConfig:getPlayCO(actId, day)
	local list = self:getCOList(actId)

	return list[day]
end

function V3a8_WarmUpConfig:getConstAsNum(id, fallback)
	local CO = _constCO(id)

	if not CO then
		return fallback
	end

	return tonumber(CO.strValue) or fallback
end

function V3a8_WarmUpConfig:getSentenceInBetweenSec()
	return self:getConstAsNum(1, 1)
end

function V3a8_WarmUpConfig:getCutSceneWaitSec()
	return self:getConstAsNum(2, 1)
end

V3a8_WarmUpConfig.instance = V3a8_WarmUpConfig.New()

return V3a8_WarmUpConfig
