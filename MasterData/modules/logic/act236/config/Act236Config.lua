-- chunkname: @modules/logic/act236/config/Act236Config.lua

module("modules.logic.act236.config.Act236Config", package.seeall)

local Act236Config = class("Act236Config", BaseConfig)

function Act236Config:reqConfigNames()
	return {
		"activity236"
	}
end

function Act236Config:onInit()
	self.rewardConfigListDic = nil
end

function Act236Config:onConfigLoaded(configName, configTable)
	if configName == "activity236" then
		self.rewardConfig = configTable
	end
end

function Act236Config:getRewardConfigById(id)
	if not self.rewardConfig then
		return nil
	end

	return self.rewardConfig.configDict[id]
end

function Act236Config:getRewardConfigListById(actId)
	if not self.rewardConfigListDic then
		self.rewardConfigListDic = {}

		for _, config in ipairs(self.rewardConfig.configList) do
			self.rewardConfigListDic[config.activityId] = self.rewardConfigListDic[config.activityId] or {}

			local singleList = self.rewardConfigListDic[config.activityId]

			table.insert(singleList, config)
		end
	end

	return self.rewardConfigListDic[actId]
end

Act236Config.instance = Act236Config.New()

return Act236Config
