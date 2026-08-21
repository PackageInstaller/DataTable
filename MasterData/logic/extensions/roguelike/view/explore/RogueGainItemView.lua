-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueGainItemView.lua

module("logic.extensions.roguelike.view.explore.RogueGainItemView", package.seeall)

local M = class("RogueGainItemView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._contentGo = false
	self._btnClose = false
	self._emptyRaycast = false
end

function M:buildUI()
	self._contentGo = self:getGo("gain_item_1182321935")
	self._btnClose = self:getBtn("gain_item_-980585392")
	self._emptyRaycast = self:getUIComponent("gain_item_1178808476", UIComponentType.EmptyRaycast)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.checkClose, self)
end

function M:checkClose()
	self:close()

	if self._closeCallback then
		self._closeCallback()
	end
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	local itemListData = self:getFirstParam()

	self._closeCallback = self:getOpenParam()[2]

	local itemGo, cell = false, false
	local len = itemListData and #itemListData or 0

	self._emptyRaycast.enabled = len > 10

	for k, v in pairs(itemListData) do
		itemGo = self:getResInstance(ResName.Gainitem_gain_item)
		cell = Astral.LuaComponentContainer.Add(itemGo, RoguePropItem)
		v.showName = true

		cell:updateData(v)
		goutil.addChildToParent(itemGo, self._contentGo)
	end
end

function M:onExit()
	goutil.clearChildren(self._contentGo)
end

function M:_onClickClose()
	self:close()
end

return M
