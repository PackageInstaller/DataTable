-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/hotgoods/StoreHotListViewItem2.lua

module("logic.extensions.store.view.hotgoods.StoreHotListViewItem2", package.seeall)

local M = class("StoreHotListViewItem2", StoreHotListViewCell)
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self.id = UIDUtil.getEventUID()
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._btnBuyClick = ButtonAdapter.Get(registry:findUIElement("store_hot_list_item_1933081139"))

	self._btnBuyClick:AddClickListener(self._clickSelf, self)

	self._itemIcon = registry:findUIElement("store_hot_list_item_-1803334145", UIComponentType.Image)
	self._itemQuality = registry:findUIElement("store_hot_list_item_1544169131", UIComponentType.Image)
	self._doubleHintSign = registry:findUIElement("store_hot_list_item_-544790487")
	self._txtDoubleHint = registry:findUIElement("store_hot_list_item_1053097440", UIComponentType.Text)
	self._txtPrice1 = registry:findUIElement("store_hot_list_item_856295982", UIComponentType.Text)
	self._txtOriginalPrice1 = registry:findUIElement("store_hot_list_item_-1611026884", UIComponentType.Text)
	self._txtPrice2 = registry:findUIElement("store_hot_list_item_-898363160", UIComponentType.Text)
	self._imgCostIcon = registry:findUIElement("store_hot_list_item_2023859428", UIComponentType.Image)
	self._goPrice2 = registry:findUIElement("store_hot_list_item_-898363160")
	self._goSellOut = registry:findUIElement("store_hot_list_item2_1700125439")
	self._txtName = registry:findUIElement("store_hot_list_item_50551331", UIComponentType.Text)
	self._goAnimation = registry:findUIElement("store_hot_list_item2_-477083423")
	self._canvasGroupAnim = registry:findUIElement("store_hot_list_item2_-477083423", ComponentType.CanvasGroup)
	self._posX, self._posY = GameUtils.getLocalPos(self._goAnimation)

	goutil.setActive(self._txtOriginalPrice1.gameObject, false)
end

return M
