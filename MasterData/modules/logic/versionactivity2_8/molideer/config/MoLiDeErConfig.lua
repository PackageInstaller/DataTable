-- chunkname: @modules/logic/versionactivity2_8/molideer/config/MoLiDeErConfig.lua

module("modules.logic.versionactivity2_8.molideer.config.MoLiDeErConfig", package.seeall)

local MoLiDeErConfig = class("MoLiDeErConfig", BaseConfig)

function MoLiDeErConfig:reqConfigNames()
	return {
		"activity194_const",
		"activity194_episode",
		"activity194_game",
		"activity194_event",
		"activity194_option",
		"activity194_option_result",
		"activity194_item",
		"activity194_team",
		"activity194_buff",
		"activity194_task",
		"activity194_progress_desc",
		"activity194_progress"
	}
end

function MoLiDeErConfig:onInit()
	self._taskDict = {}
	self._eventGroupDic = {}
	self._eventCostDic = {}
	self._optionResultCostDic = {}
	self._optionConditionDic = {}
	self._optionCostDic = {}
end

function MoLiDeErConfig:onConfigLoaded(configName, configTable)
	if configName == "activity194_const" then
		self._constConfig = configTable
	elseif configName == "activity194_episode" then
		self._episodeConfig = configTable
	elseif configName == "activity194_game" then
		self._gameConfig = configTable
	elseif configName == "activity194_event" then
		self._eventConfig = configTable

		self:_initEventConfig()
	elseif configName == "activity194_option" then
		self._optionConfig = configTable

		self:_initOptionConfig()
	elseif configName == "activity194_option_result" then
		self._optionResultConfig = configTable

		self:_initOptionResultConfig()
	elseif configName == "activity194_item" then
		self._itemConfig = configTable
	elseif configName == "activity194_team" then
		self._teamConfig = configTable
	elseif configName == "activity194_buff" then
		self._buffConfig = configTable
	elseif configName == "activity194_task" then
		self._taskConfig = configTable
	elseif configName == "activity194_progress" then
		self._progressConfig = configTable
	elseif configName == "activity194_progress_desc" then
		self._progressDescConfig = configTable

		self:_initProgressDescConfig()
	end
end

function MoLiDeErConfig:getTaskByActId(activityId)
	local list = self._taskDict[activityId]

	if not list then
		list = {}

		for _, co in ipairs(self._taskConfig.configList) do
			if co.activityId == activityId then
				table.insert(list, co)
			end
		end

		self._taskDict[activityId] = list
	end

	return list
end

function MoLiDeErConfig:getEventConfigByGroupId(groupId)
	if self._eventGroupDic == nil or self._eventGroupDic[groupId] == nil then
		logError("莫莉德尔角色活动 没有对应事件库数据 id:" .. groupId)

		return nil
	end

	return self._eventGroupDic[groupId]
end

function MoLiDeErConfig:getEpisodeConfig(actId, episodeId)
	return self:_get2PrimarykeyCo(self._episodeConfig, actId, episodeId)
end

function MoLiDeErConfig:getConstConfig(actId, episodeId)
	return self:_get2PrimarykeyCo(self._constConfig, actId, episodeId)
end

function MoLiDeErConfig:getGameConfig(gameId)
	if self._gameConfig == nil or self._gameConfig.configDict == nil then
		return nil
	end

	return self._gameConfig.configDict[gameId]
end

function MoLiDeErConfig:getOptionConfig(optionId)
	if self._optionConfig == nil or self._optionConfig.configDict == nil then
		return nil
	end

	return self._optionConfig.configDict[optionId]
end

function MoLiDeErConfig:getOptionResultConfig(optionResultId)
	if self._optionResultConfig == nil or self._optionResultConfig.configDict == nil then
		return nil
	end

	return self._optionResultConfig.configDict[optionResultId]
end

function MoLiDeErConfig:getItemConfig(itemId)
	if self._itemConfig == nil or self._itemConfig.configDict == nil then
		return nil
	end

	return self._itemConfig.configDict[itemId]
end

function MoLiDeErConfig:getTeamConfig(teamId)
	if self._teamConfig == nil or self._teamConfig.configDict == nil then
		return nil
	end

	return self._teamConfig.configDict[teamId]
end

function MoLiDeErConfig:getEventConfig(eventId)
	if self._eventConfig == nil or self._eventConfig.configDict == nil then
		return nil
	end

	return self._eventConfig.configDict[eventId]
end

function MoLiDeErConfig:getBuffConfig(buffId)
	if self._buffConfig == nil or self._buffConfig.configDict == nil then
		return nil
	end

	return self._buffConfig.configDict[buffId]
end

function MoLiDeErConfig:getItemConfig(itemId)
	if self._itemConfig == nil or self._itemConfig.configDict == nil then
		return nil
	end

	return self._itemConfig.configDict[itemId]
end

function MoLiDeErConfig:getProgressConfig(optionId)
	if self._progressConfig == nil or self._progressConfig.configDict == nil then
		return nil
	end

	return self._progressConfig.configDict[optionId]
end

function MoLiDeErConfig:getProgressDescConfigById(gameId, targetId)
	if self._progressDescDic == nil or self._progressDescDic[gameId] == nil then
		return nil
	end

	return self._progressDescDic[gameId][targetId]
end

function MoLiDeErConfig:getProgressDescConfig(condition)
	if self._progressDescConfig == nil or self._progressDescConfig.configDict == nil then
		return nil
	end

	return self._progressDescConfig.configDict[condition]
end

function MoLiDeErConfig:getEpisodeDicById(actId)
	return self:_get2PrimarykeyDic(self._episodeConfig, actId)
