-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/config/ExcellentClassConfig.lua

module("logic.extensions.sevendays.config.ExcellentClassConfig", package.seeall)

local ExcellentClassConfig = class("ExcellentClassConfig", BaseConfig)

function ExcellentClassConfig:onInit()
	ExcellentClassConfig.super.onInit(self)

	self.taskCfgs = {}
	self.classifyIdList = {}
	self.scoreCfgs = {}
	self.baseCfgs = {}
end

function ExcellentClassConfig:getNames()
	return {
		"excellent_class_task",
		"excellent_class_score",
		"excellent_class_base",
		"excellent_class_task_new",
		"excellent_class_score_new",
		"excellent_class_base_new",
		"excellent_class_task_new_activity"
	}
end

function ExcellentClassConfig:handleConfig(name, content)
	if name == "excellent_class_task" then
		self:ClassificationTaskType(0, content)
	elseif name == "excellent_class_task_new" then
		for k, v in pairs(content) do
			self:ClassificationTaskType(k, v)
		end
	elseif name == "excellent_class_score" then
		self:ScoreCfgsInit(0, content)
	elseif name == "excellent_class_score_new" then
		for k, v in pairs(content) do
			self:ScoreCfgsInit(k, v)
		end
	elseif name == "excellent_class_base" then
		self.baseCfgs[0] = string.split(content.VIEW_TABLE_NAME.value, ",")
	elseif name == "excellent_class_base_new" then
		self.baseCfgs[1] = string.split(content.VIEW_TABLE_NAME.value, ",")
		self._commonCfg = content
	elseif name == "excellent_class_task_new_activity" then
		self._taskNewActCfg = content
	end
end

function ExcellentClassConfig:ClassificationTaskType(key, data)
	if data == nil or next(data) == nil then
		return
	end

	self.taskCfgs[key] = data
	self.classifyIdList[key] = {}

	local tabList = {}
	local subList = {}

	for k, cfg in pairs(data) do
		if type(k) == "number" and cfg then
			if tabList[cfg.tabID] == nil then
				tabList[cfg.tabID] = {}
			end

			table.insert(tabList[cfg.tabID], cfg.subType)

			if subList[cfg.subType] == nil then
				subList[cfg.subType] = {}
			end

			table.insert(subList[cfg.subType], cfg.id)
		end
	end

	for _, list in pairs(tabList or {}) do
		if list and #list > 1 then
			table.sort(list, function(a, b)
				return a < b
			end)
		end
	end

	for _, list in pairs(subList or {}) do
		if list and #list > 1 then
			table.sort(list, function(a, b)
				return a < b
			end)
		end
	end

	for k, value in pairs(tabList or {}) do
		if k and value and #value > 0 then
			self.classifyIdList[key][k] = self.classifyIdList[key][k] or {}

			for i = 1, #value do
				self.classifyIdList[key][k][value[i]] = subList[value[i]]
			end
		end
	end
end

function ExcellentClassConfig:ScoreCfgsInit(key, content)
	self.scoreCfgs[key] = {}

	for _, info in pairs(content) do
		if info and not string.nilorempty(info.prize) then
			table.insert(self.scoreCfgs[key], {
				score = info.needScore,
				goods = info.prize
			})
		end
	end

	if #self.scoreCfgs[key] > 1 then
		table.sort(self.scoreCfgs[key], function(a, b)
			return a.score < b.score
		end)
	end

	for i, v in ipairs(self.scoreCfgs[key]) do
		v.prizeId = i
	end
end

function ExcellentClassConfig:GetClassAllTaskCfgs(key)
	return self.taskCfgs[key]
end

function ExcellentClassConfig:GetClassTaskCfgById(key, taskId)
	return self.taskCfgs[key][taskId]
end

function ExcellentClassConfig:GetClassAllTabTask(key, tabId)
	if tabId == nil then
		return self.classifyIdList[key]
	end

	return self.classifyIdList[key][tabId]
end

function ExcellentClassConfig:GetClassAllSubTask(key, tabId, subId)
	local tabList = self:GetClassAllTabTask(key, tabId)

	if tabList == nil then
		return nil
	end

	return tabList[subId]
end

function ExcellentClassConfig:GetClsaaScoreCfgs(key)
	return self.scoreCfgs[key]
end

function ExcellentClassConfig:GetViewTableNames(key)
	return (key > 0 or nil) and (self.baseCfgs[1] or self.baseCfgs[0])
end

function ExcellentClassConfig:getRedPointIdByActId(activityId)
	local cfg = self._taskNewActCfg[activityId]

	if cfg then
		return cfg.redPointId
	end

	return nil
end

function ExcellentClassConfig:getCommonCfgByKey(key)
	if self._commonCfg[key] then
		return self._commonCfg[key].value
	end

	return ""
end

ExcellentClassConfig.instance = ExcellentClassConfig.New()

return ExcellentClassConfig
