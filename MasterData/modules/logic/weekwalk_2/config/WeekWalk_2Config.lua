-- chunkname: @modules/logic/weekwalk_2/config/WeekWalk_2Config.lua

module("modules.logic.weekwalk_2.config.WeekWalk_2Config", package.seeall)

local WeekWalk_2Config = class("WeekWalk_2Config", BaseConfig)

function WeekWalk_2Config:reqConfigNames()
	return {
		"weekwalk_ver2",
		"weekwalk_ver2_const",
		"task_weekwalk_ver2",
		"weekwalk_ver2_scene",
		"weekwalk_ver2_element",
		"weekwalk_ver2_cup",
		"weekwalk_ver2_skill",
		"weekwalk_ver2_time",
		"task_weekwalk_ver2",
		"weekwalk_ver2_element_res"
	}
end

function WeekWalk_2Config:onInit()
	return
end

function WeekWalk_2Config:onConfigLoaded(configName, configTable)
	if configName == "task_weekwalk_ver2" then
		self:_initWeekWalkTask()

		return
	end

	if configName == "weekwalk_ver2_cup" then
		self:_initWeekWalkCup()

		return
	end
end

function WeekWalk_2Config:_initWeekWalkCup()
	self._cupInfoMap = {}

	for i, v in ipairs(lua_weekwalk_ver2_cup.configList) do
		self._cupInfoMap[v.layerId] = self._cupInfoMap[v.layerId] or {}

		local layerInfoMap = self._cupInfoMap[v.layerId]

		layerInfoMap[v.fightType] = layerInfoMap[v.fightType] or {}

		table.insert(layerInfoMap[v.fightType], v)
	end
end

function WeekWalk_2Config:getCupTask(layerId, fightType)
	local layerInfoMap = self._cupInfoMap[layerId]

	return layerInfoMap and layerInfoMap[fightType]
end

function WeekWalk_2Config:getWeekWalkTaskList(type)
	return self._taskTypeList[type]
end

function WeekWalk_2Config:_initWeekWalkTask()
	self._taskRewardList = {}
	self._taskTypeList = {}

	for i, v in ipairs(lua_task_weekwalk_ver2.configList) do
		if not self._taskTypeList[v.minTypeId] then
			table.insert(self._taskTypeList[v.minTypeId], v)

			self._taskTypeList[v.minTypeId] = self._taskTypeList[v.minTypeId]

			self:_initTaskReward(v)
		end
	end
end

function WeekWalk_2Config:_initTaskReward(config)
	local listenerParam = config.listenerType == "WeekwalkVer2SeasonCup" and tonumber(config.listenerParam) or tonumber(config.layerId)

	if not listenerParam then
		return
	end

	local bonus = config.bonus

	self._taskRewardList[listenerParam] = self._taskRewardList[listenerParam] or {}

	local rewards = string.split(bonus, "|")

	for i = 1, #rewards do
		local itemCo = string.splitToNumber(rewards[i], "#")

		if itemCo[1] == MaterialEnum.MaterialType.Currency and itemCo[2] == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			self._taskRewardList[listenerParam][config.id] = itemCo[3]
		end
	end
end

function WeekWalk_2Config:getWeekWalkRewardList(layerId)
	return self._taskRewardList[layerId]
end

WeekWalk_2Config.instance = WeekWalk_2Config.New()

return WeekWalk_2Config
