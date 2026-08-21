-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/view/ChamberSlotItem.lua

module("logic.extensions.chamber.view.ChamberSlotItem", package.seeall)

local M = class("ChamberSlotItem")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject
	self._index = 0
	self._itemData = nil

	self:_buildUI()
end

function M:OnDestroy()
	self._btnClick:RemoveClickListener()

	self._clickCallback = nil
	self._clickTarget = nil

	self._longPressTrigger:RemoveLongPressListener()
end

function M:_buildUI()
	self._goAdd = goutil.findChild(self._mainGO, "add")

	local itemGO = goutil.findChild(self._mainGO, "backpack_item")

	self._item = Astral.SimpleLuaComponentContainer.Add(itemGO, BackpackItemCell)

	self._item:getComponent("normal"):setClickListener(self._onClickChamberItem, self)

	self._goSelected = goutil.findChild(self._mainGO, "select")

	local clickGO = goutil.findChild(self._mainGO, "click")

	self._btnClick = Astral.UIClickTrigger.Get(clickGO)

	self._btnClick:AddClickListener(self._onClick, self)

	self._longPressTrigger = OnceLongPressTrigger.Get(clickGO)

	self._longPressTrigger:AddLongPressListener(self._onOnceLongPress, self)
end

function M:_onClick()
	if self._clickCallback then
		self._clickCallback(self._clickTarget, self._index)
	end
end

function M:_onOnceLongPress(isOn, x, y)
	if self._itemData then
		local data = ToolTipsUtil.createItemTipsData(self._itemData, self._mainGO)

		ToolTipsMgr.showTips(data.viewName, data)
	end
end

function M:setIndex(idx)
	self._index = idx
end

function M:getIndex()
	return self._index
end

function M:setItemUUID(itemUUID)
	self._itemData = nil

	if itemUUID then
		goutil.setActive(self._item._go, true)
		goutil.setActive(self._goAdd, false)

		local itemData = ItemModel.instance:getItemDataByUuid(tostring(itemUUID))

		self._item:updateData(itemData)
		self._item:getComponent("num"):setVisible(false)

		self._itemData = itemData
	else
		goutil.setActive(self._item._go, false)
		goutil.setActive(self._goAdd, true)
	end
end

function M:setSelected(select)
	goutil.setActive(self._goSelected, select)
end

function M:setClickCallback(callback, target)
	self._clickCallback = callback
	self._clickTarget = target
end

function M:_onClickChamberItem()
	return
end

return M
