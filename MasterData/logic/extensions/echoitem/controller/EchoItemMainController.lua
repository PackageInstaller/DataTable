-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echoitem/controller/EchoItemMainController.lua

module("logic.extensions.echoitem.controller.EchoItemMainController", package.seeall)

local M = class("EchoItemMainController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._selectedEchoItem = nil
	self._availableEchoItem = BaseListModel.New()
	self._costEchoItemForBreakList = {}

	self:setIsUpgradingEcho(nil)
end

function M:setSelectedEchoItem(echoItemData)
	self._selectedEchoItem = echoItemData

	GlobalDispatcher:dispatchEvent(EventType.ECHO_ITEM_ON_SET_SELECT, self._selectedEchoItem)
end

function M:getSelectedEchoItem()
	return self._selectedEchoItem
end

function M:clearCostEchoItemForBreakList(isUpgrade)
	self._costEchoItemForBreakList = {}

	GlobalDispatcher:dispatchEvent(EventType.ECHO_ITEM_COST_FOR_BREAK_SELECT, self._costEchoItemForBreakList, isUpgrade)
end

function M:setCostEchoItemForBreak(echoItemData, isAddOrRemove)
	if not echoItemData then
		return
	end

	if not self._costEchoItemForBreakList then
		self._costEchoItemForBreakList = {}
	end

	if isAddOrRemove then
		local find = false

		for _, _echoItemData in pairs(self._costEchoItemForBreakList) do
			if _echoItemData:getUuid() == echoItemData:getUuid() then
				find = true
			end
		end

		if not find then
			table.insert(self._costEchoItemForBreakList, echoItemData)
		end
	else
		local index = -1

		for _i, _echoItemData in pairs(self._costEchoItemForBreakList) do
			if _echoItemData:getUuid() == echoItemData:getUuid() then
				index = _i
			end
		end

		if index > 0 then
			table.remove(self._costEchoItemForBreakList, index)
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.ECHO_ITEM_COST_FOR_BREAK_SELECT, self._costEchoItemForBreakList, false)
end

function M:getCostEchoItemForBreakList()
	return self._costEchoItemForBreakList
end

function M:getCostEchoItemForBreakSelectedCount()
	local list = self:getCostEchoItemForBreakList() or {}
	local num = 0

	for i = 1, #list do
		local count = list[i]:getToBreakTargetLevelNeed(list[i]:getLevel()) + 1

		num = num + count
	end

	return num
end

function M:getCostEchoItemForBreakUuidList()
	local uuidList = {}

	for _, _echoItemData in pairs(self:getCostEchoItemForBreakList() or {}) do
		table.insert(uuidList, _echoItemData:getUuid())
	end

	return uuidList
end

function M:getCostEchoItemForBreakIsHightLevel()
	local isHightLevel = false

	for _, _echoItemData in pairs(self:getCostEchoItemForBreakList() or {}) do
		if _echoItemData:getLevel() > 1 then
			isHightLevel = true
		end
	end

	return isHightLevel
end

function M:getCostEchoItemForBreakInPreinstallList()
	local list = {}

	for _, _echoItemData in pairs(self:getCostEchoItemForBreakList() or {}) do
		if CharacterPreinstallController.instance:getItemList(_echoItemData:getUuid()) then
			table.insert(list, _echoItemData)
		end
	end

	return list
end

function M:getIsItemSelectedForBreak(echoItemData)
	if not echoItemData then
		return false
	end

	local isSelected = false

	for _, _echoItemData in pairs(self:getCostEchoItemForBreakList() or {}) do
		if _echoItemData:getUuid() == echoItemData:getUuid() then
			isSelected = true
		end
	end

	return isSelected
end

function M:getAvailableEchoItem()
	self:updateAvailableEchoItem()

	return self._availableEchoItem
end

function M:updateAvailableEchoItem()
	self._availableEchoItem:clear()

	local echoItemMoList = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.EchoItemType)
	local selectedEchoItem = self:getSelectedEchoItem()

	if selectedEchoItem then
		local _uuid = selectedEchoItem:getUuid()
		local _id = selectedEchoItem:getId()

		for _, mo in ipairs(echoItemMoList) do
			if mo:getUuid() ~= _uuid and _id == mo:getId() then
				self._availableEchoItem:addMo(mo)
			end
		end
	end
end

function M:setIsUpgradingEcho(isUpgrading)
	self._isUpgradingEcho = isUpgrading
end

function M:getIsUpgradingEcho()
	return self._isUpgradingEcho
end

function M:getIsRecommendEcho(heroId, echoItemId)
	if not heroId or not echoItemId then
		return false
	end

	local isRecommend = false
	local cfg = CharacterConfig.instance:getCharacterItemInfo(heroId)
	local recommendLst = cfg and cfg.recommendEcho or {}

	if table.indexof(recommendLst, echoItemId) then
		isRecommend = true
	end

	return isRecommend
end

M.instance = M.New()

return M
