-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreNavItem.lua

module("logic.extensions.store.view.StoreNavItem", package.seeall)

local M = class("StoreNavItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self._bindTab = false
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._imgIconActive = registry:findUIElement("store_right_tab_-515049317", UIComponentType.Image)
	self._imgIconUnActive = registry:findUIElement("store_right_tab_-1833687789", UIComponentType.Image)
	self._txtNameActive = registry:findUIElement("store_right_tab_1966513608", UIComponentType.Text)
	self._txtNameUnActive = registry:findUIElement("store_right_tab_670267626", UIComponentType.Text)
	self._btnClick = ButtonAdapter.Get(registry:findUIElement("store_right_tab_780293735"))

	self._btnClick:AddClickListener(self._clickSelf, self)

	self._tab = registry:findUIElement("store_right_tab_780293735", UIComponentType.SpaceXToggle)
end

function M:_clickSelf()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._curIndex, self._btnData.code)
	end
end

function M:setSelectIndex(index)
	self._selectIndex = index
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:setCellData(btnData, index, group)
	self._curIndex = index
	self._btnData = btnData

	if not self._bindTab then
		self._bindTab = true

		self:_setTabGroup(group)
	end

	self._tab.IsOn = self._selectIndex == self._curIndex

	self:_updateCellInfo(btnData)
end

function M:_updateCellInfo(data)
	self._txtNameActive.text = data.name
	self._txtNameUnActive.text = data.name

	IconLoader.setSprite(self._imgIconActive, IconType.DynSpriteAtlas_Store, data.icon)
	IconLoader.setSprite(self._imgIconUnActive, IconType.DynSpriteAtlas_Store, data.icon)
end

function M:_setTabGroup(group)
	self._tab.ToggleGroup = group
end

function M:OnDestroy()
	self._compContainer = nil
	self._go = nil
	self._trs = nil
	self._viewElementsRegistry = nil

	IconLoader.clearSprite(self._imgIconActive)
	IconLoader.clearSprite(self._imgIconUnActive)

	self._imgIconActive = nil
	self._imgIconUnActive = nil
	self._txtNameActive = nil
	self._txtNameUnActive = nil

	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end

	self._btnClick = nil
	self._btnData = nil
	self._curIndex = nil
	self._tab = nil
	self._bindTab = false
end

return M
