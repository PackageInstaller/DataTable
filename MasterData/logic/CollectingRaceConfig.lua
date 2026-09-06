-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingrace/config/CollectingRaceConfig.lua

module("logic.extensions.collectingrace.config.CollectingRaceConfig", package.seeall)

local CollectingRaceConfig = class("CollectingRaceConfig", BaseConfig)

function CollectingRaceConfig:onInit()
	CollectingRaceConfig.super.onInit(self)

	self._collecting_race = nil
	self._collecting_race_array = nil
end

function CollectingRaceConfig:getNames()
	return {
		"collecting_race"
	}
end

function CollectingRaceConfig:handleConfig(name, content)
	if name == "collecting_race" then
		self._collecting_race = content
		self._collecting_race_array = {}

		for k, v in pairs(self._collecting_race) do
			if checknumber(k) > 0 then
				table.insert(self._collecting_race_array, v)
			end
		end
	end
end

function CollectingRaceConfig:getShowRaceArray(viewName)
	local arrayResult = {}

	for i, v in ipairs(self._collecting_race_array) do
		if v.viewName == viewName then
			table.insert(arrayResult, v)
		end
	end

	return arrayResult
end

function CollectingRaceConfig:getRaceArrayDataList()
	return self._collecting_race.dataList
end

function CollectingRaceConfig:getOnlineRaceArray()
	local arrayResult = {}
	local actDefineInstance = ActivityDefineController.instance
	local actType = GameEnum.ActivityType.COLLECTING_RACE

	for i, v in ipairs(self._collecting_race_array) do
		if actDefineInstance:isInActivityTimeById(actType, v.activityId) then
			table.insert(arrayResult, v)
		end
	end

	return arrayResult
end

CollectingRaceConfig.instance = CollectingRaceConfig.New()

return CollectingRaceConfig
