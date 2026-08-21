-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/recommend/StoreAdvertisingItem.lua

module("logic.extensions.store.view.recommend.StoreAdvertisingItem", package.seeall)

local StoreAdvertisingItem = class("StoreAdvertisingItem")
local ButtonAdapter = Astral.ButtonAdapter

function StoreAdvertisingItem:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function StoreAdvertisingItem:Awake()
	local registry = self._viewElementsRegistry

	self._txtDesc = registry:findUIElement("store_advertising_item_-551272406", UIComponentType.Text)
	self._btnClick = ButtonAdapter.Get(registry:findUIElement("store_advertising_item_1465209649"))

	self._btnClick:AddClickListener(self._clickSelf, self)
end

function StoreAdvertisingItem:_clickSelf()
	if self._clickCallBack then
		self._clickCallBack(self._handler, self._data.code)
	end
end

function StoreAdvertisingItem:setCellData(data)
	self._data = data
	self._txtDesc.text = data.tipContent
end

function StoreAdvertisingItem:setClickCallBack(fun, handle)
	self._clickCallBack = fun
	self._handler = handle
end

function StoreAdvertisingItem:_onImageGuideLoaded()
	return
end

function StoreAdvertisingItem:OnDestroy()
	self._txtDesc = nil

	self._btnClick:RemoveClickListener()

	self._btnClick = nil
	self._compContainer = nil
	self._go = nil
	self._viewElementsRegistry = nil
end

return StoreAdvertisingItem
