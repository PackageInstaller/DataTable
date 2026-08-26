-- chunkname: @modules/logic/versionactivity3_6/yami/config/V3a6YaMiConfig.lua

module("modules.logic.versionactivity3_6.yami.config.V3a6YaMiConfig", package.seeall)

local V3a6YaMiConfig = class("V3a6YaMiConfig", BaseConfig)

function V3a6YaMiConfig:reqConfigNames()
	return {
		"activity231_const",
		"activity231_material",
		"activity231_invention",
		"activity231_researcher",
		"activity231_event",
		"activity231_talk",
		"activity231_mission",
		"activity231_seat",
		"activity231_task",
		"activity231_rating",
		"activity231_level",
		"activity231_ai",
		"activity231_skill",
		"activity231_effect",
		"activity231_buff"
	}
end

function V3a6YaMiConfig:onInit()
	return
end

function V3a6YaMiConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function V3a6YaMiConfig:activity231_constConfigLoaded(configTable)
	return
end

function V3a6YaMiConfig:getConstConfig(constId, nilError)
	local actId = V3a6YaMiModel.instance:getActId()
	local cfg = lua_activity231_const.configDict[actId][constId]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getArcadeConstCfg error, cfg is nil, constId:%s", constId))
	end

	return cfg
end

function V3a6YaMiConfig:getConstValue2(constId, isToNumber, delimiter)
	local result
	local config = self:getConstConfig(constId, true)

	if config then
		result = config.value2

		if not string.nilorempty(delimiter) then
			result = isToNumber and string.splitToNumber(result, delimiter) or string.split(result, delimiter)
		elseif isToNumber then
			result = tonumber(result)
		end
	end

	return result
end

function V3a6YaMiConfig:getConstValueByConst(constId)
	self._constValues = self._constValues or {}

	if not self._constValues[constId] then
		local co = self:getConstConfig(constId)

		if co then
			self._constValues[constId] = co.value
		end
	end

	return self._constValues[constId]
end

function V3a6YaMiConfig:activity231_talkConfigLoaded(configTable)
	self._heroTalkCoDict = {}

	for _, co in ipairs(configTable.configList) do
		local dict = self._heroTalkCoDict[co.researcherId]

		if not dict then
			dict = {}
			self._heroTalkCoDict[co.researcherId] = dict
		end

		dict[co.trigger] = dict[co.trigger] or {}

		table.insert(dict[co.trigger], co)
	end
end

function V3a6YaMiConfig:getHeroTalkCoList(heroId)
	return self._heroTalkCoDict and self._heroTalkCoDict[heroId]
end

function V3a6YaMiConfig:getLevelCo(level)
	local actId = V3a6YaMiModel.instance:getActId()

	return lua_activity231_level.configDict[actId][level]
end

function V3a6YaMiConfig:getNeedExpLevelCos()
	local actId = V3a6YaMiModel.instance:getActId()

	return lua_activity231_level.configDict[actId]
end

function V3a6YaMiConfig:getMaterialCo(id)
	local actId = V3a6YaMiModel.instance:getActId()

	return lua_activity231_material.configDict[actId][id]
end

function V3a6YaMiConfig:getMissionCo(id)
	return lua_activity231_mission.configDict[id]
end

function V3a6YaMiConfig:getSeatCo(id)
	local actId = V3a6YaMiModel.instance:getActId()

	return lua_activity231_seat.configDict[actId][id]
end

function V3a6YaMiConfig:getInventionCo(id)
	local actId = V3a6YaMiModel.instance:getActId()

	return lua_activity231_invention.configDict[actId][id]
end

function V3a6YaMiConfig:getRatingCo(id)
	local actId = V3a6YaMiModel.instance:getActId()

	return lua_activity231_rating.configDict[actId][id]
end

function V3a6YaMiConfig:getEventCo(id)
	local actId = V3a6YaMiModel.instance:getActId()

	return lua_activity231_event.configDict[actId][id]
end

function V3a6YaMiConfig:getAICo(id)
	local actId = V3a6YaMiModel.instance:getActId()

	return lua_activity231_ai.configDict[actId][id]
end

function V3a6YaMiConfig:getSkillCo(id)
	return lua_activity231_skill.configDict[id]
end

function V3a6YaMiConfig:getEffectCo(id)
	return lua_activity231_effect.configDict[id]
end

function V3a6YaMiConfig:getMissionCos()
	local actId = V3a6YaMiModel.instance:getActId()

	return lua_activity231_mission.configDict[actId]
end

function V3a6YaMiConfig:getTaskCo(id)
	return lua_activity231_task.configDict[id]
end

V3a6YaMiConfig.instance = V3a6YaMiConfig.New()

return V3a6YaMiConfig
