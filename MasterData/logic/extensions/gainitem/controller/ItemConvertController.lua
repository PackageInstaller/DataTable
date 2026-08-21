-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gainitem/controller/ItemConvertController.lua

module("logic.extensions.gainitem.controller.ItemConvertController", package.seeall)

local M = class("ItemConvertController", BaseController)

function M:ctor()
	M.super.ctor(self)

	self._optType = nil
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self:clearCache()
end

function M:clearCache()
	self._cacheSourceMOList = {}
	self._cacheItemMOList = {}
	self._optType = nil
end

local function _findCacheItemUuid(list, uuid)
	for i, item in ipairs(list) do
		if item:getUuid() == uuid then
			return item
		end
	end

	return false
end

local function _findCacheItemItemid(list, itemId)
	for i, item in ipairs(list) do
		if item:getItemId() == itemId then
			return item
		end
	end

	return false
end

local function _setCacheMOList(containerList, itemMoList)
	for i, item in ipairs(itemMoList) do
		local cacheItem = _findCacheItemItemid(containerList, item:getItemId())

		if item:getUuid() and item:getUuid() ~= 0 then
			cacheItem = _findCacheItemUuid(containerList, item:getUuid())
		end

		if cacheItem then
			local count = cacheItem:getCount() + item:getCount()

			cacheItem:setCount(count)
		else
			table.insert(containerList, item)
		end
	end
end

function M:setCacheItemMOList(itemMoList)
	_setCacheMOList(self._cacheItemMOList, itemMoList)
end

function M:setCacheSourceMOList(itemMoList)
	_setCacheMOList(self._cacheSourceMOList, itemMoList)
end

function M:setOptType(optType)
	self._optType = optType
end

function M:popCacheItemMoList()
	if #self._cacheItemMOList ~= 0 then
		ViewMgr.instance:open(ViewName.ItemConvert, self._cacheItemMOList)
	end
end

function M:hasCache()
	return #self._cacheItemMOList ~= 0
end

M.instance = M.New()

return M
