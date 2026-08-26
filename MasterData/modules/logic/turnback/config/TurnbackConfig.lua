-- chunkname: @modules/logic/turnback/config/TurnbackConfig.lua

module("modules.logic.turnback.config.TurnbackConfig", package.seeall)

local TurnbackConfig = class("TurnbackConfig", BaseConfig)

function TurnbackConfig:ctor()
	self._turnbackConfig = nil
	self._turnbackSigninConfig = nil
	self._turnbackTaskConfig = nil
	self._turnbackSubModuleConfig = nil
	self._turnbackTaskBonusConfig = nil
	self._turnbackRecommendConfig = nil
end

function TurnbackConfig:reqConfigNames()
	return {
		"turnback",
		"turnback_sign_in",
		"turnback_task",
		"turnback_submodule",
		"turnback_task_bonus",
		"turnback_recommend",
		"turnback_drop",
		"turnback_daily_bonus",
		"turnback_const",
		"turnback_return_reward",
		"turnback_return_range"
	}
end

function TurnbackConfig:onConfigLoaded(configName, configTable)
	if configName == "turnback" then
		self:initTurnbackConfig(configTable)
	elseif configName == "turnback_sign_in" then
		self._turnbackSigninConfig = configTable
	elseif configName == "turnback_task" then
		self._turnbackTaskConfig = configTable
	elseif configName == "turnback_submodule" then
		self._turnbackSubModuleConfig = configTable
	elseif configName == "turnback_task_bonus" then
		self._turnbackTaskBonusConfig = configTable
	elseif configName == "turnback_recommend" then
		self._turnbackRecommendConfig = configTable
	elseif configName == "turnback_drop" then
		self._turnbackDropConfig = configTable
	elseif configName == "turnback_daily_bonus" then
		self._turnbackDailyBonusConfig = configTable
	elseif configName == "turnback_return_reward" then
		self:_initReturnRewardCos(configTable)
	elseif configName == "turnback_return_range" then
		self:_initReturnDayRangeCos(configTable)
	end
end

function TurnbackConfig:initTurnbackConfig(configTable)
	self._turnbackConfig = configTable
	self.turnBackAdditionChapterId = {}

	for turnBackId, cfg in pairs(configTable.configDict) do
		local chapterIdDic = {}
		local additionChapterIds = string.splitToNumber(cfg.additionChapterIds, "#")

		for _, chapterId in ipairs(additionChapterIds) do
			chapterIdDic[chapterId] = true
		end

		self.turnBackAdditionChapterId[turnBackId] = chapterIdDic
	end
end

function TurnbackConfig:isTurnBackAdditionToChapter(turnBackId, chapterId)
	return (turnBackId and chapterId and self.turnBackAdditionChapterId and self.turnBackAdditionChapterId[turnBackId] or nil) and self.turnBackAdditionChapterId[turnBackId][chapterId]
end

function TurnbackConfig:getTurnbackCo(id)
	return self._turnbackConfig.configDict[id]
end

function TurnbackConfig:getTurnbackSignInCo(id)
	return self._turnbackSigninConfig.configDict[id]
end

function TurnbackConfig:getTurnbackSignInDayCo(id, day)
	return self._turnbackSigninConfig.configDict[id][day]
end

function TurnbackConfig:getTurnbackTaskCo(id)
	return self._turnbackTaskConfig.configDict[id]
end

function TurnbackConfig:getTurnbackSubModuleCo(id)
	return self._turnbackSubModuleConfig.configDict[id]
end

function TurnbackConfig:getAllTurnbackTaskBonusCo(turnbackId)
	return self._turnbackTaskBonusConfig.configDict[turnbackId]
end

function TurnbackConfig:getTurnbackTaskBonusCo(turnbackId, id)
	return self._turnbackTaskBonusConfig.configDict[turnbackId][id]
end

