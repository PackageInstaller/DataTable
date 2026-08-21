-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbietask/config/NewbieTaskConfig.lua

module("logic.extensions.newbietask.config.NewbieTaskConfig", package.seeall)

local M = class("NewbieTaskConfig", BaseConfig)

M.TaskState = {
	Doing = 2,
	CanReceive = 3,
	IsReceived = 1
}

function M:onInit()
	self._const = {}
	self._task = {}
	self._group = {}
	self._maxDay = 0
end

function M:getNames()
	return {
		ConfigName.NewbieTask,
		ConfigName.NewbieTaskStepReward,
		ConfigName.NewbieTaskConstant,
		ConfigName.NewbieTaskGroup
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.NewbieTaskConstant then
		self._const = content
	elseif name == ConfigName.NewbieTask then
		self._task = {}

		for k, v in pairs(content.dataList or {}) do
			if not self._task[v.openDay] then
				self._task[v.openDay] = {}
			end

			table.insert(self._task[v.openDay], v)

			if v.openDay >= self._maxDay then
				self._maxDay = v.openDay
			end
		end

		for openDay, cfgLst in pairs(self._task) do
			table.sort(cfgLst, function(cfgA, cfgB)
				if cfgA.priority ~= cfgB.priority then
					return cfgA.priority > cfgB.priority
				end

				return cfgA.id > cfgB.id
			end)
		end
	elseif name == ConfigName.NewbieTaskGroup then
		for k, v in pairs(content.dataList or {}) do
			self._group[v.group] = v.currencyId
		end
	end
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s", cfgName))
end

function M:getConstByKey(key)
	return self._const[key] and self._const[key].numValue or 0
end

function M:getMaxDay()
	return self._maxDay
end

function M:getTaskLst(openDay)
	if not self._task[openDay] then
		printError(string.format("无法找到openDay[%s]的任务", openDay))

		self._task[openDay] = {}
	end

	return self._task[openDay]
end

function M:getStepRewardLst()
	if not self._stepReward then
		self._stepReward = {}

		local cfgLst = self:getConfigList(ConfigName.NewbieTaskStepReward)

		for _, cfg in pairs(cfgLst or {}) do
			table.insert(self._stepReward, cfg)
		end

		table.sort(self._stepReward, function(cfgA, cfgB)
			if cfgA.group ~= cfgB.group then
				return cfgA.group < cfgB.group
			else
				return cfgA.stepPoint < cfgB.stepPoint
			end
		end)
	end

	return self._stepReward
end

function M:str2ItemIdCount(str)
	if string.nilorempty(str) then
		return 0, 0
	end

	local content = string.match(str, "%d+:%d+")
	local arr = string.splitToNumber(content, ":")

	return arr[1], arr[2]
end

function M:getWeekCurrencyId(week)
	if week then
		return self._group[week]
	end
end

M.instance = M.New()

return M
