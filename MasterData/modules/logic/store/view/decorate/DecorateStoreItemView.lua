-- chunkname: @modules/logic/store/view/decorate/DecorateStoreItemView.lua

module("modules.logic.store.view.decorate.DecorateStoreItemView", package.seeall)

local DecorateStoreItemView = class("DecorateStoreItemView", LuaCompBase)

function DecorateStoreItemView.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DecorateStoreItemView)
end

function DecorateStoreItemView:init(go)
	self.go = go
	self._prefabLoader = PrefabInstantiate.Create(self.go)

	self:_addEvents()
end

function DecorateStoreItemView:_addEvents()
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, self._refreshItems, self)
end

function DecorateStoreItemView:_removeEvents()
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, self._refreshItems, self)
end

function DecorateStoreItemView:_onClick(index)
	local itemCo = self._items[index]

	MaterialTipController.instance:showMaterialInfo(itemCo.materialType, itemCo.materialId)
end

function DecorateStoreItemView:refresh(items)
	self._items = items
	self._itemTabs = {}

	self:_refresh()
end

function DecorateStoreItemView:_refresh()
	if not self._goview then
		UIBlockMgr.instance:startBlock("waitloaditemview")
		self._prefabLoader:startLoad(DecorateStoreItemView.prefabPath, self._onLoadResDone, self)
	else
		self:_refreshItems()
	end
end

function DecorateStoreItemView:_onLoadResDone(loader)
	UIBlockMgr.instance:endBlock("waitloaditemview")

	self._goview = self._prefabLoader:getInstGO()
	self._gocontainer = gohelper.findChild(self._goview, "#go_container")
	self._goitem = gohelper.findChild(self._goview, "#go_container/#go_item")

	self:_refreshItems()
end

function DecorateStoreItemView:_refreshItems()
	gohelper.setActive(self._goview, self._items and #self._items > 0)

	if not self._items then
		return
	end

	if #self._itemTabs > #self._items then
		for i = #self._items + 1, #self._itemTabs do
			gohelper.setActive(self._itemTabs[i].go, false)
		end
	end

	for index, itemCo in ipairs(self._items) do
		if not self._itemTabs[index] then
			self._itemTabs[index] = {}
			self._itemTabs[index].go = gohelper.cloneInPlace(self._goitem)
			self._itemTabs[index].btn = gohelper.findChildButtonWithAudio(self._itemTabs[index].go, "btn_item")
			self._itemTabs[index].imageicon = gohelper.findChildImage(self._itemTabs[index].go, "btn_item/image_icon")
			self._itemTabs[index].txtnum = gohelper.findChildText(self._itemTabs[index].go, "btn_item/content/txt_num")

			self._itemTabs[index].btn:AddClickListener(self._onClick, self, index)
		end

		self:_refreshItem(self._itemTabs[index], itemCo)
	end
end

function DecorateStoreItemView:_refreshItem(itemTab, itemCo)
	gohelper.setActive(itemTab.go, true)

	local itemConfig, _ = ItemModel.instance:getItemConfigAndIcon(itemCo.materialType, itemCo.materialId)

	UISpriteSetMgr.instance:setCurrencyItemSprite(itemTab.imageicon, itemConfig.icon .. "_1", true)

	itemTab.txtnum.text = ItemModel.instance:getItemQuantity(itemCo.materialType, itemCo.materialId)
end

function DecorateStoreItemView:destroy()
	UIBlockMgr.instance:endBlock("waitloaditemview")
	MonoHelper.removeLuaComFromGo(self.go, DecorateStoreItemView)

	if self._prefabLoader then
		self._prefabLoader:dispose()

		self._prefabLoader = nil
	end

	self:_removeEvents()

	if self._itemTabs then
		for _, itemTab in pairs(self._itemTabs) do
			itemTab.btn:RemoveClickListener()
		end

		self._itemTabs = nil
	end
end

DecorateStoreItemView.prefabPath = "ui/viewres/store/decorateitemview.prefab"

return DecorateStoreItemView
