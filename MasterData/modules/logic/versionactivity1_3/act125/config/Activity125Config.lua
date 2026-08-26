-- chunkname: @modules/logic/versionactivity1_3/act125/config/Activity125Config.lua

module("modules.logic.versionactivity1_3.act125.config.Activity125Config", package.seeall)

local Activity125Config = class("Activity125Config", BaseConfig)

function Activity125Config:ctor()
	self._configTab = nil
	self._channelValueList = {}
end

function Activity125Config:reqConfigNames()
	return {
		"activity125",
		"activity125_task",
		"activity125_link"
	}
end

function Activity125Config:onConfigLoaded(configName, configTable)
	local funcName = string.format("on%sConfigLoaded", configName)
	local func = self[funcName]

	if func then
		func(self, configName, configTable)
	end
end

function Activity125Config:onactivity125ConfigLoaded(configName, configTable)
	self._configTab = self._configTab or {}
	self._configTab[configName] = configTable.configDict
end

function Activity125Config:onactivity125_taskConfigLoaded(configName, configTable)
	self:__initTaskList(configTable)
end

local sf = string.format
local kListenerType_ReadTask = "ReadTask"

function Activity125Config:__initTaskList(configTable)
	self.__ReadTasksTagTaskCoDict = {}

	for _, CO in ipairs(configTable.configList) do
		local actId = CO.activityId
		local actTable = self.__ReadTasksTagTaskCoDict[actId]

		if not actTable then
			actTable = {}

			for k, v in pairs(ActivityWarmUpEnum.Activity125TaskTag) do
				if isDebugBuild and actTable[v] then
					logError(sf("[Activity125Config]: ActivityWarmUpEnum.Activity125TaskTag error redefined enum value: enum=%s, enum value = %s", k, v))
				end

				actTable[v] = {}
			end

			self.__ReadTasksTagTaskCoDict[actId] = actTable
		end

		if CO.isOnline then
			local taskId = CO.id

			if CO.listenerType == kListenerType_ReadTask then
				local tag = ActivityWarmUpEnum.Activity125TaskTag[CO.tag]

				if not tag then
					logError(sf("[Activity125Config]: lua_activity125_task error actId: %s, id: %s", actId, taskId))
				else
					local tagTable = actTable[tag]

					if tagTable then
						tagTable[taskId] = CO
					else
						logError(sf("[Activity125Config]: unsupported lua_activity125_task actId: %s tag: %s", actId, tag))
					end
				end
			end
		end
	end
end

function Activity125Config:getActConfig(configName, actId)
	if configName and actId and self._configTab and self._configTab[configName] then
		return self._configTab[configName][actId]
	end

	return nil
end

function Activity125Config:getAct125Config(actId)
	return self:getActConfig("activity125", actId)
end

function Activity125Config:getEpisodeConfig(actId, episodeId)
	return self:getAct125Config(actId)[episodeId]
end

Activity125Config.ChannelCfgType = {
	Range = "Range",
	Point = "Point"
}

function Activity125Config:parseChannelCfg(channelCfg, targetFrequencyIndex)
	local channelvalueList = GameUtil.splitString2(channelCfg, false, "|", "#")
	local parseResult = {}
	local lastIndex = 0
	local channelCfgCount = #channelvalueList
	local targetFrequencyValue

	for i = 1, channelCfgCount do
		local part = channelvalueList[i]

		parseResult[i] = {}

		local partLength = #part

		parseResult[i].startIndex = tonumber(part[1])
		parseResult[i].startValue = part[2]

		if partLength == 2 then
			parseResult[i].lastIndex = lastIndex
			lastIndex = parseResult[i].startIndex
			parseResult[i].type = Activity125Config.ChannelCfgType.Point
		elseif partLength == 4 then
			parseResult[i].endIndex = tonumber(part[3])
			parseResult[i].endValue = part[4]
			lastIndex = parseResult[i].endIndex
			parseResult[i].type = Activity125Config.ChannelCfgType.Range
		else
			logError("config error")
		end

		if not targetFrequencyValue then
			local startIndex, endIndex = parseResult[i].startIndex, parseResult[i].endIndex
			local startValue, endValue = parseResult[i].startValue, parseResult[i].endValue
			local tmpvalue = self:getRealFrequencyValue(targetFrequencyIndex, startIndex, startValue, endIndex, endValue)

			targetFrequencyValue = tmpvalue or targetFrequencyValue
		end
	end

	parseResult.targetFrequencyValue = targetFrequencyValue
	parseResult.wholeEndIndex = lastIndex
	parseResult.wholeStartIndex = parseResult[1].startIndex

	return parseResult
end

function Activity125Config:getChannelParseResult(actId, episodeId)
	if self._channelValueList then
		local targetChannelValueList = self._channelValueList[episodeId]
		local channelCfg = self:getEpisodeConfig(actId, episodeId).frequency

		if not self._channelValueList then
			local targetFrequencyIndex = self:getEpisodeConfig(actId, episodeId).targetFrequency

			self._channelValueList[episodeId] = Activity125Config.instance:parseChannelCfg(channelCfg, targetFrequencyIndex)
			targetChannelValueList = self._channelValueList[episodeId]
		end

		return self._channelValueList
	end
end

function Activity125Config:getRealFrequencyValue(targetIndex, startIndex, startValue, endIndex, endValue)
	if not endIndex or not endValue then
		return targetIndex == startIndex and startValue or nil
	end

	if targetIndex < startIndex or endIndex < targetIndex then
		return nil
	end

	return (endValue - startValue) / (endIndex - startIndex) * (targetIndex - startIndex) + startValue
end

function Activity125Config:getChannelIndexRange(actId, episodeId)
	return self:getChannelParseResult(actId, episodeId).wholeStartIndex, self:getChannelParseResult(actId, episodeId).wholeEndIndex
end

function Activity125Config:getEpisodeCount(actId)
	return tabletool.len(self:getAct125Config(actId))
end

function Activity125Config:getTaskCO(id)
	return lua_activity125_task.configDict[id]
end

function Activity125Config:getTaskCO_ReadTask(actId)
	return self.__ReadTasksTagTaskCoDict[actId]
end

function Activity125Config:getTaskCO_ReadTask_Tag(actId, eActivityWarmUpEnum_Activity125TaskTag)
	local actTable = self:getTaskCO_ReadTask(actId)

	return actTable[eActivityWarmUpEnum_Activity125TaskTag]
end

function Activity125Config:getTaskCO_ReadTask_Tag_TaskId(actId, eActivityWarmUpEnum_Activity125TaskTag, taskId)
	local tagTable = self:getTaskCO_ReadTask_Tag(actId, eActivityWarmUpEnum_Activity125TaskTag)

	return tagTable[taskId]
end

function Activity125Config:getLinkCO(id)
	return lua_activity125_link.configDict[id]
end

function Activity125Config:getH5BaseUrl(actId)
	local CO = self:getLinkCO(actId)

	if not CO then
		return
	end

	return SettingsModel.instance:extractByRegion(CO.link)
end

function Activity125Config:getCultivationDestinyActId(fallback)
	return ActivityConfig.instance:getConstAsNum(7, fallback or 13210)
end

function Activity125Config:getWarmUpActId(fallback)
	return ActivityConfig.instance:getConstAsNum(11, fallback or 13443)
end

function Activity125Config:getWarmUp1ActId(fallback)
	return ActivityConfig.instance:getConstAsNum(30900, fallback or 13443)
end

Activity125Config.instance = Activity125Config.New()

return Activity125Config
