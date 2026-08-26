-- chunkname: @modules/logic/sp01/assassinChase/config/AssassinChaseConfig.lua

module("modules.logic.sp01.assassinChase.config.AssassinChaseConfig", package.seeall)

local AssassinChaseConfig = class("AssassinChaseConfig", BaseConfig)

function AssassinChaseConfig:reqConfigNames()
	return {
		"activity206_const",
		"activity206_reward_direction",
		"activity206_reward_group",
		"activity206_reward",
		"activity206_dialogue",
		"activity206_desc"
	}
end

function AssassinChaseConfig:onInit()
	self._dialogueConfigListDic = {}
end

function AssassinChaseConfig:onConfigLoaded(configName, configTable)
	if configName == "activity206_const" then
		self._constConfig = configTable
	elseif configName == "activity206_reward_direction" then
		self._rewardDirectionConfig = configTable
	elseif configName == "activity206_reward_group" then
		self._rewardGroupConfig = configTable
	elseif configName == "activity206_reward" then
		self._rewardConfig = configTable
	elseif configName == "activity206_dialogue" then
		self._dialogueConfig = configTable
	elseif configName == "activity206_desc" then
		self._descConfig = configTable
	end
end

function AssassinChaseConfig:getDescConfig(activityId, stageId)
	if self._descConfig == nil or self._descConfig.configDict[activityId] == nil then
		return nil
	end

	return self._descConfig.configDict[activityId][stageId]
end

function AssassinChaseConfig:getConstConfig(constId)
	if not self._constConfig then
		return nil
	end

	return self._constConfig.configDict[constId]
end

function AssassinChaseConfig:getRewardConfig(rewardId)
	if not self._rewardConfig then
		return nil
	end

	return self._rewardConfig.configDict[rewardId]
end

function AssassinChaseConfig:getDirectionConfig(activityId, directionId)
	if self._rewardDirectionConfig == nil or self._rewardDirectionConfig.configDict[activityId] == nil then
		return nil
	end

	return self._rewardDirectionConfig.configDict[activityId][directionId]
end

function AssassinChaseConfig:getDialogueConfigList(activityId)
	if not self._dialogueConfigListDic or not self._dialogueConfig.configDict[activityId] then
		return nil
	end

	if not self._dialogueConfigListDic[activityId] then
		local dialogConfigList = {}
		local configDic = self._dialogueConfig.configDict[activityId]

		for _, config in pairs(configDic) do
			table.insert(dialogConfigList, config)
		end

		table.sort(dialogConfigList, self.sortDialogueConfigList)

		self._dialogueConfigListDic[activityId] = dialogConfigList
	end

	return self._dialogueConfigListDic[activityId]
end

function AssassinChaseConfig.sortDialogueConfigList(a, b)
	return a.chaseId < b.chaseId
end

AssassinChaseConfig.instance = AssassinChaseConfig.New()

return AssassinChaseConfig
