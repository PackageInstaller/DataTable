-- chunkname: @modules/logic/rouge/config/RougeRewardConfig.lua

module("modules.logic.rouge.config.RougeRewardConfig", package.seeall)

local RougeRewardConfig = class("RougeRewardConfig", BaseConfig)

function RougeRewardConfig:reqConfigNames()
	return {
		"rouge_reward",
		"rouge_reward_stage"
	}
end

function RougeRewardConfig:onInit()
	self._rewardDict = {}
	self._rewardList = {}
	self._stageRewardDict = nil
	self._bigRewardToStage = {}
	self._stageToLayout = {}
end

function RougeRewardConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge_reward_stage" then
		self._stageRewardDict = configTable.configDict

		for key, value in ipairs(configTable.configList) do
			if value.bigRewardId then
				if self._bigRewardToStage[value.bigRewardId] == nil then
					self._bigRewardToStage[value.bigRewardId] = {}
				end

				table.insert(self._bigRewardToStage[value.bigRewardId], value)
			end
		end
	end

	if configName == "rouge_reward" then
		for key, value in ipairs(configTable.configList) do
			if value.stage then
				if self._rewardDict[value.stage] == nil then
					self._rewardDict[value.stage] = {}
				end

				table.insert(self._rewardDict[value.stage], value)
			end
		end

		self._rewardList = configTable.configDict
	end

	self:_buildRewardByLayout()
end

function RougeRewardConfig:_buildRewardByLayout()
	for stage, dict in ipairs(self._rewardDict) do
		if #dict ~= 0 then
			if self._stageToLayout[stage] == nil then
				self._stageToLayout[stage] = {}
			end

			for index, co in ipairs(dict) do
				if co.pos and co.pos ~= "" then
					local temp = string.split(co.pos, "#")
					local y = tonumber(temp[1])

					if self._stageToLayout[stage][y] == nil then
						self._stageToLayout[stage][y] = {}
					end

					if not tabletool.indexOf(self._stageToLayout[stage][y], co) then
						table.insert(self._stageToLayout[stage][y], co)
					end
				end
			end
		end
	end
end

function RougeRewardConfig:getStageToLayourConfig(stage, layout)
	return self._stageToLayout[stage][layout]
end

function RougeRewardConfig:getRewardDict()
	return self._rewardDict
end

function RougeRewardConfig:getConfigById(season, id)
	return self._rewardList[season][id]
end

function RougeRewardConfig:getRewardStageDictNum(stage)
	return #self._rewardDict[stage]
end

function RougeRewardConfig:getConfigByStage(stage)
	if self._rewardDict and self._rewardDict[stage] then
		return self._rewardDict[stage]
	end
end

function RougeRewardConfig:getConfigByStageAndId(stage, id)
	if self._rewardDict and self._rewardDict[stage] then
		return self._rewardDict[stage][id]
	end
end

function RougeRewardConfig:getBigRewardConfigByStage(stage)
	if self._rewardDict and self._rewardDict[stage] then
		for index, co in ipairs(self._rewardDict[stage]) do
			if co and co.type == 1 then
				return co
			end
		end
	end
end

function RougeRewardConfig:getStageCount()
	return #self._rewardDict
end

function RougeRewardConfig:getStageLayoutCount(stage)
	return #self._stageToLayout[stage]
end

function RougeRewardConfig:getPointLimitByStage(season, stage)
	local config = self:getStageRewardConfigById(season, stage)

	return config.pointLimit
end

function RougeRewardConfig:getNeedUnlockNum(stage)
	local dict = self:getConfigByStage(stage)
	local num = 0

	if dict then
		for index, value in ipairs(dict) do
			if value.type and value.type == 2 then
				num = num + 1
			end
		end
	end

	return num
end

function RougeRewardConfig:getCurStageBigRewardConfig(stage)
	local coList = self:getConfigByStage(stage)

	if not coList then
		return
	end

	for _, co in ipairs(coList) do
		if co and co.type == 1 then
			return co
		end
	end
end

function RougeRewardConfig:getStageRewardCount(season)
	return #self._stageRewardDict[season]
end

function RougeRewardConfig:getStageRewardConfig(season)
	return self._stageRewardDict[season]
end

function RougeRewardConfig:getStageRewardConfigById(season, id)
	return self._stageRewardDict[season][id]
end

function RougeRewardConfig:getBigRewardToStageConfigById(bigRewardId)
	return self._bigRewardToStage[bigRewardId]
end

function RougeRewardConfig:getBigRewardToStage()
	return self._bigRewardToStage
end

RougeRewardConfig.instance = RougeRewardConfig.New()

return RougeRewardConfig
