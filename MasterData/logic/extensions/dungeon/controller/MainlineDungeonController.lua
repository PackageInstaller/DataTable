-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/controller/MainlineDungeonController.lua

module("logic.extensions.dungeon.controller.MainlineDungeonController", package.seeall)

local M = class("MainlineDungeonController", BaseController)

function M:onInit()
	self._cacheItemMOList = {}
end

function M:onReset()
	self._cacheItemMOList = {}
end

function M:_isItemCache(code)
	for i, cacheItem in ipairs(self._cacheItemMOList) do
		if cacheItem:getItemId() == code then
			return cacheItem
		end
	end

	return false
end

function M:setCacheItemMOList(itemMoList)
	for _, item in ipairs(itemMoList) do
		if item:getType() ~= GameEnum.ItemTypeEnum.EchoItemType and item:getType() ~= GameEnum.ItemTypeEnum.HeroType then
			local cacheItem = self:_isItemCache(item:getItemId())

			if cacheItem then
				local count = cacheItem:getCount() + item:getCount()

				cacheItem:setCount(count)
			else
				table.insert(self._cacheItemMOList, item)
			end
		end
	end
end

function M:clearCacheItem()
	self._cacheItemMOList = {}
end

function M:popCacheItemMoList(callBackFun, callBackObj)
	if self:hasCacheItem() then
		GainItemController.instance:openView(self._cacheItemMOList, nil, nil, nil, false, callBackFun, callBackObj)
	end
end

function M:hasCacheItem()
	return #self._cacheItemMOList > 0
end

M.instance = M.New()

return M
