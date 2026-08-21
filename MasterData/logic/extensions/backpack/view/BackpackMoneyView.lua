-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackMoneyView.lua

module("logic.extensions.backpack.view.BackpackMoneyView", package.seeall)

local M = class("BackpackMoneyView", MoneyView)
local CurrencyCodeEnum = CommEnum.CurrencyCodeEnum

function M:ctor()
	M.super.ctor(self, CommEnum.MoneyShowType.BackpackShowType)
end

function M:bindEvents()
	M.super.bindEvents(self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._onBackpackPageDataChanged, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._onBackpackPageDataChanged, self)
end

local HideTypes = {
	[CommEnum.MainBackpackShowType.EchoShowType] = true,
	[CommEnum.MainBackpackShowType.EquipShowType] = true,
	[CommEnum.MainBackpackShowType.D6ShowType] = true,
	[CommEnum.MainBackpackShowType.EchoCardPackType] = true
}

function M:_onBackpackPageDataChanged(e, changeType)
	local curShowType = MainBackpackModel.instance:getCurShowType()
	local moneyType = HideTypes[curShowType] and CommEnum.MoneyShowType.DefaultHideType or CommEnum.MoneyShowType.BackpackShowType

	self:_handleOnUpdateMoneyViewShow(nil, moneyType)
	self:_refreshCapacity(curShowType)
end

local HideCapacityTypes = {
	[CommEnum.MainBackpackShowType.PropShowType] = true,
	[CommEnum.MainBackpackShowType.CurrencyShowType] = true,
	[CommEnum.MainBackpackShowType.CardChipShowType] = true,
	[CommEnum.MainBackpackShowType.EchoCardPackType] = true
}

function M:_refreshCapacity(curShowType)
	if HideCapacityTypes[curShowType] then
		self._capacityTrs.gameObject:SetActive(false)

		return
	end

	self._capacityTrs.gameObject:SetActive(true)

	local max = 0
	local has = #MainBackpackModel.instance:getCurShowTypeAllItems()

	if curShowType == CommEnum.MainBackpackShowType.EquipShowType then
		max = PlayerModel.instance:getBackpackLimit(GameEnum.ItemTypeEnum.EquipItemType, "EquipmentBackpackCapacity")
	elseif curShowType == CommEnum.MainBackpackShowType.EchoShowType then
		max = PlayerModel.instance:getBackpackLimit(GameEnum.ItemTypeEnum.EchoItemType, "EchoItemBackpackCapacity")
	elseif curShowType == CommEnum.MainBackpackShowType.D6ShowType then
		max = PlayerModel.instance:getBackpackLimit(GameEnum.ItemTypeEnum.DiceItem, "DiceBackpackCapacity")
	end

	self._txtCapacity.text = has .. "/" .. max
end

function M:clearCurrencyChildren()
	local trs = self._topCurrencyGo.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1).gameObject
		local matcher1 = string.match(child.name, "capacity")
		local matcher2 = string.match(child.name, "btnDecompose")

		if not matcher1 and not matcher2 then
			UnityEngine.GameObject.Destroy(child.gameObject)
		end
	end
end

function M:_createMoneyItem(codesDefine)
	M.super._createMoneyItem(self, codesDefine)

	local trs = self._topCurrencyGo.transform

	if not self._capacityTrs then
		self._capacityTrs = trs:Find("capacity")
		self._txtCapacity = goutil.findChildTextComponent(self._topCurrencyGo, "capacity/txtNum")
	end

	local count = trs.childCount

	self._capacityTrs:SetSiblingIndex(count - 1)
end

function M:_updateValue()
	M.super._updateValue(self)
end

return M
