-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/config/RewardConfig.lua

module("logic.extensions.dungeon.config.RewardConfig", package.seeall)

local M = class("RewardConfig", BaseConfig)

function M:onInit()
	self._cfgReward = false
	self._cfgRewardTag = false
end

function M:getNames()
	return {
		ConfigName.Reward,
		ConfigName.RewardTag
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.Reward then
		self._cfgReward = content
	elseif name == ConfigName.RewardTag then
		self._cfgRewardTag = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function M:getRewardCfgByCode(rewardCode)
	local rewardCO = self._cfgReward[rewardCode]

	return rewardCO
end

function M:getRewardTagByOptType(optType)
	local co = self._cfgRewardTag[optType]

	if not co then
		printError("找不到对应的J奖励表-export_标签显示的标签配置，optType：", optType)

		return false
	else
		return co
	end
end

function M:getAllRewardListCfgByCode(rewardCode)
	local rewardCO = self._cfgReward[rewardCode]
	local list = {}

	if not rewardCO then
		return list
	end

	if rewardCO.reward then
		for i, v in ipairs(rewardCO.reward) do
			table.insert(list, v)
		end
	end

	if rewardCO.randomReward1 then
		for i, v in ipairs(rewardCO.randomReward1) do
			table.insert(list, v)
		end
	end

	if rewardCO.randomReward2 then
		for i, v in ipairs(rewardCO.randomReward2) do
			table.insert(list, v)
		end
	end

	if rewardCO.randomReward3 then
		for i, v in ipairs(rewardCO.randomReward3) do
			table.insert(list, v)
		end
	end

	if rewardCO.independentRandomReward then
		for i, v in ipairs(rewardCO.independentRandomReward) do
			table.insert(list, v)
		end
	end

	return list
end

M.instance = M.New()

return M
