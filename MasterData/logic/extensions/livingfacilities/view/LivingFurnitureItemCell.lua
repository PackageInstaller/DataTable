-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFurnitureItemCell.lua

module("logic.extensions.livingfacilities.view.LivingFurnitureItemCell", package.seeall)

local ButtonAdapter = Astral.ButtonAdapter
local M = class("LivingFurnitureItemCell")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	self._iconImg = self._viewElementsRegistry:findUIElement("live_furniture_item1_-1382664537", UIComponentType.Image)
	self._goLock = self._viewElementsRegistry:findUIElement("live_furniture_item1_-1142577057")
	self._btnClick = ButtonAdapter.Get(self._viewElementsRegistry:findUIElement("live_furniture_item1_-1195529894"))
end

function M:_clickSelf()
	local type = self._data:getItemMarkType()
	local passEvent = false

	GlobalDispatcher:dispatchEvent(type, self._data, self._go, self._index, true, passEvent)
end

function M:setCellData(data, index)
	self._data = data
	self._index = index

	self._btnClick:AddClickListener(self._clickSelf, self)
	self:refreshView()
end

function M:refreshView()
	IconLoader.setSprite(self._iconImg, IconType.Furniture, self._data:getIcon())
end

function M:setLockStatus(status)
	goutil.setActive(self._goLock, status)
end

function M:onExit()
	self._btnClick:RemoveClickListener()
end

function M:onDestroy()
	self._btnClick = nil
	self._data = nil
	self._index = nil
end

return M
