-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/config/ItemCommonSortConfig.lua

module("logic.extensions.common.config.ItemCommonSortConfig", package.seeall)

local M = class("ItemCommonSortConfig", BaseConfig)

function M:onInit()
	return
end

function M:getNames()
	return {
		ConfigName.ItemCommonSort
	}
end

function M:getSortList(sortType)
	return self._dict[ConfigName.ItemCommonSort][sortType].sortList
end

M.instance = M.New()

return M
