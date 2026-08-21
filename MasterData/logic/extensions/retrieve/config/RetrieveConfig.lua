-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/config/RetrieveConfig.lua

module("logic.extensions.retrieve.config.RetrieveConfig", package.seeall)

local M = class("RetrieveConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.LotteryPool,
		ConfigName.LotteryPoolDetail,
		ConfigName.LotteryHeroGroup,
		ConfigName.LotteryEquipGroup,
		ConfigName.LotteryMojitu,
		ConfigName.LotteryKeyWord,
		ConfigName.LotteryResult,
		ConfigName.LotteryHeroExtraReward,
		ConfigName.LotteryEchoExtraReward,
		ConfigName.LotteryKeyWordPos,
		ConfigName.LotteryAudio
	}
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

	if cfg and cfg[key] then
		return cfg[key]
	end

	printError(string.format("在表：t_%s中找不到对应配置,%s", cfgName, key))
end

function M:getMojituByGroupAndKey(groupId, key)
	local cfg = self:getConfig(ConfigName.LotteryMojitu)

	if cfg then
		return cfg[groupId][key]
	end
end

function M:getKeyWordPosByRandom()
	local dataList = self:getConfigList(ConfigName.LotteryKeyWordPos)
	local index = math.random(1, #dataList)

	return dataList[index] and dataList[index].posInfo or false
end

M.instance = M.New()

return M
