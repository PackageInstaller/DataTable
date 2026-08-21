-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/model/BackpackBaseModel.lua

module("logic.extensions.backpack.model.BackpackBaseModel", package.seeall)

local M = class("BackpackBaseModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset(addEvent)
	self._curShowType = false
	self._filterCfgMap = {}
	self._baseFilter = false
	self._itemsMapBeforeFilter = {}
	self._curShowList = {}
	self._selectedItem = {}

	if addEvent then
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_LOADED, self._iniItemsData, self)
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_REMOVED_ONE, self._onRemoveItem, self)
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_ADDED_ONE, self._onAddItem, self)
	end
end

function M:setCurShowType(showType)
	self._curShowType = showType

	self:refilter()

	if not self._selectedItem[self._curShowType] then
		self:resetAutoSelect()
	end
end

function M:getCurShowType()
	return self._curShowType
end

function M:getCurFilterCfg()
	return self:getFilterCfg(self._curShowType)
end

function M:getCurShownItems()
	return self._curShowList or {}
end

function M:getCurShowTypeAllItems()
	return self._itemsMapBeforeFilter[self._curShowType] or {}
end

function M:getShowTypeAllItems(showType)
	return self._itemsMapBeforeFilter[showType] or {}
end

function M:getBackpackShowType(item)
	return
end

function M:refilter()
	local showType = self._curShowType
	local filter = self:getFilterCfg(showType)

	self._curShowList = filter:doFilter(self._itemsMapBeforeFilter[showType])

	ItemUtil.sortItemList(self._curShowList, showType, true)
end

function M:resetAutoSelect()
	self:refilter()

	if self._curShowList and #self._curShowList > 0 then
		self._selectedItem[self._curShowType] = self._curShowList[1]
	else
		self._selectedItem[self._curShowType] = false
	end
end

function M:checkItemChanged()
	if not self._itemModelChanged then
		return
	end

	self:refilter()

	self._itemModelChanged = false
end

function M:getFilterCfg(showType)
	return
end

function M:_iniItemsData()
	return
end

function M:_onAddItem(e, item)
	if self._baseFilter and not self._baseFilter:filterOneItem(item) then
		return
	end

	local showType = self:getBackpackShowType(item)

	if not showType then
		return
	end

	self._itemModelChanged = true

	if not self._itemsMapBeforeFilter[showType] then
		self._itemsMapBeforeFilter[showType] = {}
	end

	table.insert(self._itemsMapBeforeFilter[showType], item)
end

function M:_onRemoveItem(e, item)
	if self._baseFilter and not self._baseFilter:filterOneItem(item) then
		return
	end

	local showType = self:getBackpackShowType(item)

	if not showType or not self._itemsMapBeforeFilter[showType] then
		return false
	end

	self._itemModelChanged = true

	local uuid = item:getUuid()

	if uuid then
		TableUtil.removeByFun(self._itemsMapBeforeFilter[showType], uuid, function(itemF, uuidF)
			return itemF:getUuid() == uuidF
		end)
	end

	return showType
end

M.instance = M.New()

return M
