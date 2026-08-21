-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/hotgoods/StoreHotListViewCFCell.lua

module("logic.extensions.store.view.hotgoods.StoreHotListViewCFCell", package.seeall)

local M = class("StoreHotListViewCFCell", StoreHotListViewCell)
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

	self._btnBuyClick = ButtonAdapter.Get(registry:findUIElement("store_hot_list_cf_cell_1562181289"))

	self._btnBuyClick:AddClickListener(self._clickSelf, self)

	self._itemIcon = registry:findUIElement("store_hot_list_cf_cell_1809875269", UIComponentType.Image)
	self._itemQuality = registry:findUIElement("store_hot_list_cf_cell_539373595", UIComponentType.Image)
	self._doubleHintSign = registry:findUIElement("store_hot_list_cf_cell_-240931661")
	self._txtDoubleHint = registry:findUIElement("store_hot_list_cf_cell_283146618", UIComponentType.Text)
	self._txtPrice1 = registry:findUIElement("store_hot_list_cf_cell_489590452", UIComponentType.Text)
	self._txtOriginalPrice1 = registry:findUIElement("store_hot_list_cf_cell_-1310905690", UIComponentType.Text)
	self._txtPrice2 = registry:findUIElement("store_hot_list_cf_cell_-464481166", UIComponentType.Text)
	self._txtFree = registry:findUIElement("store_hot_list_cf_cell_-670751713", UIComponentType.Text)
	self._imgCostIcon = registry:findUIElement("store_hot_list_cf_cell_1451565182", UIComponentType.Image)
	self._goSellOut = registry:findUIElement("store_hot_list_cf_cell_-71576604")
	self._txtName = registry:findUIElement("store_hot_list_cf_cell_757587641", UIComponentType.Text)
	self._goAnimation = registry:findUIElement("store_hot_list_cf_cell_34209313")
	self._canvasGroupAnim = registry:findUIElement("store_hot_list_cf_cell_34209313", ComponentType.CanvasGroup)
	self._posX, self._posY = GameUtils.getLocalPos(self._goAnimation)

	goutil.setActive(self._txtOriginalPrice1.gameObject, false)
end

return M
