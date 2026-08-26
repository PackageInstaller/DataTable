-- chunkname: @modules/logic/versionactivity3_7/travelgo/config/TravelGoConfig.lua

module("modules.logic.versionactivity3_7.travelgo.config.TravelGoConfig", package.seeall)

local TravelGoConfig = class("TravelGoConfig", BaseConfig)

function TravelGoConfig:ctor()
	return
end

function TravelGoConfig:reqConfigNames()
	return {
		"activity220_mle_const",
		"activity220_game",
		"activity220_date",
		"activity220_event",
		"activity220_unit",
		"activity220_attribute",
		"activity220_skill",
		"activity220_buff",
		"activity220_effect"
	}
end

function TravelGoConfig:onConfigLoaded(configName, configTable)
	if configName == "" then
		-- block empty
	end
end

function TravelGoConfig:getConsValue(actId, constId, toNumber)
	local cfgDict = lua_activity220_mle_const.configDict[actId]
	local cfg = cfgDict and cfgDict[constId]

	if cfg then
		if toNumber then
			return tonumber(cfg.value)
		else
			return cfg.value
		end
	else
		logError(string.format("TravelGoConfig:getConsValue no const cfg actId:%s, constId:%s", actId, constId))
	end
end

function TravelGoConfig:getDayCfg(gameId, day)
	return lua_activity220_date.configDict[gameId][day]
end

function TravelGoConfig:getMaxDay(gameId)
	local cfg = lua_activity220_game.configDict[gameId]

	return (cfg or nil) and cfg.levelDay
end

function TravelGoConfig:getEventCfgByType(gameId, type)
	local cfgs = {}
	local dic = lua_activity220_event.configDict[gameId]

	for i, cfg in pairs(dic) do
		if cfg.type == type then
			table.insert(cfgs, cfg)
		end
	end

	return cfgs
end

function TravelGoConfig:getEventCfgByEventId(gameId, eventId)
	return lua_activity220_event.configDict[gameId][eventId]
end

function TravelGoConfig:getSkillsByRare(rare, isNotDefault)
	local list = {}
	local configList = lua_activity220_skill.configList

	for i, cfg in ipairs(configList) do
		if cfg.rare == rare and (not isNotDefault or cfg.skillId ~= TravelGoConst.UltimateSkillId and cfg.skillId ~= TravelGoConst.FrozenSkillId) then
			table.insert(list, cfg)
		end
	end

	return list
end

function TravelGoConfig:isBuffCfg(cfgId)
	return lua_activity220_buff.configDict[cfgId]
end

function TravelGoConfig:isEffectCfg(cfgId)
	return lua_activity220_effect.configDict[cfgId]
end

TravelGoConfig.instance = TravelGoConfig.New()

return TravelGoConfig
