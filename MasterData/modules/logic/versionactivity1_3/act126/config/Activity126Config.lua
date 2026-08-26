-- chunkname: @modules/logic/versionactivity1_3/act126/config/Activity126Config.lua

module("modules.logic.versionactivity1_3.act126.config.Activity126Config", package.seeall)

local Activity126Config = class("Activity126Config", BaseConfig)

function Activity126Config:ctor()
	return
end

function Activity126Config:reqConfigNames()
	return {
		"activity126_buff",
		"activity126_const",
		"activity126_dreamland",
		"activity126_dreamland_card",
		"activity126_episode_daily",
		"activity126_star",
		"activity126_horoscope"
	}
end

function Activity126Config:onConfigLoaded(configName, configTable)
	if configName == "activity126_dreamland" then
		self:_dealDreamlandTask()
	end
end

function Activity126Config:getConst(activityId, id)
	return lua_activity126_const.configDict[activityId][id]
end

function Activity126Config:getHoroscopeConfig(activityId, id)
	return lua_activity126_horoscope.configDict[id][activityId]
end

function Activity126Config:getStarConfig(activityId, id)
	return lua_activity126_star.configDict[id][activityId]
end

function Activity126Config:_dealDreamlandTask()
	self._taskDic = {}

	for i, v in ipairs(lua_activity126_dreamland.configList) do
		local battleIdArr = string.splitToNumber(v.battleIds, "#")

		for index, battleId in ipairs(battleIdArr) do
			self._taskDic[battleId] = v
		end
	end
end

function Activity126Config:getDramlandTask(battleId)
	if self._taskeDic then
		return self._taskDic[battleId]
	end

	self:_dealDreamlandTask()

	return self._taskDic[battleId]
end

Activity126Config.instance = Activity126Config.New()

return Activity126Config