function TurnbackConfig:getTurnbackLastBounsPoint(turnbackId)
	local list = self._turnbackTaskBonusConfig.configDict[turnbackId]

	if list then
		return list[#list].needPoint
	end

	return 0
end

function TurnbackConfig:getAllTurnbackTaskBonusCoCount(turnbackId)
	return #self._turnbackTaskBonusConfig.configList[turnbackId]
end

function TurnbackConfig:getTurnbackDailyBonusConfig(turnbackId, day)
	return self._turnbackDailyBonusConfig.configDict[turnbackId][day]
end

function TurnbackConfig:getAllTurnbackSubModules(turnbackid)
	local turnbackConfig = self:getTurnbackCo(turnbackid)

	return (string.splitToNumber(turnbackConfig.subModuleIds, "#"))
end

function TurnbackConfig:getTurnbackSubViewCo(turnbackid, subId)
	local subViewTab = self:getAllTurnbackSubModules(turnbackid)
	local subViewCo

	for _, subViewId in ipairs(subViewTab) do
		if subViewId == subId then
			subViewCo = self:getTurnbackSubModuleCo(subViewId)

			break
		end
	end

	return subViewCo
end

function TurnbackConfig:getAdditionTotalCount(turnbackid)
	local result = 0
	local turnbackConfig = self:getTurnbackCo(turnbackid)

	if turnbackConfig then
		local additionTab = string.splitToNumber(turnbackConfig.additionType, "#")

		result = additionTab[2] or 0
	end

	return result
end

function TurnbackConfig:getAdditionRate(turnbackid)
	local turnbackConfig = self:getTurnbackCo(turnbackid)

	return (turnbackConfig or nil) and turnbackConfig.additionRate
end

function TurnbackConfig:getAdditionDurationDays(turnbackid)
	local turnbackConfig = self:getTurnbackCo(turnbackid)

	return (turnbackConfig or nil) and turnbackConfig.additionDurationDays
end

function TurnbackConfig:getOnlineDurationDays(turnbackid)
	local turnbackConfig = self:getTurnbackCo(turnbackid)

	return (turnbackConfig or nil) and turnbackConfig.onlineDurationDays
end

function TurnbackConfig:getTaskItemBonusPoint(turnbackId, taskId)
	local bonusPointItemType, bonusPointItemId = self:getBonusPointCo(turnbackId)
	local taskConfig = self:getTurnbackTaskCo(taskId)
	local taskBonusItemTab = string.split(taskConfig.bonus, "|")

	for _, item in ipairs(taskBonusItemTab) do
		local itemCoTab = string.split(item, "#")

		if tonumber(itemCoTab[1]) == bonusPointItemType and tonumber(itemCoTab[2]) == bonusPointItemId then
			return tonumber(itemCoTab[3]) or 0
		end
	end
end

function TurnbackConfig:getBonusPointCo(turnbackId)
	local turnbackConfig = self:getTurnbackCo(turnbackId)
	local bonusPointItemCo = string.split(turnbackConfig.bonusPointMaterial, "#")
	local bonusPointItemType = tonumber(bonusPointItemCo[1])
	local bonusPointItemId = tonumber(bonusPointItemCo[2])

	return bonusPointItemType, bonusPointItemId
end

function TurnbackConfig:getAllRecommendCo(turnbackId)
	return self._turnbackRecommendConfig.configDict[turnbackId]
end

function TurnbackConfig:getAllRecommendList(turnbackId)
	local allConfigList = self._turnbackRecommendConfig.configList
	local configList = {}

	for id, config in ipairs(allConfigList) do
		if config.turnbackId == turnbackId then
			table.insert(configList, config)
		end
	end

	return configList
end

function TurnbackConfig:getRecommendCo(turnbackId, id)
	return self._turnbackRecommendConfig.configDict[turnbackId][id]
end

function TurnbackConfig:getSearchTaskCoList(turnbackId)
	local list = {}

	for index, value in ipairs(self._turnbackTaskConfig.configList) do
		if value.listenerType == "TodayOnlineSeconds" and value.turnbackId == turnbackId then
			table.insert(list, value)
		end
	end

	return list
end

function TurnbackConfig:getTaskOneCoByTaskType(turnbackId, type)
	for _, co in ipairs(self._turnbackTaskConfig.configList) do
		if co.turnbackId == turnbackId and co.turnbackTaskType == type then
			return co
		end
	end
end

function TurnbackConfig:getDropCoList()
	return self._turnbackDropConfig.configList
end

function TurnbackConfig:getDropCoById(id)
	return self._turnbackDropConfig.configDict[id]
end

function TurnbackConfig:getDropCoCount()
	return #self._turnbackDropConfig.configList
end

function TurnbackConfig:getConstValue(constId, isValue2, isToNum, defaultValue)
	local co = lua_turnback_const.configDict[constId]

	if co then
		if isValue2 then
			return co.value2
		end

		local value = co.value

		if isToNum then
			return tonumber(value)
		end

		return value
	end

	return defaultValue
end

function TurnbackConfig:_initReturnDayRangeCos(configTable)
	self._returnDayRangeDict = {}

	for _, co in ipairs(configTable.configList) do
		if not string.nilorempty(co.lossDays) then
			self._returnDayRangeDict[co.rangeId] = string.splitToNumber(co.lossDays, "|")
		end
	end
end

function TurnbackConfig:_initReturnRewardCos(configTable)
	self._returnRewardDict = {}

	for _, co in ipairs(configTable.configList) do
		self._returnRewardDict[co.turnbackId] = self._returnRewardDict[co.turnbackId] or {}

		local cos = self._returnRewardDict[co.turnbackId][co.lossDaysRange]

		if not cos then
			cos = {}
			self._returnRewardDict[co.turnbackId][co.lossDaysRange] = {}
		end

		table.insert(cos, co)
	end
end

function TurnbackConfig:getRewardCosByRangeId(turnbackId, rangeId)
	local cos = self._returnRewardDict[turnbackId]

	return cos and cos[rangeId]
end

function TurnbackConfig:getReturnDayLevel(day)
	local maxDay = 0
	local minDay
	local rangeId = 0

	for id, v in pairs(self._returnDayRangeDict) do
		if day >= v[1] and day < v[2] then
			return id
		else
			if maxDay < v[2] then
				maxDay = v[2]
				rangeId = id
			end

			if not minDay or minDay > v[1] then
				minDay = v[1]
			end
		end
	end

	if minDay < day then
		return rangeId
	end
end

TurnbackConfig.instance = TurnbackConfig.New()

return TurnbackConfig
