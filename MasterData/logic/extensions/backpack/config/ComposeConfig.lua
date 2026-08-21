-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/config/ComposeConfig.lua

module("logic.extensions.backpack.config.ComposeConfig", package.seeall)

local M = class("ComposeConfig", BaseConfig)

function M:onInit()
	return
end

function M:getNames()
	return {
		ConfigName.ItemCompose
	}
end

function M:getConfigById(id)
	local dataList = self._dict[ConfigName.ItemCompose].dataList

	for i, v in ipairs(dataList) do
		if id == v.sourceId then
			return v
		end
	end

	printError(string.format("getConfigById,no config co in t_item_compose id: %s", id))

	return false
end

M.instance = M.New()

return M