end

function MoLiDeErConfig:getEpisodeListById(actId)
	return self:_findListByActId(self._episodeConfig, actId)
end

function MoLiDeErConfig:_findListByActId(configTable, actId)
	if configTable and configTable.configList then
		local list = {}

		for _, co in ipairs(configTable.configList) do
			if co.activityId == actId then
				table.insert(list, co)
			end
		end

		return list
	end

	return nil
end

function MoLiDeErConfig:getOptionResultCost(optionResultId, type)
	if self._optionResultCostDic == nil or self._optionResultCostDic[optionResultId] == nil then
		return 0
	end

	return self._optionResultCostDic[optionResultId][type] or 0
end

function MoLiDeErConfig:getOptionCost(optionId, type)
	if self._optionCostDic == nil or self._optionCostDic[optionId] == nil then
		return 0
	end

	return self._optionCostDic[optionId][type] or 0
end

function MoLiDeErConfig:getOptionCondition(optionId, type)
	if self._optionConditionDic == nil or self._optionConditionDic[optionId] == nil then
		return nil
	end

	return self._optionConditionDic[optionId][type]
end

function MoLiDeErConfig:_get2PrimarykeyCo(configTable, key1, key2)
	if configTable and configTable.configDict then
		local configDict = configTable.configDict[key1]

		return configDict and configDict[key2]
	end

	return nil
end

function MoLiDeErConfig:_get2PrimarykeyDic(configTable, key1)
	if configTable and configTable.configDict then
		local configDict = configTable.configDict[key1]

		return configDict and configDict.configDict
	end

	return nil
end

function MoLiDeErConfig:_initEventConfig()
	if self._eventConfig then
		for _, config in ipairs(self._eventConfig.configList) do
			local eventGroupId = tonumber(config.eventGroup)
			local eventGroupDic

			if self._eventGroupDic[eventGroupId] == nil then
				eventGroupDic = {}
				self._eventGroupDic[eventGroupId] = eventGroupDic
			else
				eventGroupDic = self._eventGroupDic[eventGroupId]
			end

			if eventGroupDic[config.eventId] == nil then
				eventGroupDic[config.eventId] = config
			else
				logError("莫莉德尔角色活动 事件id重复" .. config.eventId)
			end
		end
	end
end

function MoLiDeErConfig:_initOptionResultConfig()
	if self._optionResultConfig then
		local optionCostDic = self._optionResultCostDic

		for _, config in ipairs(self._optionResultConfig.configList) do
			local costParam = string.split(config.effect, "|")

			if optionCostDic[config.resultId] == nil then
				local singleCostDic = {}

				for _, singleParam in ipairs(costParam) do
					local data = string.splitToNumber(singleParam, "#")
					local type = data[1]

					if type == MoLiDeErEnum.OptionCostType.Execution then
						local num = data[2]

						if singleCostDic[type] == nil then
							singleCostDic[type] = -num
						else
							logError("莫莉德尔角色活动 选项效果id重复 id:" .. config.resultId .. "typeId:" .. type)
						end
					end
				end

				optionCostDic[config.resultId] = singleCostDic
			else
				logError("莫莉德尔角色活动 选项结果id重复" .. config.resultId)
			end
		end

		self._optionResultCostDic = optionCostDic
	end
end

function MoLiDeErConfig:_initOptionConfig()
	if self._optionConfig then
		local optionConditionDic = self._optionConditionDic
		local optionCostDic = self._optionCostDic

		for _, config in ipairs(self._optionConfig.configList) do
			local optionId = config.optionId
			local conditionParam = string.split(config.optionRestriction, "|")

			if optionConditionDic[optionId] == nil then
				local singleConditionDic = {}

				for _, singleParam in ipairs(conditionParam) do
					local data = string.splitToNumber(singleParam, "#")
					local typeConditionDic = {}
					local type = data[1]

					if type == MoLiDeErEnum.OptionConditionType.Team or type == MoLiDeErEnum.OptionConditionType.Item and singleConditionDic[type] == nil then
						singleConditionDic[type] = typeConditionDic

						for i = 2, #data do
							local id = data[i]

							typeConditionDic[id] = id
						end
					end
				end

				optionConditionDic[optionId] = singleConditionDic
			else
				logError("莫莉德尔角色活动 选项id重复" .. optionId)
			end

			if config.effect ~= nil and not string.nilorempty(config.effect) and optionCostDic[optionId] == nil then
				local costParams = string.split(config.effect, "|")

				for _, param in ipairs(costParams) do
					local data = string.splitToNumber(param, "#")
					local type = data[1]

					if optionCostDic[optionId] == nil then
						optionCostDic[optionId] = {}
					end

					optionCostDic[optionId][type] = data[2]
				end
			end
		end
	end
end

function MoLiDeErConfig:_initProgressDescConfig()
	local progressDescDic = {}

	for _, config in ipairs(self._progressDescConfig.configList) do
		local conditionData = string.splitToNumber(config.condition, "#")

		if conditionData[2] then
			local gameId = conditionData[1]
			local targetId = conditionData[2]
			local targetDic

			if progressDescDic[gameId] == nil then
				targetDic = {}
				progressDescDic[gameId] = targetDic
			else
				targetDic = progressDescDic[gameId]
			end

			targetDic[targetId] = config
		else
			logError("莫莉德尔 角色活动 玩法目标提示文本 主键数据缺失" .. config.condition)
		end
	end

	self._progressDescDic = progressDescDic
end

MoLiDeErConfig.instance = MoLiDeErConfig.New()

return MoLiDeErConfig
