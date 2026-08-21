-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/config/EchoCardPackConfig.lua

module("logic.extensions.echocardpack.config.EchoCardPackConfig", package.seeall)

local M = class("EchoCardPackConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.EchoLotteryPool,
		ConfigName.EchoLotteryPoolDetail,
		ConfigName.EchoLotteryEquipmentGroup,
		ConfigName.EchoLotteryEquipmentExtraReward
	}
end

function M:getCommonEchoCardCostItemId()
	local cfgs = self._dict[ConfigName.EchoLotteryPool].dataList

	for i = 1, #cfgs do
		if cfgs[i].campType == 1 then
			return cfgs[i].cost
		end
	end

	return 0
end

function M:getEchoLotteryPoolList()
	return self._dict[ConfigName.EchoLotteryPool].dataList
end

function M:getEchoPoolGroupCodes(poolCode)
	local list = self._dict[ConfigName.EchoLotteryPoolDetail].dataList
	local groupCodes = {}

	for i = 1, #list do
		if list[i].poolCode == poolCode then
			groupCodes[list[i].groupCode] = list[i].groupCode
		end
	end

	return groupCodes
end

function M:getEchoPoolItemInfos(groupCodes)
	local list = self._dict[ConfigName.EchoLotteryEquipmentGroup].dataList

	groupCodes = groupCodes or {}

	local infos = {}

	for i = 1, #list do
		local data = list[i]

		if groupCodes[data.groupCode] then
			table.insert(infos, {
				itemId = data.itemCode,
				isUp = data.floatWeight > 0
			})
		end
	end

	return infos
end

M.instance = M.New()

return M
