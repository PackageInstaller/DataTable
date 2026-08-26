-- chunkname: @modules/logic/sp01/act204/config/Activity204Config.lua

module("modules.logic.sp01.act204.config.Activity204Config", package.seeall)

local Activity204Config = class("Activity204Config", BaseConfig)

function Activity204Config:reqConfigNames()
	return {
		"activity204_const",
		"actvity204_stage",
		"actvity204_task",
		"actvity204_voice",
		"actvity204_milestone_bonus"
	}
end

function Activity204Config:onConfigLoaded(configName, configTable)
	local funcName = string.format("_on%sLoad", configName)

	if self[funcName] then
		self[funcName](self, configTable)
	end
end

function Activity204Config:_onactvity204_stageLoad(configTable)
	self.stageConfig = configTable
end

function Activity204Config:_onactvity204_milestone_bonusLoad(configTable)
	self.mileStoneConfig = configTable
end

function Activity204Config:_onactivity204_constLoad(configTable)
	self.constConfig = configTable
end

function Activity204Config:_onactvity204_taskLoad(configTable)
	self.taskConfig = configTable
end

function Activity204Config:_onactvity204_voiceLoad(configTable)
	self.voiceConfig = configTable
end

function Activity204Config:getStageConfig(actId, stage)
	local dict = self.stageConfig.configDict[actId]

	return dict and dict[stage]
end

function Activity204Config:getMileStoneList(actId)
	local dict = self.mileStoneConfig.configDict[actId]
	local list = {}

	for k, v in pairs(dict) do
		table.insert(list, v)
	end

	table.sort(list, SortUtil.keyLower("coinNum"))

	return list
end

function Activity204Config:getMileStoneConfig(actId, rewardId)
	local dict = self.mileStoneConfig.configDict[actId]

	return dict and dict[rewardId]
end

function Activity204Config:getVoiceConfig(type, verifyCallback)
	local result = {}

	for _, v in pairs(self.voiceConfig.configList) do
		if v.type == type and (not verifyCallback or verifyCallback(v)) then
			table.insert(result, v)
		end
	end

	return result
end

function Activity204Config:getTaskConfig(taskId)
	return self.taskConfig.configDict[taskId]
end

function Activity204Config:getConstNum(constId)
	local constStr = self:getConstStr(constId)

	if string.nilorempty(constStr) then
		return 0
	else
		return tonumber(constStr)
	end
end

function Activity204Config:getConstStr(constId)
	local constCO = self.constConfig.configDict[constId]

	if not constCO then
		return nil
	end

	local value = constCO.value

	if not string.nilorempty(value) then
		return value
	end

	return constCO.value2
end

Activity204Config.instance = Activity204Config.New()

return Activity204Config
