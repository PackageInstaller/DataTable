-- chunkname: @modules/logic/versionactivity2_5/act186/config/Activity186Config.lua

module("modules.logic.versionactivity2_5.act186.config.Activity186Config", package.seeall)

local Activity186Config = class("Activity186Config", BaseConfig)

function Activity186Config:reqConfigNames()
	return {
		"activity186_const",
		"actvity186_stage",
		"actvity186_daily_group",
		"actvity186_task",
		"actvity186_like",
		"actvity186_mini_game",
		"actvity186_mini_game_reward",
		"actvity186_mini_game_question",
		"actvity186_voice",
		"actvity186_milestone_bonus"
	}
end

function Activity186Config:onConfigLoaded(configName, configTable)
	local funcName = string.format("_on%sLoad", configName)

	if self[funcName] then
		self[funcName](self, configTable)
	end
end

function Activity186Config:_onactvity186_stageLoad(configTable)
	self.stageConfig = configTable
end

function Activity186Config:_onactvity186_mini_game_rewardLoad(configTable)
	self.gameRewardConfig = configTable
end

function Activity186Config:_onactvity186_milestone_bonusLoad(configTable)
	self.mileStoneConfig = configTable
end

function Activity186Config:_onactivity186_constLoad(configTable)
	self.constConfig = configTable
end

function Activity186Config:_onactvity186_mini_game_questionLoad(configTable)
	self.questionConfig = configTable
end

function Activity186Config:_onactvity186_taskLoad(configTable)
	self.taskConfig = configTable
end

function Activity186Config:_onactvity186_voiceLoad(configTable)
	self.voiceConfig = configTable
end

function Activity186Config:getStageConfig(actId, stage)
	local dict = self.stageConfig.configDict[actId]

	return dict and dict[stage]
end

function Activity186Config:getGameRewardConfig(gameType, rewardId)
	local dict = self.gameRewardConfig.configDict[gameType]

	return dict and dict[rewardId]
end

function Activity186Config:getMileStoneList(actId)
	local dict = self.mileStoneConfig.configDict[actId]
	local list = {}

	for k, v in pairs(dict) do
		table.insert(list, v)
	end

	table.sort(list, SortUtil.keyLower("coinNum"))

	return list
end

function Activity186Config:getMileStoneConfig(actId, rewardId)
	local dict = self.mileStoneConfig.configDict[actId]

	return dict and dict[rewardId]
end

function Activity186Config:getVoiceConfig(type, verifyCallback)
	local result = {}

	for _, v in pairs(self.voiceConfig.configList) do
		if v.type == type and (not verifyCallback or verifyCallback(v)) then
			table.insert(result, v)
		end
	end

	return result
end

function Activity186Config:getTaskConfig(taskId)
	return self.taskConfig.configDict[taskId]
end

function Activity186Config:getNextQuestion(actId, questionId)
	local dict = self.questionConfig.configDict[actId]
	local list = {}

	for k, v in pairs(dict) do
		table.insert(list, v)
	end

	if #list > 1 then
		table.sort(list, SortUtil.keyLower("sort"))
	end

	local index

	for i, v in ipairs(list) do
		if v.id == questionId then
			index = i

			break
		end
	end

	if index == nil then
		local index = math.random(1, #list)

		return list[index]
	else
		local nextIndex = index + 1

		if nextIndex > #list then
			nextIndex = 1
		end

		return list[nextIndex]
	end
end

function Activity186Config:getQuestionConfig(actId, questionId)
	local dict = self.questionConfig.configDict[actId]

	return dict and dict[questionId]
end

function Activity186Config:getConstNum(activityId, constId)
	local constStr = self:getConstStr(activityId, constId)

	if string.nilorempty(constStr) then
		return 0
	else
		return tonumber(constStr)
	end
end

function Activity186Config:getConstStr(activityId, constId)
	local constDict = self.constConfig.configDict[activityId]
	local constCO = constDict and constDict[constId]

	if not constCO then
		return nil
	end

	local value = constCO.value

	if not string.nilorempty(value) then
		return value
	end

	return constCO.value2
end

function Activity186Config:isRefreshTask(taskId)
	local taskCo = self:getTaskConfig(taskId)
	local loopType = taskCo and taskCo.loopType

	return loopType == Activity186Enum.LoopType.Day or loopType == Activity186Enum.LoopType.Week
end

Activity186Config.instance = Activity186Config.New()

return Activity186Config
