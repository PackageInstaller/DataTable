-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/hotgoods/StoreHotListViewItem1.lua

module("logic.extensions.store.view.hotgoods.StoreHotListViewItem1", package.seeall)

local M = class("StoreHotListViewItem1")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self.id = UIDUtil.getEventUID()
end

function M:Awake()
	self._goItem1 = goutil.findChild(self._go, "cell1")
	self._goItem2 = goutil.findChild(self._go, "cell2")
	self._item1 = Astral.LuaComponentContainer.Add(self._goItem1, StoreHotListViewCell)
	self._item2 = Astral.LuaComponentContainer.Add(self._goItem2, StoreHotListViewCell)
end

function M:SetItemData(itemData1, itemData2, itemIndex1, itemIndex2)
	goutil.setActive(self._goItem1, itemData1 ~= nil)
	goutil.setActive(self._goItem2, itemData2 ~= nil)

	if itemData1 then
		self._item1.view = self.view

		self._item1:SetItemData(itemData1, itemIndex1)
	end

	if itemData2 then
		self._item2.view = self.view

		self._item2:SetItemData(itemData2, itemIndex2)
	end
end

function M:setEvent(add)
	if self._item1 then
		self._item1:setEvent(add)
	end

	if self._item2 then
		self._item2:setEvent(add)
	end
end

function M:OnDestroy()
	return
end

return M
